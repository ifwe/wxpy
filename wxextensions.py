import wx

_old_bind = wx.EvtHandler.Bind
def Bind(self, event, cb, source = None, id = -1, id2 = -1):
    print self, type(self)
    return _old_bind(self, event, cb, source, id, id2)
wx.EvtHandler.Bind = Bind
del Bind

_old_Dialog = wx.Dialog.__init__
def __init__(self, parent = None, id = -1, title = "", pos = wx.DefaultPosition,
             size = wx.DefaultSize, style = wx.DEFAULT_DIALOG_STYLE, name = 'dialogBox'):
    return _old_Dialog(self, parent, id, title, pos, size, style, name)
wx.Dialog.__init__ = __init__
del __init__

wx.TopLevelWindow.__repr__ = lambda tlw: '<wx.%s "%s" at %x>' % (type(tlw).__name__, tlw.GetTitle(), id(tlw))