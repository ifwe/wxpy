import sip
import wx
from testutil import assert_ownership

sip.settracemask(wx.SipTrace.ALL)

def test_scope():
    s = wx.StockGDI.instance()
    assert not sip.ispyowned(s)
    assert_ownership(wx.StockGDI.instance, pyowned = False)
    import gc
    gc.collect()

def test_StockGDI():
    test_scope()
    # wxBrush
    #b = s.GetBrush(wx.StockGDI.BRUSH_BLUE)
    #print b.Colour


    # wxFont
    normal_font = wx.StockGDI.instance().GetFont(wx.StockGDI.FONT_NORMAL)
    print 'NORMAL_FONT.PointSize', normal_font.PointSize

def main():
    #import pdb; pdb.set_trace()
    wx.App()
    test_StockGDI()

if __name__ == '__main__':
    main()