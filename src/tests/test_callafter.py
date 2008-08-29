import gc
import sys
import wx
from weakref import ref
from testutil import check_collected

foo = 0

def test_callafter_leak():

    def func():
        global foo
        foo = 42

    wr = ref(func)
    wx.CallAfter(func)
    del func

    # make sure that func runs
    for x in xrange(10):
        wx.GetApp().Yield()

    assert wr() is None, gc.get_referrers(gc.get_referrers(wr())[0])
    assert foo == 42

def main():
    a = wx.PySimpleApp()

    wx.CallAfter(test_callafter_leak)
    a.MainLoop()


if __name__ == '__main__':
    main()






