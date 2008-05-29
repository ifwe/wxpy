import wx
import wx.html

htmlpage = '''\
<html>
<h1>test</h1>
<p>This is a
<p>Test.
</html>
'''

def test_html():
    f = wx.Frame(None)
    f.Sizer = wx.BoxSizer(wx.HORIZONTAL)
    h = wx.html.HtmlWindow(f)
    h.SetPage(htmlpage)

    f.Sizer.Add(h, 1, wx.EXPAND)
    f.Show()

    print h.Rect

    return f

def main():
    a = wx.PySimpleApp()
    test_html()
    a.MainLoop()

if __name__ == '__main__':
    main()