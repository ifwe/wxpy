import wx

def test_BoxSizer():
    f = wx.Frame(None)

    N = 5
    buttons = [wx.Button(f, -1, 'button %d' % n) for n in xrange(N)]

    s = wx.BoxSizer(wx.VERTICAL)
    s.AddMany(buttons)
    f.Sizer = s
    f.Show()

    # check button positioning
    for n, b in enumerate(buttons[:-1]):
        y1, y2 = b.Position.y, buttons[n+1].Position.y
        assert y1 < y2, '%r should be less than %r' % (y1, y2)

if __name__ == '__main__':
    a = wx.PySimpleApp()
    test_BoxSizer()
    a.MainLoop()