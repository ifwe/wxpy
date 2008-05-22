import wx
from testutil import assert_ownership

def test_TextCtrl():
    f = wx.Frame(None)
    assert_ownership(lambda: wx.TextCtrl(f, -1, 'test'), pyowned = False)
    f.Destroy()
