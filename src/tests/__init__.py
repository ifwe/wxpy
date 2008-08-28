import sys
import wx

from weakref import ref

def setup():
    '''
    Setup code run before all tests in this package.
    '''
    #assert not wx.GetApp() # make sure an app is created ONCE
    sys.app = wx.PySimpleApp()
    assert sys.app == wx.GetApp()
    assert wx.GetApp() is not None

def teardown():
    '''
    Teardown code run after all tests in this package.
    '''
    pass

