import gc
import sys
import wx

from weakref import ref
from testutil import assert_ownership, check_collected

def test_menu():
    assert_ownership(wx.Menu, pyowned = True)

    menu = wx.Menu()

def test_menuitem():
    menu = wx.Menu()
    #assert_ownership(wx.Menu, pyowned = True)

    # constructing a MenuItem with a Menu parent should mean
    # the MenuItem belongs to the Menu
    #assert_ownership(lambda: wx.MenuItem(wx.Menu()), pyowned = False)

    item_id = wx.NewId()
    label = 'test &menu item\tctrl+t'

    item = menu.Append(item_id, label)

    assert item.Id == item.GetId() == item_id
    assert item.GetItemLabel() == item.ItemLabel == label
    assert item.GetItemLabelText() == item.ItemLabelText == 'test menu item'
    assert not item.IsSeparator()
    assert not item.IsSubMenu()
    assert not item.IsCheckable()

    item2 = menu.Append(-1, 'test')

    item.Enable(False)
    assert not item.IsEnabled()

    # now destroy the strong references to both the menu and the item
    weak_menu  = ref(menu)
    weak_item  = ref(item)
    weak_item2 = ref(item2)

    del item, item2, menu
    gc.collect()
    wx.GetApp().ProcessIdle()

    assert weak_menu() is None, 'should be dead: %r' % weak_menu()
    assert weak_item2() is None, 'should be dead: %r' % weak_item2()
    assert weak_item() is None, 'should be dead: %r\n%r' % (weak_item(), gc.get_referrers(weak_item()))

def test_menubar():
    @check_collected
    def menubar_ownership():
        f = wx.Frame(None)

        menubar = wx.MenuBar()
        f.SetMenuBar(menubar)

        menu = wx.Menu()

        submenu = wx.Menu()
        menu.AppendSubMenu(submenu, 'test submenu')

        menubar.Append(menu, "Menu")

        # destroying the frame should also destroy all the menu objects
        f.Destroy()
        return f, menubar, menu, submenu

def main():
    a = wx.PySimpleApp()
    f = wx.Frame(None)

    def on_menu(e):
        m = wx.Menu()
        m.Append(-1, 'test')
        f.PopupMenu(m, f.ScreenToClient(e.Position))

    def on_close(e):
        menus = [o for o in gc.get_objects() if isinstance(o, wx.Menu)]
        print '%d leftover menus: %r' % (len(menus), menus)
        wx.GetApp().ExitMainLoop()

    f.Bind(wx.EVT_CONTEXT_MENU, on_menu)
    f.Bind(wx.EVT_CLOSE, on_close)
    f.Show()
    a.MainLoop()

def main_ram():
    a = wx.PySimpleApp()
    import memleak
    memleak.find(test_menuitem, loops=500)

if __name__ == '__main__':
    main_ram()
