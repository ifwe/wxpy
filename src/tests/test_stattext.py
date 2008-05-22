import wx
from testutil import assert_ownership

def test_StaticText():
    f = wx.Frame(None)
    assert_ownership(lambda: wx.StaticText(f, -1, 'test'), pyowned = False)
    f.Destroy()
