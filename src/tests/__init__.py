import wx

from weakref import ref

def setup():
    '''
    Setup code run before all tests in this package.
    '''
    assert not wx.GetApp() # make sure an app is created ONCE
    assert wx.App() == wx.GetApp()

def teardown():
    '''
    Teardown code run after all tests in this package.
    '''
    pass

