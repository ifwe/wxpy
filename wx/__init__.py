from _wxcore import *
import _wxcore as wx
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
    def __init__(self, parent, id = -1, title = '', pos = wx.DefaultPosition, size = wx.DefaultSize, style = wx.DEFAULT_FRAME_STYLE, name = wx.FrameNameStr):
        wxFrame.__init__(self, parent, id, title, pos, size, style, name)

wxDialog = wx.Dialog
class Dialog(wxDialog):
    def __init__(self, parent, id = -1, title = '', pos = wx.DefaultPosition, size = wx.DefaultSize, style = wx.DEFAULT_DIALOG_STYLE, name = wx.DialogNameStr):
        wxDialog.__init__(self, parent, id, title, pos, size, style, name)

wxTextCtrl = wx.TextCtrl
class TextCtrl(wxTextCtrl):
    def __init__(self, parent, id = -1, value = '', pos = wx.DefaultPosition, size = wx.DefaultSize, style = 0, validator = wx.DefaultValidator, name = 'text control'):
        wxTextCtrl.__init__(self, parent, id, value, pos, size, style, validator, name)

wxStaticText = wx.StaticText
class StaticText(wxStaticText):
    def __init__(self, parent, id = -1, label = '', pos = wx.DefaultPosition, size = wx.DefaultSize, style = 0, name = 'static text'):
        wxStaticText.__init__(self, parent, id, label, pos, size, style, name)

def Sizer_AddMany(self, seq):
    for item in seq:
        if type(item) != type(()) or (len(item) == 2 and type(item[0]) == type(1)):
            item = (item, )
wx.Sizer.AddMany = Sizer_AddMany

_evthandler_bind = wx.EvtHandler.Bind
def EvtHandler_Bind(self, event, func, source = None, id = wx.ID_ANY, id2 = wx.ID_ANY):
    return _evthandler_bind(self, event, func, source, id, id2)
wx.EvtHandler.Bind = EvtHandler_Bind
del EvtHandler_Bind

wx.Size.width  = property(attrgetter('x'), lambda s, val: setattr(s, 'x', val))
wx.Size.height = property(attrgetter('y'), lambda s, val: setattr(s, 'y', val))

_wxtimer = wx.Timer
class PyTimer(_wxtimer):
    def __init__(self, notify):
        _wxtimer.__init__(self)

        assert callable(notify)
        self.notify = notify

    def Notify(self):
        if self.notify:
            self.notify()

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
        self.timer = wx.PyTimer(self.Notify)
        self.timer.Start(self.millis, wx.TIMER_ONE_SHOT)
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
            wx.CallAfter(self.Stop)

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


wxEVT_KEY_DOWN = wx.EVT_KEY_DOWN

FindWindowByName = wx.Window.FindWindowByName

Color = wx.Colour
NamedColor = wx.NamedColour
PyBitmapDataObject = wx.BitmapDataObject
PyDropTarget = wx.DropTarget
PyValidator = wx.Validator
PyEvent = wx.Event
PyCommandEvent = wx.CommandEvent
PyControl = wx.Control
PyScrolledWindow = wx.ScrolledWindow

wxEVT_MOTION = wx.EVT_MOTION
assert isinstance(wxEVT_MOTION, int)

wxEVT_MENU_OPEN = wx.EVT_MENU_OPEN
wxEVT_COMMAND_MENU_SELECTED = wx.EVT_COMMAND_MENU_SELECTED
wxEVT_MOUSE_CAPTURE_LOST = wx.EVT_MOUSE_CAPTURE_LOST

FindWindowAtPointer = lambda: wx.Window.FindWindowAtPoint(wx.GetMousePosition())

StockCursor = wx.StockGDI.GetCursor

SystemSettings_GetColour = wx.SystemSettings.GetColour

del wx

WXPY = True