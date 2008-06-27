import wx
import sip
from random import randint

def test_gc():
    f = wx.Frame(None, style = wx.DEFAULT_FRAME_STYLE | wx.FULL_REPAINT_ON_RESIZE)
    f.SetBackgroundStyle(wx.BG_STYLE_CUSTOM)
    f.pen = wx.Pen(wx.Colour(213,213,213))

    def paint(e):
        self=f
        dc = wx.BufferedPaintDC(self)

        size = self.Size
        rect = wx.RectS(size)

        dc.Brush = wx.WHITE_BRUSH
        dc.Pen = wx.TRANSPARENT_PEN
        dc.DrawRectangleRect(rect)

        gc = wx.GraphicsContext.Create(dc)

        for x in xrange(50):
            x1, y1, x2, y2 = (randint(0, rect.width-1), randint(0, rect.height-1),
                              randint(0, rect.width-1), randint(0, rect.height-1))

            gc.SetBrush(wx.RED_BRUSH)
            gc.SetPen(wx.BLACK_PEN)
            gc.DrawRoundedRectangle(x1, y1, x2, y2, randint(1, 15))

            gc.SetFont(wx.NORMAL_FONT, wx.BLACK)
            gc.DrawText('gctest', randint(0, rect.width-1), randint(0, rect.height-1))

    def onclose(e):
        f.Destroy()
        wx.CallAfter(test_gc)

    f.Bind(wx.EVT_CLOSE, onclose)
    f.Bind(wx.EVT_PAINT, paint)
    f.Show()


def main():
    a = wx.PySimpleApp()
    test_gc()
    a.MainLoop()

if __name__ == '__main__':
    main()
