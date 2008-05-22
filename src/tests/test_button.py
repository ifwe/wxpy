import wx
from testutil import assert_ownership

def test_Button():
    f = wx.Frame(None)
    assert_ownership(lambda: wx.Button(f, -1, 'test'), pyowned = False)
    f.Destroy()
