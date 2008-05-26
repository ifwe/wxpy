import wx

def test_Popup():
    f = wx.Frame(None)
    p = wx.PopupWindow(f)
    r = wx.Rect(30, 30, 200, 200)
    p.SetRect(r)
    p.Show()
    assert p.GetRect() == r

    p.Rect = wx.Rect(40, 40, 100, 100)
    assert p.Rect == (40, 40, 100, 100), repr(p.Rect)
    assert p.GetPosition() == (40, 40)
    assert p.GetSize() == (100, 100)
    f.Show()




if __name__ == '__main__':
    a = wx.PySimpleApp()
    test_Popup()
    a.MainLoop()
