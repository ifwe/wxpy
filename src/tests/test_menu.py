import gc
import sip
import sys
import weakref
import wx

from testutil import assert_ownership

def test_menu():
    assert_ownership(wx.Menu, pyowned = True)

    menu = wx.Menu()

def test_menuitem():
    menu = wx.Menu()

    # constructing a MenuItem with a Menu parent should mean
    # the MenuItem belongs to the Menu
    assert_ownership(lambda: wx.MenuItem(wx.Menu()), pyowned = False)

    item_id = wx.NewId()
    label = 'test &menu item\tctrl+t'
    item = wx.MenuItem(menu, item_id, label)

    assert item.Id == item.GetId() == item_id
    assert item.GetItemLabel() == item.ItemLabel == label
    assert item.GetItemLabelText() == item.ItemLabelText == 'test menu item'
    assert not item.IsSeparator()
    assert not item.IsSubMenu()
    assert not item.IsCheckable()

    sep = wx.MenuItem(menu)
    assert item.IsSeparator()

    item.Enable(False)
    assert not item.IsEnabled()

    # now destroy the strong references to both the menu and the item
    weak_item = weakref.ref(item)
    del item, menu
    gc.collect()

    assert weak_item() is None, 'should be dead: %r' % weak_item()

def test_menubar():
    menubar = wx.MenuBar()

