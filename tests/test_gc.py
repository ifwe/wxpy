import wx

def test_gc():
    f = wx.Frame(None)
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
        print gc.GetNativeContext()
        gc.SetBrush(wx.RED_BRUSH)
        gc.SetPen(wx.BLACK_PEN)
        gc.DrawRoundedRectangle(0, 0, 100, 100, 5)

    f.Bind(wx.EVT_PAINT, paint)
    f.Show()


def main():
    a = wx.PySimpleApp()
    test_gc()
    a.MainLoop()

if __name__ == '__main__':
    main()