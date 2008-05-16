#from __future__ import print_function

def p(*a):
    for z in a: print z,
    print

import wx

try:
    import sip
except ImportError:
    pass
else:
    class SipTrace(object):
        VIRTUAL      = 0x0001
        CONSTRUCTOR  = 0x0002
        DESTRUCTOR   = 0x0004
        PY_INIT      = 0x0008
        PY_DEL       = 0x0010
        PY_METHOD    = 0x0020

    SipTrace.ALL = (SipTrace.VIRTUAL | SipTrace.CONSTRUCTOR | SipTrace.DESTRUCTOR
                    | SipTrace.PY_INIT | SipTrace.PY_DEL | SipTrace.PY_METHOD)

    sip.settracemask(SipTrace.ALL)

def main():
    a = wx.PySimpleApp()
    f = wx.Frame(None, -1, 'test', size = (300, 500))
    sip.dump(f)

    f.Title = str(f.Handle)

    f.Bind(wx.EVT_SIZE, lambda e: p(f.Size))
    f.Bind(wx.EVT_MOVE, lambda e: p(f.Position))

    f.Sizer = sizer = wx.BoxSizer(wx.VERTICAL)

    N = 5
    ids = {}
    buttons = []
    for x in xrange(N):
        ids[x] = wx.NewId()
        b = wx.Button(f, ids[x], 'button %d' % x)
        b.Bind(wx.EVT_BUTTON, lambda e: p(e.EventObject.Label))
        buttons.append(b)
        sizer.Add(b)

    timer_button = wx.Button(f, -1, 'timer')

    f.i=0
    def foo(e):
        f.i += 1
        c = f.i
        f.t = wx.PyTimer(lambda: p('hello world', c))
        import gc; gc.collect()
        f.t.Start(1000)

    f.Bind(wx.EVT_BUTTON, foo, id = timer_button.Id)
    sizer.Add(timer_button)

    sizer.Layout()
    f.Show()

    for x in xrange(N):
        button = buttons[x]
        print button, button.Position

    f.Bind(wx.EVT_CLOSE, lambda e: wx.GetApp().ExitMainLoop())

    wx.GetApp().MainLoop()

if __name__ == '__main__':
    main()

