import _wxcore as wx
from _wxcore import *

def PyEventBinder(evttype, n = None):
    return (evttype, )
    

_old_callafter = wx.CallAfter
def CallAfter(func, *a, **k):
    return _old_callafter(lambda: func(*a, **k))

_old_bind = wx.EvtHandler.Bind
def Bind(self, event, cb, source = None, id = -1, id2 = -1):
    print self, type(self)
    return _old_bind(self, event, cb, source, id, id2)

_old_Dialog = wx.Dialog.__init__
def __init__(self, parent = None, id = -1, title = "", pos = wx.DefaultPosition,
             size = wx.DefaultSize, style = wx.DEFAULT_DIALOG_STYLE, name = 'dialogBox'):
    return _old_Dialog(self, parent, id, title, pos, size, style, name)

wx.TopLevelWindow.__repr__ = lambda tlw: '<wx.%s "%s" at %x>' % (type(tlw).__name__, tlw.GetTitle(), id(tlw))

wx.FrameNameStr  = 'Frame'
wx.DialogNameStr = 'Dialog'
    
_frame_init = wx.Frame.__init__
def _new_frame_init(self, parent, id = -1, title = '', pos = wx.DefaultPosition, size = wx.DefaultSize, style = wx.DEFAULT_FRAME_STYLE, name = wx.FrameNameStr):
    _frame_init(self, parent, id, title, pos, size, style, name)
wx.Frame.__init__ = _new_frame_init
del _new_frame_init

_dialog_init = wx.Dialog.__init__
def _new_dialog_init(self, parent, id = -1, title = '', pos = wx.DefaultPosition, size = wx.DefaultSize, style = wx.DEFAULT_DIALOG_STYLE, name = wx.DialogNameStr):
    _dialog_init(self, parent, id, title, pos, size, style, name)
wx.Dialog.__init__ = _new_dialog_init
del _new_dialog_init

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

wxEVT_KEY_DOWN = wx.EVT_KEY_DOWN

Color = wx.Colour
NamedColor = wx.NamedColour
PyBitmapDataObject = wx.BitmapDataObject
PyDropTarget = wx.DropTarget
PyValidator = wx.Validator
PyEvent = wx.Event
PyControl = wx.Control
del wx
