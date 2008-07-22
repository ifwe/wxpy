import wx

def test_invalid_utf8():
    f = wx.Frame(None)
    f.SetTitle('\xc3') # not a valid utf8 character-- should at least not crash
    f.Destroy()

def main():
    app = wx.PySimpleApp()
    test_invalid_utf8()

if __name__ == '__main__':
    main()