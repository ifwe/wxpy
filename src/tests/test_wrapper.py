import gc
import sip
import wx
from weakref import ref

def test_wrapper():
    "test wrapped objects' __nonzero__"

    f = wx.Frame(None)

    assert not sip.isdeleted(f)
    assert f

    weak_f = ref(f)
    f.Destroy()

    # calling ProcessIdle here forces wxApp::DeletePendingObjects(), which
    # deletes all objects from the wxPendingDelete list
    wx.GetApp().ProcessIdle()

    assert sip.isdeleted(f)

def main():
    app = wx.PySimpleApp()
    test_wrapper()


if __name__ == '__main__':
    main()
