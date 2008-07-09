import os
import wx

from wx.lib.flashwin import FlashWindow

class TestPanel(wx.Panel):
    def __init__(self, parent, log):
        wx.Panel.__init__(self, parent, -1)
        self.pdf = None

        sizer = wx.BoxSizer(wx.VERTICAL)
        btnSizer = wx.BoxSizer(wx.HORIZONTAL)

        self.flash = FlashWindow(self, style=wx.SUNKEN_BORDER)

        vars = '?c=abcde12345&STATE=creator'

        url = 'http://w.digsby.com/dw.swf'#?STATE=creator&field=ffffff&statustext=777777&nick=my.nickname&bgcolor=eaeaea&text=444444&title=Digsby+Widget&titletext=7a7a7a'
        url += vars

        self.flash.LoadMovie(0, url)
        #self.flash.LoadMovie(0, 'file://' + os.path.abspath('c:/dev/wxPython/demo/data/Asteroid_blaster.swf'))
        sizer.Add(self.flash, proportion=1, flag=wx.EXPAND)

        btn = wx.Button(self, wx.NewId(), "Open Flash File")
        self.Bind(wx.EVT_BUTTON, self.OnOpenFileButton, btn)
        btnSizer.Add(btn, proportion=1, flag=wx.EXPAND|wx.ALL, border=5)

        btn = wx.Button(self, wx.NewId(), "Open Flash URL")
        self.Bind(wx.EVT_BUTTON, self.OnOpenURLButton, btn)
        btnSizer.Add(btn, proportion=1, flag=wx.EXPAND|wx.ALL, border=5)

        btnSizer.Add((50,-1), proportion=2, flag=wx.EXPAND)
        sizer.Add(btnSizer, proportion=0, flag=wx.EXPAND)

        self.SetSizer(sizer)
        self.SetAutoLayout(True)



    def OnOpenFileButton(self, event):
        dlg = wx.FileDialog(self, wildcard="*.swf")

        if dlg.ShowModal() == wx.ID_OK:
            wx.BeginBusyCursor()
            self.flash.LoadMovie(0, 'file://' + dlg.GetPath())
            wx.EndBusyCursor()

        dlg.Destroy()


    def OnOpenURLButton(self, event):
        dlg = wx.TextEntryDialog(self, "Enter a URL of a .swf file", "Enter URL")

        if dlg.ShowModal() == wx.ID_OK:
            wx.BeginBusyCursor()
            # setting the movie property works too
            self.flash.movie = dlg.GetValue()
            wx.EndBusyCursor()

        dlg.Destroy()



if __name__ == '__main__':
    a = wx.PySimpleApp()
    f = wx.Frame(None)
    p = TestPanel(f, -1)
    f.Show()
    a.MainLoop()