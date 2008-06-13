import sip
import wx

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

def main():
    a = wx.PySimpleApp()
    test_frame().Show()
    a.MainLoop()

if __name__ == '__main__':
    main()

