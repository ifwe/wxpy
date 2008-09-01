from __future__ import with_statement
import gc
import sip
import weakref
import wx

from testutil import check_collected, check_refcount


def check_toplevel(tlw):
    # test changing the title
    tlw.Title = 'set via property'
    assert tlw.Title == tlw.GetTitle() == 'set via property'

    tlw.SetTitle('set via method')
    assert tlw.Title == tlw.GetTitle() == 'set via method'

def test_frame():
    title = 'test frame'
    pos = (40, 40)
    size = (300, 300)

    f = wx.Frame(None, -1, title = title, pos = pos, size = size)

    assert f.Title == f.GetTitle() == 'test frame'
    assert f.Size == f.GetSize() == size
    assert f.Position == f.GetPosition() == pos
    assert not f.IsShown()

    f.SetMinSize((42,43))
    f.SetMinSize(wx.Size(42, 43))
    assert f.GetMinSize() == (42, 43) == f.MinSize

    #f.MinSize = (10, 10)
    #assert f.MinSize == (10, 10)

    check_toplevel(f)
    return f


def test_FrameDestroy():
    @check_collected
    def frame():
        f = wx.Frame(None)
        f.Destroy()
        wx.GetApp().ProcessIdle() # ensure frame is deleted
        assert sip.isdeleted(f)
        return f

def test_cycle():
    f1, f2 = wx.Frame(None), wx.Frame(None)
    f1.f2, f2.f1 = f2, f1
    f1.ident = 'frame 1'
    f2.ident = 'frame 2'
    wf1, wf2 = weakref.ref(f1), weakref.ref(f2)

    f1.Destroy()
    f2.Destroy()

    wx.GetApp().ProcessIdle()
    del f1, f2
    gc.collect()

    assert wf1() is None
    assert wf2() is None

def test_write_to_dead():
    pidle = wx.GetApp().ProcessIdle

    f = wx.Frame(None)
    print sip.unwrapinstance(f)
    f.Destroy()
    pidle()


    for x in xrange(1):
        others = [wx.Frame(None) for x in xrange(10)]

        print [sip.unwrapinstance(o) for o in others]

        try:
            f.SetTitle('test')
        except sip.DeadObjectException:
            pass

        assert not any(o.Title == 'test' for o in others)

    [f.Destroy() for f in others]

def main():
    a = wx.PySimpleApp()
    test_write_to_dead()
    #import memleak
    #memleak.find(test_cycle, loops=1000)


if __name__ == '__main__':
    main()

