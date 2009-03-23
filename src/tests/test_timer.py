import gc
import sys
import wx
from testutil import check_collected

def test_timer():
    #f = wx.Frame(None)

    '''
    def foo():
        import time
        f.Title = str(time.time())
    '''

    def foo2(): pass

    t = wx.PyTimer(foo2)

    #f.timer = wx.PyTimer(foo)
    #f.timer.Start(500, False)

    '''
    def close(e):
        f.Destroy()
        print sys.getrefcount(f.timer)
        gc.collect()

    f.Bind(wx.EVT_CLOSE, close)

    f.Show()
    '''

def test_timerref():

    @check_collected
    def timer():
        f = wx.Frame(None)
        class SMDTimer(wx.Timer):
            def __init__(self, menu):
                self.menu = menu
                wx.Timer.__init__(self)

            def Start(self, hitrect, *args, **kwargs):
                self.hitrect = hitrect
                self.args   = args
                self.kwargs = kwargs
                wx.Timer.Start(self, 500, True)

            def Notify(self):
                if not self.menu.Shown and self.hitrect.Contains(wx.GetMousePosition()):
                    self.menu.Display(*self.args,**self.kwargs)

        f.timer = SMDTimer(f)
        f.timer.Start(wx.Rect(30, 40, 50, 6))
        f.Destroy()
        return f, f.timer




def main():
    a=wx.PySimpleApp()
    test_timer()
    a.MainLoop()

if __name__ == '__main__':
    from ctypes import windll
    windll.comctl32.InitCommonControls()
    main()
