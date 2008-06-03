import wx

def main():
    f = wx.Frame(None)

    def paint(e):
        dc.DrawRectangle()

    t = wx.PyTimer(paint)
    f.Show()
    a.MainLoop()

    pass

if __name__ == '__main__':
    main()