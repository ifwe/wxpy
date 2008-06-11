import wx

def test_timer():
    f = wx.Frame(None)

    def foo():
        import time
        f.Title = str(time.time())

    f.timer = wx.PyTimer(foo)
    f.timer.Start(500, False)

    def close(e):
        f.Destroy()
        gc.collect()

    f.Bind(wx.EVT_CLOSE, close)

    f.Show()

def main():
    a=wx.PySimpleApp()
    test_timer()
    a.MainLoop()

if __name__ == '__main__':
    main()
