import wx

def test_invalid_utf8():
    wx.MessageBox('\xc3')

def main():
    app = wx.PySimpleApp()
    test_invalid_utf8()

if __name__ == '__main__':
    main()