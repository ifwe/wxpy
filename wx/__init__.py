'''
wxpy

python additions
'''

import os.path, sys

# make sure "wx" is on the syspath
_wxpy_dir = os.path.split(os.path.abspath(__file__))[0]
if not _wxpy_dir in sys.path:
    sys.path.append(_wxpy_dir)
del _wxpy_dir


VERSION = (1, 0, 0, 0)
USE_UNICODE = True
WXPY = True

import sip, new
from functools import wraps

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

#sip.settracemask(SipTrace.ALL)

def tracing(enable):
    sip.settracemask(SipTrace.ALL if enable else 0)

def autorepr(s = None):
    if s is not None:
        assert isinstance(s, basestring)
        def __repr__(self):
            return '<%s %s>' % (self.__class__.__name__, s % vars(self))
    else:
        def __repr__(self):
            return '<%s at %x>' % (self.__class__.__name__, id(self))

    return __repr__

#
# import all names from _wxcore
#
from _wxcore import *
import _wxcore as wx

import sys as _sys
from operator import attrgetter

def PyEventBinder(evttype, n = None):
    return (evttype, )

_callafter = wx.CallAfter
from traceback import print_exc
def CallAfter(func, *a, **k):
    assert callable(func), repr(func)

    def CallAfterCallback():
        try:
            func(*a, **k)
        except Exception:
            print_exc()

    return _callafter(CallAfterCallback)

#wx.TopLevelWindow.__repr__ = lambda tlw: '<wx.%s "%s" at %x>' % (type(tlw).__name__, tlw.GetTitle(), id(tlw))

wx.FrameNameStr  = 'Frame'
wx.DialogNameStr = 'Dialog'

_Frame = wx.Frame
class Frame(_Frame):
    def __init__(self, parent, id = -1, title = '', pos = DefaultPosition, size = DefaultSize, style = DEFAULT_FRAME_STYLE, name = wx.FrameNameStr):
        _Frame.__init__(self, parent, id, title, pos, size, style, name)

_Frame.CentreOnScreen = new.instancemethod(_Frame.CenterOnScreen, None, _Frame)

_Dialog = wx.Dialog
class Dialog(_Dialog):
    def __init__(self, parent, id = -1, title = '', pos = DefaultPosition, size = DefaultSize, style = DEFAULT_DIALOG_STYLE, name = wx.DialogNameStr):
        _Dialog.__init__(self, parent, id, title, Point(*pos), Size(*size), style, name)

_TextCtrl = wx.TextCtrl
class TextCtrl(_TextCtrl):
    def __init__(self, parent, id = -1, value = '', pos = DefaultPosition, size = DefaultSize, style = 0, validator = wx.DefaultValidator, name = 'text control'):
        _TextCtrl.__init__(self, parent, id, value, pos, size, style, validator, name)

_StaticText = wx.StaticText
class StaticText(_StaticText):
    def __init__(self, parent, id = -1, label = '', pos = DefaultPosition, size = DefaultSize, style = 0, name = 'static text'):
        _StaticText.__init__(self, parent, id, label, pos, size, style, name)

_StaticBox = wx.StaticBox
class StaticBox(_StaticBox):
    def __init__(self, parent, id, label, pos = DefaultPosition, size = DefaultSize, style = 0, name = "staticBox"):
        _StaticBox.__init__(self, parent, id, label, pos, size, style, name)

_StaticBoxSizer = wx.StaticBoxSizer
class StaticBoxSizer(_StaticBoxSizer):
    def __init__(self, box, orient):
        _StaticBoxSizer.__init__(self, box, orient)

#wxFont = wx.Font
#class Font(wxFont):
#    def __init__(self, pointSize, family, style, weight, underline = False, faceName = "", encoding = wx.FONTENCODING_DEFAULT):
#
#        wxFont.__init__(self, pointSize, family, style, weight, underline, faceName, encoding)

Font.init_args = init_args = ('pointSize', 'family', 'style', 'weight', 'underline', 'faceName', 'encoding')

_Control = wx.Control
class Control(_Control):
    def __init__(self, parent, id = -1, pos = DefaultPosition, size = DefaultSize, style = 0, validator = wx.DefaultValidator, name = 'Control'):
        _Control.__init__(self, parent, id, pos, size, style, validator, name)

PyControl = Control

_Window = wx.Window
class Window(wx.Window):
    def __init__(self, parent, id = -1, pos = DefaultPosition, size = DefaultSize, style = 0, name = 'Window'):
        _Window.__init__(self, parent, id, Point(*pos), Size(*size), style, name)

_HyperlinkCtrl = wx.HyperlinkCtrl
class HyperlinkCtrl(wx.HyperlinkCtrl):
    def __init__(self, parent, id, label, url, pos = DefaultPosition, size = DefaultSize, style = HL_DEFAULT_STYLE, name = 'Hyperlink'):
        _HyperlinkCtrl.__init__(self, parent, id, label, url, pos, size, style, name)

_Panel = wx.Panel
class Panel(wx.Panel):
    def __init__(self, parent, id = -1, pos = DefaultPosition, size = DefaultSize, style = TAB_TRAVERSAL | NO_BORDER, name = 'Panel'):
        _Panel.__init__(self, parent, id, Point(*pos), Size(*size), style, name)

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

_ScrolledWindow = ScrolledWindow
class ScrolledWindow(_ScrolledWindow):
    def __init__(self, parent, id = -1, pos = DefaultPosition, size = DefaultSize, style = HSCROLL | VSCROLL, name = 'scrolledWindow'):
        _ScrolledWindow.__init__(self, parent, id, pos, size, style, name)

_Notebook = wx.Notebook
class Notebook(_Notebook):
    def __init__(self, parent, id = -1, pos = wx.DefaultPosition, size = wx.DefaultSize, style = 0, name = 'notebook'):
        _Notebook.__init__(self, parent, id, pos, size, style, name)

_TextEntryDialog = TextEntryDialog
class TextEntryDialog(_TextEntryDialog):
    def __init__(self, parent, message, caption = u'Input Text', defaultValue = '', style = TextEntryDialogStyle, pos = DefaultPosition):
        _TextEntryDialog.__init__(self, parent, message, caption, defaultValue, style, pos)

_CheckBox = CheckBox
class CheckBox(_CheckBox):
    def __init__(self, parent, id = ID_ANY, label = '', pos = DefaultPosition, size = DefaultSize, style = 0, validator = DefaultValidator, name = 'checkBox'):
        _CheckBox.__init__(self, parent, id, label, pos, size, style, validator, name)

_Choice = Choice
class Choice(_Choice):
    def __init__(self, parent, id = -1, pos = DefaultPosition, size = DefaultSize, choices = None, style = 0, validator = DefaultValidator, name = 'choice'):
        _Choice.__init__(self, parent, id, pos, size, choices, style, validator, name)

_Slider = Slider
class Slider(_Slider):
    def __init__(self, parent, id = -1, value = 0, minValue = 0, maxValue = 100,
                         pos = DefaultPosition, size = DefaultSize, style = SL_HORIZONTAL,
                         validator = DefaultValidator, name = 'slider'):
        _Slider.__init__(self, parent, id, value, minValue, maxValue,
                         pos, size, style, validator, name)


_BoxSizer = BoxSizer
class BoxSizer(_BoxSizer):
    def __init__(self, orient):
        _BoxSizer.__init__(self, orient)

_GridBagSizer = GridBagSizer
class GridBagSizer(_GridBagSizer):
    def __init__(self, vgap = 0, hgap = 0):
        _GridBagSizer.__init__(self, vgap, hgap)

_GridSizer = GridSizer
class GridSizer(_GridSizer):
    def __init__(self, rows = 1, cols = 0, vgap = 0, hgap = 0):
        _GridSizer.__init__(self, rows, cols, vgap, hgap)

_FlexGridSizer = FlexGridSizer
class FlexGridSizer(_FlexGridSizer):
    def __init__(self, rows = 1, cols = 0, vgap = 0, hgap = 0):
        _FlexGridSizer.__init__(self, rows, cols, vgap, hgap)

_Gauge = Gauge
class Gauge(_Gauge):
    def __init__(self, parent, id = -1, range = 100, pos = DefaultPosition, size = DefaultSize, style = GA_HORIZONTAL,
                 validator = DefaultValidator, name = "gauge"):
        _Gauge.__init__(self, parent, id, range, pos, size, style, validator, name)

wxDIRP_DEFAULT_STYLE = DIRP_DEFAULT_STYLE

_DirPickerCtrl = DirPickerCtrl
class DirPickerCtrl(_DirPickerCtrl):
    def __init__(self, parent, id=-1, path='', message = 'Select a folder',
                    pos = DefaultPosition, size = DefaultSize, style = wxDIRP_DEFAULT_STYLE,
                    validator = DefaultValidator, name = 'dirpicker'):
        _DirPickerCtrl.__init__(self, parent, id, path, message, pos, size, style, validator, name)

wxFLP_DEFAULT_STYLE = FLP_DEFAULT_STYLE

_FilePickerCtrl = FilePickerCtrl
class FilePickerCtrl(_FilePickerCtrl):
    def __init__(self, parent, id=-1, path='', message = 'Select a file',
                 wildcard = '*.*', pos = DefaultPosition,
                 size = DefaultSize, style = wxFLP_DEFAULT_STYLE, validator = DefaultValidator,
                 name = 'filepicker'):
        _FilePickerCtrl.__init__(self, parent, id, path, message, wildcard, pos, size, style, validator, name)


_FileDialog = FileDialog
class FileDialog(_FileDialog):
    def __init__(self, parent, message = 'Select a file', defaultDir = '', defaultFile = '',
                             wildcard = '*.*', style = FD_DEFAULT_STYLE, pos = DefaultPosition):
        _FileDialog.__init__(self, parent, message, defaultDir, defaultFile, wildcard, style, pos)


_ComboBox = ComboBox
class ComboBox(_ComboBox):
    def __init__(self, parent, id, value = '', pos = DefaultPosition, size = DefaultSize,
                 choices = None, style = 0, validator = DefaultValidator, name = "comboBox"):
        _ComboBox.__init__(self, parent, id, value, pos, size, [] if choices is None else choices,
                           style, validator, name)

_CustomDataObject = CustomDataObject
class CustomDataObject(_CustomDataObject):
    def __init__(self, obj):
        if isinstance(obj, basestring):
            return _CustomDataObject.__init__(self, CustomDataFormat(obj))
        else:
            return _CustomDataObject.__init__(self, obj)

_ListCtrl = ListCtrl
class ListCtrl(_ListCtrl):
    def __init__(self, parent, id = -1, pos = DefaultPosition, size = DefaultSize,
                 style = LC_ICON, validator = DefaultValidator, name = 'listCtrl'):
        _ListCtrl.__init__(self, parent, id, pos, size, style, validator, name)

    def Select(self, idx, on=1):
        '''[de]select an item'''
        if on: state = LIST_STATE_SELECTED
        else: state = 0
        self.SetItemState(idx, state, LIST_STATE_SELECTED)

    def Focus(self, idx):
        '''Focus and show the given item'''
        self.SetItemState(idx, LIST_STATE_FOCUSED, LIST_STATE_FOCUSED)
        self.EnsureVisible(idx)

    def GetFocusedItem(self):
        '''get the currently focused item or -1 if none'''
        return self.GetNextItem(-1, LIST_NEXT_ALL, LIST_STATE_FOCUSED)

    def GetFirstSelected(self, *args):
        '''return first selected item, or -1 when none'''
        return self.GetNextSelected(-1)

    def GetNextSelected(self, item):
        '''return subsequent selected items, or -1 when no more'''
        return self.GetNextItem(item, LIST_NEXT_ALL, LIST_STATE_SELECTED)

    def IsSelected(self, idx):
        '''return True if the item is selected'''
        return (self.GetItemState(idx, LIST_STATE_SELECTED) & LIST_STATE_SELECTED) != 0

    def SetColumnImage(self, col, image):
        item = self.GetColumn(col)
        # preserve all other attributes too
        item.SetMask( LIST_MASK_STATE |
                      LIST_MASK_TEXT  |
                      LIST_MASK_IMAGE |
                      LIST_MASK_DATA  |
                      LIST_SET_ITEM   |
                      LIST_MASK_WIDTH |
                      LIST_MASK_FORMAT )
        item.SetImage(image)
        self.SetColumn(col, item)

    def ClearColumnImage(self, col):
        self.SetColumnImage(col, -1)

    def Append(self, entry):
        '''Append an item to the list control.  The entry parameter should be a
           sequence with an item for each column'''
        if len(entry):
            if USE_UNICODE:
                cvtfunc = unicode
            else:
                cvtfunc = str
            pos = self.GetItemCount()
            self.InsertStringItem(pos, cvtfunc(entry[0]))
            for i in range(1, len(entry)):
                self.SetStringItem(pos, i, cvtfunc(entry[i]))
            return pos

ItemContainer.GetItems = lambda self: [self.GetString(i) for i in xrange(self.GetCount())]

def SetItems(self, items):
    self.Clear()
    for item in items:
        self.Append(item)

ItemContainer.SetItems = SetItems
del SetItems

ItemContainer.Items = property(ItemContainer.GetItems, ItemContainer.SetItems)

_Button = wx.Button
class Button(wx.Button):
    def __init__(self, parent, id = -1, label = '', pos = DefaultPosition, size = DefaultSize, style = 0,
                 validator = DefaultValidator, name = 'button'):
        _Button.__init__(self, parent, id, label, pos, size, style, validator, name)

_PopupTransientWindow = wx.PopupTransientWindow
class PopupTransientWindow(_PopupTransientWindow):
    def __init__(self, window, style = BORDER_NONE):
        _PopupTransientWindow.__init__(self, window, style)

#class SimplePanel(wx.Panel):
#    def __init__(self, parent, id, style):
#        Panel.__init__(self, parent, id, style = style)
#        self.SetBackgroundStyle(BG_STYLE_CUSTOM)




#_ScrolledWindow = ScrolledWindow
#class ScrolledWindow(ScrolledWindow):
#    def __init__(self, parent, id = -1, pos = DefaultPosition, size = DefaultSize, style = HSCROLL | VSCROLL, name = 'scrolledWindow'):
#        _ScrolledWindow.__init__(self, parent, id, pos, size, style, name)

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
# Notebook
#
_notebook_addpage = Notebook.AddPage
@wraps(_notebook_addpage)
def Notebook_AddPage(self, page, text, select = False, imageId = -1):
    return _notebook_addpage(self, page, text, select, imageId)
Notebook.AddPage = Notebook_AddPage
del Notebook_AddPage
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
Rect.bottom = property(Rect.GetBottom, Rect.SetBottom)
Rect.right = property(Rect.GetRight, Rect.SetRight)


#
# DC
#
_dc_drawlabel = DC.DrawLabel
def DC_DrawLabel(self, text, rect, alignment = ALIGN_LEFT | ALIGN_TOP, indexAccel = -1):
    return _dc_drawlabel(self, text, rect, alignment, indexAccel)
DC.DrawLabel = DC_DrawLabel
del DC_DrawLabel




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
# Functions
#

_MessageBox = MessageBox
def MessageBox(message, caption = 'Message', style = OK, parent = None, x = -1, y = -1):
    return _MessageBox(message, caption, style, parent, x, y)

#
# KeyEvent
#

# compatibility constants
WXK_PRIOR = wx.WXK_PAGEUP
WXK_NEXT  = wx.WXK_PAGEDOWN


class CallLater(object):
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
    def __init__(self, millis, cb, *args, **kwargs):
        self.millis = millis
        self.callable = cb

        self.SetArgs(*args, **kwargs)
        self.runCount = 0
        self.running = False
        self.hasRun = False
        self.result = None
        self.timer = None
        self.Start()


#    def __del__(self):
#        self.Stop()

    def Start(self, millis=None, *args, **kwargs):
        '(Re)start the timer'

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
        'Stop and destroy the timer.'
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


PyDeadObjectError = sip.DeadObjectException

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

_app = wx.PyApp
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

    try:
        # make sure HTML tag modules get loaded
        import lib.wxpTag
    except Exception:
        from traceback import print_exc; print_exc()

    assert True == HandleFatalExceptions()

    _entrystart()
    _initallimagehandlers()


_did_wxpy_init = False

class App(_app):
    def __init__(self, appname = None, redirect = None):
        _app.__init__(self)
        if appname is not None:
            self.SetAppName(appname)

        global _did_wxpy_init
        if not _did_wxpy_init:
            # Only call wxEntryStart and other init code once.
            _wxpy_init()
            _did_wxpy_init = True


        self.OnInit()

PySimpleApp = App

wxEVT_ACTIVATE = wx.EVT_ACTIVATE
wxEVT_KEY_DOWN = wx.EVT_KEY_DOWN
wxEVT_SIZE = wx.EVT_SIZE
wxEVT_MENU_CLOSE = wx.EVT_MENU_CLOSE
wxEVT_MENU_OPEN = wx.EVT_MENU_OPEN
wxEVT_COMMAND_MENU_SELECTED = wx.EVT_COMMAND_MENU_SELECTED
wxEVT_MOUSE_CAPTURE_LOST = wx.EVT_MOUSE_CAPTURE_LOST
wxEVT_MOTION = wx.EVT_MOTION
wxEVT_COMMAND_BUTTON_CLICKED = wx.EVT_COMMAND_BUTTON_CLICKED

wxEVT_COMMAND_LIST_ITEM_FOCUSED = EVT_COMMAND_LIST_ITEM_FOCUSED
wxEVT_COMMAND_LIST_ITEM_SELECTED = EVT_COMMAND_LIST_ITEM_SELECTED
wxEVT_COMMAND_LIST_ITEM_DESELECTED = EVT_COMMAND_LIST_ITEM_DESELECTED
wxEVT_COMMAND_LISTBOX_DOUBLECLICKED = EVT_COMMAND_LIST_ITEM_DESELECTED
wxEVT_COMMAND_LISTBOX_SELECTED = EVT_COMMAND_LISTBOX_SELECTED

wxEVT_COMMAND_CHECKBOX_CLICKED = EVT_COMMAND_CHECKBOX_CLICKED

wxEVT_COMMAND_TOGGLEBUTTON_CLICKED = EVT_COMMAND_TOGGLEBUTTON_CLICKED

# CYAN didn't work, must be not in 2.8???
CYAN_BRUSH = Brush(Colour(32, 178, 170))

assert isinstance(wxEVT_MOTION, int)


EVT_SPLITTER_DCLICK = EVT_SPLITTER_DOUBLECLICKED

FindWindowByName = wx.Window.FindWindowByName

Color = wx.Colour
NamedColor = wx.NamedColour
PyBitmapDataObject = wx.BitmapDataObject
PyDropTarget = wx.DropTarget
PyValidator = wx.Validator
CommandEvent.Checked = property(CommandEvent.IsChecked)
PyCommandEvent = wx.CommandEvent

PyScrolledWindow = ScrolledWindow

SystemSettings_GetColour = wx.SystemSettings.GetColour

# until enum properties work correctly
_Window.LayoutDirection = property(_Window.GetLayoutDirection, _Window.SetLayoutDirection)

wx.Window.Enabled  = property(wx.Window.IsEnabled, wx.Window.Enable)
wx.Window.Shown    = property(wx.Window.IsShown)
wx.Window.TopLevel = property(wx.Window.IsTopLevel)

BusyCursor = lambda: 'WXPYHACK'

BeginBusyCursor = lambda: 'WXPYHACK'
EndBusyCursor = lambda: 'WXPYHACK'

GetDefaultPyEncoding = lambda: 'utf-8'

TreeItemData = PyTreeItemData
FutureCall = CallLater

#DateTimeFromDMY = DateTime

#TreeCtrl.GetPyData = new.instancemethod(TreeCtrl.GetItemPyData, None, TreeCtrl)

del wx
