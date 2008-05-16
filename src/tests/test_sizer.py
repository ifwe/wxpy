import sip
import wx
from testutil import assert_ownership

def test_GridBagSizer():
    s = wx.GridBagSizer()

def test_BoxSizer():
    s = wx.BoxSizer(wx.HORIZONTAL)
    
    f = wx.Frame(None)
    b = wx.Button(f)

    assert_ownership(lambda: s.Add(b), pyowned = False)

    f.Destroy()

def test_SizerClear():
    f = wx.Frame(None)
    b1 = wx.Button(f, -1, 'test')
    b2 = wx.Button(f, -1, 'test2')

    s = wx.BoxSizer(wx.HORIZONTAL)
    s.Add(b1)
    s.Add(b2)

    assert not sip.isdeleted(b1)
    assert not sip.isdeleted(b2)

    s.Clear(True) # test deleteWindows argument

    assert sip.isdeleted(b1)
    assert sip.isdeleted(b2)

    f.Destroy()
