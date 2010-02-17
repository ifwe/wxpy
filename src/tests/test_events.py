import gc
import wx
from weakref import ref

def button_event(event_object = None):
    evt = wx.CommandEvent(wx.EVT_COMMAND_BUTTON_CLICKED)
    if event_object is not None:
        evt.SetEventObject(event_object)

    return evt

def test_skip():
    e = wx.CommandEvent()

    e.Skip(True)
    assert e.Skipped and e.GetSkipped()

    e.Skip(False)
    assert not e.Skipped and not e.GetSkipped()

    e.SetId(42)
    assert e.Id == e.GetId() == 42

def test_bind():
    f = wx.Frame(None)
    b = wx.Button(f, -1, 'Button test')

    flags = dict(frame=False, button=False)

    def on_frame(e): flags['frame'] = True
    def on_button(e): flags['button'] = True

    b.Bind(wx.EVT_BUTTON, on_button)
    f.Bind(wx.EVT_BUTTON, on_frame)

    b.Command(button_event())

    assert flags['button'] == True

    f.Destroy()

def test_unbind():
    f = wx.Frame(None)
    b = wx.Button(f, -1, 'test')

    global count
    count = 0

    def foo(e):
        global count
        count = count + 1

    def push(): b.Command(button_event())

    b.Bind(wx.EVT_BUTTON, foo)
    push()
    assert count == 1

    weakfoo = ref(foo)
    del foo
    gc.collect()
    assert weakfoo() is not None


    b.Unbind(wx.EVT_BUTTON)
    push()
    assert count == 1

    # make sure the event handler doesn't hold a reference to foo still
    gc.collect()
    assert weakfoo() is None

    def handler1(e): f.last = 1
    def handler2(e): f.last = 2
    b.Bind(wx.EVT_BUTTON, handler1)
    b.Bind(wx.EVT_BUTTON, handler2)

    push()
    assert f.last == 2

    f.last = None

    b.Unbind(wx.EVT_BUTTON, -1, -1, handler2)
    push()
    assert f.last == 1

    # make sure Unbind doesn't leak refs
    weak = ref(handler2)
    del handler2
    gc.collect()
    assert weak() is None

    return f

def test_EventObject():
    f = wx.Frame(None)

    def foo(e): assert e.EventObject is f

    f.Bind(wx.EVT_BUTTON, foo)
    f.ProcessEvent(button_event(event_object = f))

    t=wx.TextCtrl(f)

    def bar(e): assert e.EventObject is t

    t.Bind(wx.EVT_TEXT, bar)
    t.SetValue('test')
    return f

def test_EventVeto():
    if False: # see note about GetVeto being disabled
        e = wx.CloseEvent()
        e.Veto(True)
        assert e.GetVeto()
        e.Veto(False)
        assert not e.GetVeto()
        assert callable(e.Veto)

if __name__ == '__main__':
    a=wx.PySimpleApp()
    test_unbind()
    #test_EventObject().Show()
    #a.MainLoop()

