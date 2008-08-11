
from wx._webview import *
import wx

_WebView = WebView
class WebView(_WebView):
    def __init__(self, parent, id = -1, point = wx.DefaultPosition, size = wx.DefaultSize,
                 style = 0, name = 'WebView'):
        _WebView.__init__(self, parent, id, point, size, style, name)
