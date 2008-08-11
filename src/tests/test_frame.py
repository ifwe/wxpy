import gc
import sip
import weakref
import wx

from testutil import check_collected

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

    del f1, f2
    gc.collect()

    assert wf1() is None
    assert wf2() is None

def main():
    a = wx.PySimpleApp()

    import memleak
    memleak.find(test_FrameDestroy, loops=500)

if __name__ == '__main__':
    main()

