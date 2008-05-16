import sys
import weakref

import sip
import wx

def message(e):
    print 'click!', e.GetEventObject(), id(e.GetEventObject())

def prnt(*args):
    print ' '.join(str(a) for a in args)

<<<<<<< HEAD:widgettest.py
def construct_layout(f):
    b  = wx.Button(f, -1, 'test')
    b2 = wx.Button(f, -1, 'test2')

    s = f.Sizer = wx.BoxSizer(wx.VERTICAL)
    
    item1 = s.Add(b)
    sip.dump(item1)
    item2 = s.Add(b2)

    s2 = f.Sizer = wx.BoxSizer(wx.VERTICAL)
    sip.dump(s)
    
=======
class MyApp(wx.App):
    def __init__(self):
        print 'App.__init__'
        wx.App.__init__(self)
        self.SetExitOnFrameDelete(False)
        wx.IdleEvent.SetMode(wx.IDLE_PROCESS_SPECIFIED)
        wx.EntryStart()

    def ProcessIdle(self):
        print 'ProcessIdle return False'
        return False
        
    def OnInit(self):
        print 'MyApp.OnInit'
        return True
>>>>>>> 08ab9a820cc5622442580ae5480bd0524d99adf4:widgettest.py

def main():
    a = wx.PySimpleApp()
    f = wx.Frame(None)
    construct_layout(f)
    import gc
    gc.collect()
    f.Fit()
    f.Show()
    a.MainLoop()


def main2():
      a = wx.PySimpleApp()

      f = wx.Frame(None, -1, u'wxpy frame', (40, 40), (400, 300))
      p = wx.Panel(f)
      p.SetBackgroundStyle(wx.BG_STYLE_CUSTOM)

      f.Bind(wx.EVT_ACTIVATE, lambda e: prnt('frame activate:', f.IsActive()))

      def onclose(e):
          print 'destroying frame', f
          print 'BEFORE: isdeleted?', sip.isdeleted(f)
          print sip.dump(f)
          f.Destroy()
          #sip.setdeleted(f)
          print 'AFTER: isdeleted?', sip.isdeleted(f)
          print sip.dump(f)

      f = wx.Frame(None, -1, u'wxpy frame', (40, 40), (400, 300))
      f.Bind(wx.EVT_CLOSE, onclose)
      f.Bind(wx.EVT_ACTIVATE, lambda e: p('frame activate:', f.IsActive()))

      s = wx.BoxSizer(wx.VERTICAL)

      def show_modal(e):
          diag = wx.Dialog(f, -1, 'test modal dialog', size = (400, 300))
          try:
              diag.ShowModal()
          finally:
              diag.Destroy()
          import gc
          print 'collect', gc.collect()

      button = wx.Button(p, -1, 'Show Modal Dialog')
      button.Bind(wx.EVT_BUTTON, show_modal)

      print 'button id is', id(button)

      def on_paint(e):
          dc = wx.AutoBufferedPaintDC(p)

          dc.SetBrush(wx.WHITE_BRUSH)
          dc.SetPen(wx.TRANSPARENT_PEN)
          dc.DrawRectangleRect(p.GetClientRect())

          dc.SetBrush(wx.Brush(wx.Colour(255, 0, 0)))
          rect = wx.Rect(20, 20, 60, 70)

          if dc.IsOk():
              font = dc.GetFont()
              font.SetPointSize(20)
              font.SetWeight(wx.FONTWEIGHT_BOLD)
              dc.SetFont(font)

              dc.DrawText("hello, world!", 130, 100)

              b = wx.Brush(wx.Colour(255, 0, 0))
              dc.SetBrush(b)
              b = dc.GetBrush()

              dc.DrawRectangle(140, 130, 60, 30)
          else:
              print 'not ok!'

      #f.Connect(-1, -1, 10090, on_paint)
      f.Bind(wx.EVT_PAINT, on_paint)

      static_text = wx.StaticText(p, -1, 'Static Text')
      checkbox = wx.CheckBox(p, -1, 'Checkbox')

      def print_top(e):
          print wx.GetTopLevelWindows()

      checkbox.Bind(wx.EVT_CHECKBOX, print_top)

      s.Add(static_text, 0, wx.ALL, 6)
      s.Add(button, 0, wx.ALL, 6)
      s.Add(checkbox, 0, wx.ALL, 6)

      s.Add(wx.TextCtrl(p, -1, 'Text Control', name = 'Username'))

      p.SetSizer(s)

      a.Bind(wx.EVT_MENU, lambda e: a.ExitMainLoop(), id = wx.ID_EXIT)


      a.SetTopWindow(f)
      f.Show()

      #
      # sys.a=a

      print '--> calling MainLoop'
      import sip
      sip.dump(wx.GetApp())
      a.MainLoop()
      print '--> MainLoop returned'

if __name__ == '__main__':
    main()
