import wx

def show_icons():
    f = wx.Frame(None)

    #bitmap = wx.Bitmap(r'c:\favicon.ico', wx.BITMAP_TYPE_ICO)
    icon   = wx.IconFromFile(r'c:\favicon.ico')

    bad = wx.Bitmap(r'c:\bad_favicon.bmp')
    reference = wx.Bitmap(r'c:\good_favicon.bmp')

    print 'icon.GetWidth, icon.GetHeight ->', icon.GetWidth(), icon.GetHeight()
    print 'icon.GetDepth() ->', icon.GetDepth()

    def paint(e):
        dc = wx.PaintDC(f)
        #dc.DrawBitmap(bitmap, 16, 0, True)
        dc.SetBrush(wx.WHITE_BRUSH)
        dc.SetPen(wx.TRANSPARENT_PEN)
        dc.DrawRectangleRect(f.ClientRect)

        dc.DrawBitmap(bad, 16, 16, True)
        dc.DrawBitmap(wx.BitmapFromIcon(icon), 32, 16, True)
        dc.DrawBitmap(reference, 48, 16, True)


    f.Bind(wx.EVT_PAINT, paint)
    f.Show()

if __name__ == '__main__':
    a = wx.PySimpleApp()
    wx.Log.SetActiveTarget(wx.LogStderr())
    show_icons()
    a.MainLoop()