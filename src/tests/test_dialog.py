from __future__ import with_statement
import wx

def test_dialog_contextmanager():
    n = len(wx.GetTopLevelWindows())
    with wx.Dialog(None, -1, 'test') as diag:
        diag.Bind(wx.EVT_SHOW, lambda e: wx.CallAfter(diag.Close) if e.GetShow() else None)
        diag.ShowModal()

    wx.GetApp().ProcessIdle()
    assert n == len(wx.GetTopLevelWindows()), repr((n, len(wx.GetTopLevelWindows())))

if __name__ == '__main__':
    a = wx.PySimpleApp()
    test_dialog_contextmanager()
