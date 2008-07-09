from testutil import check_collected

def test_selfcycle():
    class MyEventHandler(wx.EvtHandler):
        def __init__(self):
            self.Bind(wx.EVT_MENU, self.on_menu)

        def on_menu(self, e):
            print 'Menu Event', e

    @check_collected
    def cycle():
        return MyEventHandler()
