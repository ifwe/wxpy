from testutil import check_collected, main
import wx

def test_selfcycle():
    return

    f = wx.Frame(None)

    class MyEventHandler(wx.EvtHandler):
        def __init__(self):
            wx.EvtHandler.__init__(self)
            self.Bind(wx.EVT_MENU, self.on_menu)

        def on_menu(self, e):
            print 'Menu Event', e

    @check_collected
    def cycle():
        return MyEventHandler()

    f.Destroy()

    print 'no cycle!'

if __name__ == '__main__':
    main(test_selfcycle)
