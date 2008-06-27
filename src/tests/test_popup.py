import wx

def test_Popup():
    f = wx.Frame(None)
    p = wx.PopupWindow(f)
    r = wx.Rect(30, 30, 200, 200)
    p.SetRect(r)
    p.Show()

    print 'after setting %r, GetRect() is %r' % (r, p.GetRect())

    assert p.GetRect() == r

    p.Rect = r2 = wx.Rect(40, 40, 100, 100)
    assert p.Rect == (40, 40, 100, 100), repr(p.Rect)
    assert p.GetPosition() == p.Position == r2.Position == (40, 40)
    assert p.GetSize() == p.Size == r2.Size == (100, 100)




if __name__ == '__main__':
    a = wx.PySimpleApp()
    test_Popup()
    a.MainLoop()
