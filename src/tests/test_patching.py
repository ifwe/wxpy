import wx

wx.Font.TestProperty = property(lambda f: 42)

def test_patchmethod():
    wx.Rect.TestMethod = lambda font: 33
    assert wx.Rect().TestMethod() == 33

    wx.Rect.TestProperty = property(lambda rect: 42)
    assert wx.Rect().TestProperty == 42

    print wx.Font, id(wx.Font)
    print dir(wx.Font)
    wx.Font.TestProperty = property(lambda font: 123)

    f = wx.Frame(None)
    font = f.Font
    c = font.__class__
    print c, id(c)
    print dir(c)
    assert font.TestProperty == 123