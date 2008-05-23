import sip
import wx
from testutil import assert_ownership

def test_StockGDI():
    s = wx.StockGDI.instance()
    sip.dump(s)
    assert not sip.ispyowned(s)
    assert_ownership(wx.StockGDI.instance, pyowned = False)

    # wxBrush
    b = s.GetBrush(wx.StockGDI.BRUSH_BLUE)
    #print b.Colour

    sip.dump(b)

    # wxFont
    #normal_font = s.GetFont(wx.StockGDI.FONT_NORMAL)
