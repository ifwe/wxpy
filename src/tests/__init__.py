import wx

from weakref import ref

def setup():
    '''
    Setup code run before all tests in this package.
    '''
    assert not wx.GetApp()
    wx.App.SetInstance(wx.App())
    wx.EntryStart()
    wx.InitAllImageHandlers()

def teardown():
    '''
    Teardown code run after all tests in this package.
    '''
    pass

