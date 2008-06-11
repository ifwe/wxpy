import gc
import wx
from weakref import ref

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

    b.Command(wx.CommandEvent(wx.EVT_COMMAND_BUTTON_CLICKED))

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

    b.Bind(wx.EVT_BUTTON, foo)
    b.Command(wx.CommandEvent(wx.EVT_COMMAND_BUTTON_CLICKED))
    assert count == 1

    b.Unbind(wx.EVT_BUTTON)
    b.Command(wx.CommandEvent(wx.EVT_COMMAND_BUTTON_CLICKED))
    assert count == 1

    # make sure the event handler doesn't hold a reference to foo still
    weakfoo = ref(foo)
    del foo
    gc.collect()
    assert weakfoo() is None

    return f

if __name__ == '__main__':
    a=wx.PySimpleApp()
    test_unbind()