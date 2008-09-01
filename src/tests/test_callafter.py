import gc
import sys
import wx
from weakref import ref
from testutil import check_collected

foo = 0
success = 0

def test_callafter_leak():
    def func():
        global foo
        foo = 42

    wr = ref(func)
    wx.CallAfter(func)
    del func

    # make sure that func runs
    wx.GetApp().Yield()

    assert wr() is None, gc.get_referrers(gc.get_referrers(wr())[0])
    assert foo == 42

    global success
    success = success + 1


def main():
    a = wx.PySimpleApp()

    N = 100

    for x in xrange(N):
        wx.CallAfter(test_callafter_leak)

    wx.CallAfter(gc.collect)

    for x in xrange(N):
        wx.CallAfter(test_callafter_leak)


    wx.CallAfter(a.ExitMainLoop)
    a.MainLoop()

    global success
    assert success == N*2




if __name__ == '__main__':
    main()






