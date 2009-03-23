import sip
import wx

def test_add_transfers():
    t = wx.TextDataObject('test')
    data = wx.DataObjectComposite()
    data.Add(t)
    assert not sip.ispyowned(t)


