import wx

def test_Notebook():
    f = wx.Frame(None)
    n = wx.Notebook(f)
    
    f.Show()
    f.Destroy()

