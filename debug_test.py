import os
os.environ['PATH'] = os.pathsep.join((r'c:\dev\digsby\build\msw\wxWidgets\lib\vc_dll', os.environ['PATH']))

import nose

import wx
wx.HandleFatalExceptions()

try:
    origcwd = os.getcwd()
    os.chdir('src/tests')
    nose.main()
finally:
    os.chdir(origcwd)
