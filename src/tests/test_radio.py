import wx
from testutil import assert_ownership

def test_RadioButton():
    f = wx.Frame(None)
    assert_ownership(lambda: wx.RadioButton(f, -1, 'test'), pyowned = False)
    f.Destroy()
