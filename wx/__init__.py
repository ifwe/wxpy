'''
wxpy

python additions
'''

VERSION = (1, 0, 0, 0)

import sip

# SIP can show diagnostic traces for these categories
class SipTrace(object):
    VIRTUAL      = 0x0001
    CONSTRUCTOR  = 0x0002
    DESTRUCTOR   = 0x0004
    PY_INIT      = 0x0008
    PY_DEL       = 0x0010
    PY_METHOD    = 0x0020

SipTrace.ALL = (SipTrace.VIRTUAL | SipTrace.CONSTRUCTOR | SipTrace.DESTRUCTOR
                | SipTrace.PY_INIT | SipTrace.PY_DEL | SipTrace.PY_METHOD)

def autorepr(s = None):
    if s is not None:
        assert isinstance(s, basestring)
        def __repr__(self):
            return '<%s %s>' % (self.__class__.__name__, s % vars(self))
    else:
        def __repr__(self):
            return '<%s at %x>' % (self.__class__.__name__, id(self))

    return __repr__

#sip.settracemask(SipTrace.ALL)

#
# import all names from _wxcore
#
from _wxcore import *
import _wxcore as wx


import sys as _sys
from operator import attrgetter

def PyEventBinder(evttype, n = None):
    return (evttype, )

_old_callafter = wx.CallAfter
def CallAfter(func, *a, **k):
    return _old_callafter(lambda: func(*a, **k))

wx.TopLevelWindow.__repr__ = lambda tlw: '<wx.%s "%s" at %x>' % (type(tlw).__name__, tlw.GetTitle(), id(tlw))

wx.FrameNameStr  = 'Frame'
wx.DialogNameStr = 'Dialog'

wxFrame = wx.Frame
class Frame(wxFrame):
    def __init__(self, parent, id = -1, title = '', pos = DefaultPosition, size = DefaultSize, style = DEFAULT_FRAME_STYLE, name = wx.FrameNameStr):
        wxFrame.__init__(self, parent, id, title, pos, size, style, name)

wxDialog = wx.Dialog
class Dialog(wxDialog):
    def __init__(self, parent, id = -1, title = '', pos = DefaultPosition, size = DefaultSize, style = DEFAULT_DIALOG_STYLE, name = wx.DialogNameStr):
        wxDialog.__init__(self, parent, id, title, pos, size, style, name)

wxTextCtrl = wx.TextCtrl
class TextCtrl(wxTextCtrl):
    def __init__(self, parent, id = -1, value = '', pos = DefaultPosition, size = DefaultSize, style = 0, validator = wx.DefaultValidator, name = 'text control'):
        wxTextCtrl.__init__(self, parent, id, value, pos, size, style, validator, name)

wxStaticText = wx.StaticText
class StaticText(wxStaticText):
    def __init__(self, parent, id = -1, label = '', pos = DefaultPosition, size = DefaultSize, style = 0, name = 'static text'):
        wxStaticText.__init__(self, parent, id, label, pos, size, style, name)

#wxFont = wx.Font
#class Font(wxFont):
#    def __init__(self, pointSize, family, style, weight, underline = False, faceName = "", encoding = wx.FONTENCODING_DEFAULT):
#
#        wxFont.__init__(self, pointSize, family, style, weight, underline, faceName, encoding)

Font.init_args = init_args = ('pointSize', 'family', 'style', 'weight', 'underline', 'faceName', 'encoding')

wxControl = wx.Control
class Control(wx.Control):
    def __init__(self, parent, id = -1, pos = DefaultPosition, size = DefaultSize, style = 0, validator = wx.DefaultValidator, name = 'Control'):
        wxControl.__init__(self, parent, id, pos, size, style, validator, name)

PyControl = Control

_Window = wx.Window
class Window(wx.Window):
    def __init__(self, parent, id = -1, pos = DefaultPosition, size = DefaultSize, style = 0, name = 'Window'):
        _Window.__init__(self, parent, id, pos, size, style, name)

_HyperlinkCtrl = wx.HyperlinkCtrl
class HyperlinkCtrl(wx.HyperlinkCtrl):
    def __init__(self, parent, id, label, url, pos = DefaultPosition, size = DefaultSize, style = HL_DEFAULT_STYLE, name = 'Hyperlink'):
        _HyperlinkCtrl.__init__(self, parent, id, label, url, pos, size, style, name)

_Panel = wx.Panel
class Panel(wx.Panel):
    def __init__(self, parent, id = -1, pos = DefaultPosition, size = DefaultSize, style = TAB_TRAVERSAL | NO_BORDER, name = 'Panel'):
        _Panel.__init__(self, parent, id, pos, size, style, name)

_MenuItem = wx.MenuItem
class MenuItem(wx.MenuItem):
    def __init__(self, parentMenu = None, id = ID_SEPARATOR, text = '', help = '', kind = wx.ITEM_NORMAL, subMenu = None):
        _MenuItem.__init__(self, parentMenu, id, text, help, kind, subMenu)

_VListBox = VListBox
class VListBox(_VListBox):
    def __init__(self, parent, id = -1, pos = DefaultPosition, size = DefaultSize, style = 0, name = 'VListBox'):
        _VListBox.__init__(self, parent, id, pos, size, style, name)

_SearchCtrl = SearchCtrl
class SearchCtrl(_SearchCtrl):
    def __init__(self, parent, id = -1, value = '', pos = DefaultPosition, size = DefaultSize, style = 0, validator = DefaultValidator, name = 'SearchCtrl'):
        _SearchCtrl.__init__(self, parent, id,  value, pos, size, style, validator, name)

_RadioButton = RadioButton
class RadioButton(_RadioButton):
    def __init__(self, parent, id = -1, label = '', pos = DefaultPosition, size = DefaultSize, style = 0, validator = DefaultValidator, name = 'RadioButton'):
        _RadioButton.__init__(self, parent, id, label, pos, size, style, validator, name)

_SplitterWindow = SplitterWindow
class SplitterWindow(_SplitterWindow):
    def __init__(self, parent, id = -1, pos = DefaultPosition, size = DefaultSize, style = wx.SP_3D, name = 'splitterWindow'):
        _SplitterWindow.__init__(self, parent, id, pos, size, style, name)


class SimplePanel(wx.Panel):
    def __init__(self, parent, id, style):

        print '***', type(parent)
        Panel.__init__(self, parent, id, style = style)
        self.SetBackgroundStyle(BG_STYLE_CUSTOM);

#
# Window
#
def _set_sizer_deleted(win):
    '''
    Window.SetSizer[AndFit] has an argument called "deleteOld" which deletes a
    Window's previous Sizer object for you. This function tells SIP about that
    deletion.
    '''
    old_sizer = win.Sizer
    if old_sizer is not None:
        sip.setdeleted(old_sizer)

_window_setsizer = Window.SetSizer
def _Window_SetSizer(self, sizer, deleteOld = True):
    if deleteOld: _set_sizer_deleted(self)
    return _window_setsizer(self, sizer, deleteOld)

_window_setsizerandfit = Window.SetSizerAndFit
def _Window_SetSizerAndFit(self, sizer, deleteOld = True):
    if deleteOld: _set_sizer_deleted(self)
    return _window_setsizerandfit(self, sizer, deleteOld)

#
# GridBagSizer
#
DefaultSpan = (1, 1)

_gbsizer_add = GridBagSizer.Add

def GridBagSizer_Add(self, item, pos = DefaultPosition, span = DefaultSpan, flag = 0, border = 0):
    if isinstance(item, Size): item = tuple(item)
    return _gbsizer_add(self, item, pos, span, flag, border)
GridBagSizer.Add = GridBagSizer_Add
del GridBagSizer_Add

#
# Sizer
#
_sizer_add = Sizer.Add
def Sizer_Add(self, item, proportion = 0, flag = 0, border = 0):
        return _sizer_add(self, item, proportion, flag, border)
Sizer.Add = Sizer_Add
del Sizer_Add

_sizer_clear = Sizer.Clear
def Sizer_Clear(self, deleteWindows = False):
    return _sizer_clear(self, deleteWindows)
Sizer.Clear = Sizer_Clear
del Sizer_Clear

def Sizer_AddMany(self, seq):
    for item in seq:
        if type(item) != type(()) or (len(item) == 2 and type(item[0]) == type(1)):
            item = (item, )

        try:
            self.Add(*item)
        except Exception:
            print >> _sys.stderr, 'Bad item:', item
            raise

Sizer.AddMany = Sizer_AddMany

#
# EvtHandler
#
_evthandler_bind = EvtHandler.Bind
def EvtHandler_Bind(self, event, func, source = None, id = wx.ID_ANY, id2 = wx.ID_ANY):
    return _evthandler_bind(self, event, func, source, id, id2)
EvtHandler.Bind = EvtHandler_Bind
del EvtHandler_Bind

#
# Size
#
Size.width  = property(attrgetter('x'), lambda s, val: setattr(s, 'x', val))
Size.height = property(attrgetter('y'), lambda s, val: setattr(s, 'y', val))

#
# Rect
#
Rect.left = property(Rect.GetX, Rect.SetX)
Rect.top  = property(Rect.GetY, Rect.SetY)


#
# DC
#
_dc_drawlabel = DC.DrawLabel
def DC_DrawLabel(self, text, rect, alignment = ALIGN_LEFT | ALIGN_TOP, indexAccel = -1):
    return _dc_drawlabel(self, text, rect, alignment, indexAccel)
DC.DrawLabel = DC_DrawLabel
del DC_DrawLabel

_wxtimer = wx.Timer
class PyTimer(_wxtimer):
    def __init__(self, notify):
        _wxtimer.__init__(self)

        assert callable(notify)
        self.notify = notify

    def Notify(self):
        if self.notify:
            self.notify()

#
# MenuBar
#
def MenuBar_GetMenus(self):
    "Return a list of (menu, label) items for the menus in the MenuBar."
    return [(self.GetMenu(i), self.GetLabelTop(i))
            for i in range(self.GetMenuCount())]

def MenuBar_SetMenus(self, items):
    "Clear and add new menus to the MenuBar from a list of (menu, label) items."
    for i in range(self.GetMenuCount()-1, -1, -1):
        self.Remove(i)
    for m, l in items:
        self.Append(m, l)

MenuBar.GetMenus = MenuBar_GetMenus
MenuBar.SetMenus = MenuBar_SetMenus
MenuBar.Menus    = property(MenuBar_GetMenus, MenuBar_SetMenus)

#
# KeyEvent
#

# compatibility constants
WXK_PRIOR = wx.WXK_PAGEUP
WXK_NEXT  = wx.WXK_PAGEDOWN

TIMER_ONE_SHOT = wx.TIMER_ONE_SHOT

class CallLater:
    """
    A convenience class for `wx.Timer`, that calls the given callable
    object once after the given amount of milliseconds, passing any
    positional or keyword args.  The return value of the callable is
    availbale after it has been run with the `GetResult` method.

    If you don't need to get the return value or restart the timer
    then there is no need to hold a reference to this object.  It will
    hold a reference to itself while the timer is running (the timer
    has a reference to self.Notify) but the cycle will be broken when
    the timer completes, automatically cleaning up the wx.CallLater
    object.

    :see: `wx.CallAfter`
    """
    def __init__(self, millis, callable, *args, **kwargs):
        self.millis = millis
        self.callable = callable
        self.SetArgs(*args, **kwargs)
        self.runCount = 0
        self.running = False
        self.hasRun = False
        self.result = None
        self.timer = None
        self.Start()

    def __del__(self):
        self.Stop()


    def Start(self, millis=None, *args, **kwargs):
        """
        (Re)start the timer
        """
        self.hasRun = False
        if millis is not None:
            self.millis = millis
        if args or kwargs:
            self.SetArgs(*args, **kwargs)
        self.Stop()
        self.timer = PyTimer(self.Notify)
        self.timer.Start(self.millis, TIMER_ONE_SHOT)
        self.running = True
    Restart = Start


    def Stop(self):
        """
        Stop and destroy the timer.
        """
        if self.timer is not None:
            self.timer.Stop()
            self.timer = None


    def GetInterval(self):
        if self.timer is not None:
            return self.timer.GetInterval()
        else:
            return 0


    def IsRunning(self):
        return self.timer is not None and self.timer.IsRunning()


    def SetArgs(self, *args, **kwargs):
        """
        (Re)set the args passed to the callable object.  This is
        useful in conjunction with Restart if you want to schedule a
        new call to the same callable object but with different
        parameters.
        """
        self.args = args
        self.kwargs = kwargs


    def HasRun(self):
        return self.hasRun

    def GetResult(self):
        return self.result

    def Notify(self):
        """
        The timer has expired so call the callable.
        """
        if self.callable and getattr(self.callable, 'im_self', True):
            self.runCount += 1
            self.running = False
            self.result = self.callable(*self.args, **self.kwargs)
        self.hasRun = True
        if not self.running:
            # if it wasn't restarted, then cleanup
            CallAfter(self.Stop)

    Interval = property(GetInterval)
    Result = property(GetResult)


class PyDeadObjectError(Exception):
    pass



'''
wxDialog(wxWindow* parent,
         const wxWindowID id = -1,
         const wxString& title = wxEmptyString,
         const wxPoint& pos = wxDefaultPosition,
         const wxSize& size = wxDefaultSize,
         long style = wxDEFAULT_DIALOG_STYLE,
         const wxString& name = wxDialogNameStr) /Transfer/;
'''

# wxPySimpleApp -- calls wxpEntry function

_app = wx.App
_entrystart = wx.EntryStart
_initallimagehandlers = wx.InitAllImageHandlers
_getapp = wx.GetApp

def _wxpy_init():
    try:
        # Allows Ctrl+C to kill apps started by a console.
        import signal
        signal.signal(signal.SIGINT, signal.SIG_DFL)
    except Exception:
        pass

    _entrystart()
    _initallimagehandlers()

_did_wxpy_init = False

class App(_app):
    def __init__(self, *a):
        _app.__init__(self, *a)

        global _did_wxpy_init
        if not _did_wxpy_init:
            # Only call wxEntryStart and other init code once.
            _wxpy_init()
            _did_wxpy_init = True

        self.OnInit()

PySimpleApp = App

wxEVT_KEY_DOWN = wx.EVT_KEY_DOWN
wxEVT_SIZE = wx.EVT_SIZE
wxEVT_MENU_OPEN = wx.EVT_MENU_OPEN
wxEVT_COMMAND_MENU_SELECTED = wx.EVT_COMMAND_MENU_SELECTED
wxEVT_MOUSE_CAPTURE_LOST = wx.EVT_MOUSE_CAPTURE_LOST
wxEVT_MOTION = wx.EVT_MOTION
assert isinstance(wxEVT_MOTION, int)

FindWindowByName = wx.Window.FindWindowByName

Color = wx.Colour
NamedColor = wx.NamedColour
PyBitmapDataObject = wx.BitmapDataObject
PyDropTarget = wx.DropTarget
PyValidator = wx.Validator
PyCommandEvent = wx.CommandEvent

PyScrolledWindow = wx.ScrolledWindow

StockCursor = wx.StockGDI.GetCursor

SystemSettings_GetColour = wx.SystemSettings.GetColour

wx.Window.Enabled = property(wx.Window.IsEnabled, wx.Window.Enable)
wx.Window.Shown   = property(wx.Window.IsShown)

WXPY = True
del wx
