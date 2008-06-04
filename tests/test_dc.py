import sip
import wx

def test_dc():
    f = wx.Frame(None)

    def paint(e):
        b = wx.Brush()
        dc.SetBrush(b)
        dc.DrawRectangle(50, 50, 300, 300)

    f.Show()
    f.Refresh()
    return f

def main():
    a = wx.PySimpleApp()
    f = test_dc()
    sip.dump(f)
    print 'Calling Destroy...'
    #f.Destroy()
    print '...called Destroy.'
    sip.dump(f)

    #assert sip.isdeleted(f)

    a.MainLoop()

if __name__ == '__main__':
    main()