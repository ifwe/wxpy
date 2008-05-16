import sys
import wx

def test_vlistbox():
    pass

    

def main():
    a = wx.PySimpleApp()
    f = wx.Frame(None)
    
    class MyList(wx.VListBox):
        def OnMeasureItem(self, n):
            return (30, 10, 20)[n % 3]

        def OnDrawItem(self, dc, rect, n):
            dc.Brush = wx.Brush(wx.RED)
            dc.Pen = wx.TRANSPARENT_PEN
            dc.DrawRectangleRect(rect)

            dc.TextForeground = wx.WHITE
            dc.DrawText("hello, world %d" % n, rect.x + 3, rect.y + 3)

    v = MyList(f, -1)
    v.SetItemCount(100)

    f.Show()
    a.MainLoop()

if __name__ == '__main__':
    main()
