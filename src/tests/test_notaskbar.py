import wx
from testutil import main

def test_notaskbar():
    f = lambda: wx.Frame(None, -1, style=wx.DEFAULT_FRAME_STYLE | wx.FRAME_NO_TASKBAR)

    frames = [f() for x in xrange(10)]
    for frame in frames:
        frame.Destroy()



if __name__ == '__main__':
    main(test_notaskbar)