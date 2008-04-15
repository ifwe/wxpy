import sys
import wx
import wxextensions
import sip
import weakref

def message(e):
    print 'click!', e.GetEventObject(), id(e.GetEventObject())
    
def p(*args):
    print ' '.join(str(a) for a in args)

def main():
      a = wx.App()
      if hasattr(wx, 'pyEntry'):
          wx.pyEntry()

      f = wx.Frame(None, -1, u'wxpy frame', (40, 40), (400, 300))
      f.Bind(wx.EVT_ACTIVATE, lambda e: p('frame activate:', f.GetActive()))      
      
      s = wx.BoxSizer(wx.VERTICAL)
      
      def show_modal(e):
          for x in xrange(1000):
              diag = wx.Dialog(f, -1, 'test modal dialog', size = (400, 300))
              diag.Destroy()


          import gc
          print 'collect', gc.collect()
                                      
             #print diag
          #print diag.GetSize()
          
          #print 'before modal:'
          #sip.dump(diag)
          #try:
          #    diag.ShowModal()
          #finally:

              
          #print 'after modal:'
          #sip.dump(diag)
          
          #print 'test attribute lookup'
          #print diag.GetSize()
      
      button = wx.Button(f, -1, 'Show Modal Dialog')
      button.Bind(wx.EVT_BUTTON, show_modal)

      print 'button id is', id(button)
      
      
      
      def on_paint(e):
          dc = wx.PaintDC(f)
          dc.SetBrush(wx.Brush(wx.Colour(255, 0, 0)))
          rect = wx.Rect(20, 20, 60, 70)

          if dc.IsOk():
              font = dc.GetFont()
              font.SetPointSize(20)
              font.SetWeight(wx.FONTWEIGHT_BOLD)
              dc.SetFont(font)
              dc.DrawText("hello, world!", 400, 300)
              
              b2= b = wx.Brush(wx.Colour(255, 0, 0))
              #print 'id of brush', id(b)
              dc.SetBrush(b)
              b = dc.GetBrush()
              #print 'id of brush after in DC', id(b)
              #print 'brush', b
              #print 'brush color', b.GetColour()
              #raise Exception('test')
              
              dc.DrawRectangle(420, 500, 60, 30)
          else:
              print 'not ok!'
              
      #f.Connect(-1, -1, 10090, on_paint)
      f.Bind(wx.EVT_PAINT, on_paint)
      
      static_text = wx.StaticText(f, -1, 'Static Text')      
      checkbox = wx.CheckBox(f, -1, 'Checkbox')
      
      def print_top(e): print wx.GetTopLevelWindows()
          
      checkbox.Bind(wx.EVT_CHECKBOX, print_top)

      s.Add(static_text, 0, wx.ALL, 6)
      s.Add(button, 0, wx.ALL, 6)
      s.Add(checkbox, 0, wx.ALL, 6)
      s.Add(wx.TextCtrl(f, -1, 'Text Control'))
      
      #for x in xrange(20):
      #    s.Add(wx.Button(f, -1, 'another button'))

      f.SetSizer(s)
      f.Layout()
      
      a.Bind(wx.EVT_MENU, lambda e: a.ExitMainLoop(), id = wx.ID_EXIT)

      f.Show()
      a.MainLoop()
      
if __name__ == '__main__':
    main()
    