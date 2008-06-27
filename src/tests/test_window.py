import wx

def test_window():
    f = wx.Frame(None)
    assert not f.Shown and not f.IsShown()
    f.Show()
    assert f.Shown and f.IsShown()
    return f
