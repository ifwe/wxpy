%Module _wxcore

%Platforms {WXMSW WXCOCOA WXMAC WXGTK}
%SIPOptions (RenameWx, AutoProperties)

%Include vector.sip

%Include core.sip
%Include gdi.sip
%Include controls.sip

%ModuleHeaderCode
static void add_event(PyObject* module_dict, const char* name, ...);
%End

%ModuleCode
static void add_event(PyObject* module_dict, const char* name, ...)
{
    // todo: build tuples, not lists
    va_list argp;
    va_start(argp, name);
    
    PyObject* list = PyList_New(0);
    
    int i = va_arg(argp, int);
    while (i) {
        PyList_Append(list, PyInt_FromLong(i));        
        i = va_arg(argp, int);
    }
    
    PyObject *tuple = PyList_AsTuple(list);
    PyDict_SetItemString(module_dict, name, tuple);
    Py_DECREF(list);
}
%End

%PostInitialisationCode

//
// define a macro for adding items to the main module dictionary.
//
#define AddItem(name, obj, class) \
    PyDict_SetItemString(sipModuleDict, name, sipConvertFromInstance((void*)obj, class, NULL));

AddItem("DefaultSize",      &wxDefaultSize,      sipClass_wxSize);
AddItem("DefaultPosition",  &wxDefaultPosition,  sipClass_wxPoint);
AddItem("DefaultValidator", &wxDefaultValidator, sipClass_wxValidator);

AddItem("BLACK", wxBLACK, sipClass_wxColour);
AddItem("WHITE", wxWHITE, sipClass_wxColour);
AddItem("RED",   wxRED,   sipClass_wxColour);
AddItem("BLUE",  wxBLUE,  sipClass_wxColour);

AddItem("TRANSPARENT_PEN",   wxTRANSPARENT_PEN,   sipClass_wxPen);
AddItem("TRANSPARENT_BRUSH", wxTRANSPARENT_BRUSH, sipClass_wxBrush);
AddItem("BLACK_BRUSH",       wxBLACK_BRUSH,       sipClass_wxBrush);
AddItem("WHITE_BRUSH",       wxWHITE_BRUSH,       sipClass_wxBrush);
AddItem("NullBitmap",        &wxNullBitmap,       sipClass_wxBitmap);

add_event(sipModuleDict, "EVT_CLOSE", wxEVT_CLOSE_WINDOW, 0);

add_event(sipModuleDict, "EVT_HOTKEY", wxEVT_HOTKEY, 0);
add_event(sipModuleDict, "EVT_MENU_HIGHLIGHT", wxEVT_MENU_HIGHLIGHT, 0);
add_event(sipModuleDict, "EVT_MENU_HIGHLIGHT_ALL", wxEVT_MENU_HIGHLIGHT, 0);
add_event(sipModuleDict, "EVT_WINDOW_CREATE", wxEVT_CREATE, 0);
add_event(sipModuleDict, "EVT_WINDOW_DESTROY", wxEVT_DESTROY, 0);
add_event(sipModuleDict, "EVT_MOUSE_EVENTS", wxEVT_LEFT_DOWN,
                    wxEVT_LEFT_UP,
                    wxEVT_MIDDLE_DOWN,
                    wxEVT_MIDDLE_UP,
                    wxEVT_RIGHT_DOWN,
                    wxEVT_RIGHT_UP,
                    wxEVT_MOTION,
                    wxEVT_LEFT_DCLICK,
                    wxEVT_MIDDLE_DCLICK,
                    wxEVT_RIGHT_DCLICK,
                    wxEVT_ENTER_WINDOW,
                    wxEVT_LEAVE_WINDOW,
                    wxEVT_MOUSEWHEEL, 0);

add_event(sipModuleDict, "EVT_SCROLLWIN", wxEVT_SCROLLWIN_TOP,
                 wxEVT_SCROLLWIN_BOTTOM,
                 wxEVT_SCROLLWIN_LINEUP,
                 wxEVT_SCROLLWIN_LINEDOWN,
                 wxEVT_SCROLLWIN_PAGEUP,
                 wxEVT_SCROLLWIN_PAGEDOWN,
                 wxEVT_SCROLLWIN_THUMBTRACK,
                 wxEVT_SCROLLWIN_THUMBRELEASE, 0);

add_event(sipModuleDict, "EVT_SCROLL", wxEVT_SCROLL_TOP,
              wxEVT_SCROLL_BOTTOM,
              wxEVT_SCROLL_LINEUP,
              wxEVT_SCROLL_LINEDOWN,
              wxEVT_SCROLL_PAGEUP,
              wxEVT_SCROLL_PAGEDOWN,
              wxEVT_SCROLL_THUMBTRACK,
              wxEVT_SCROLL_THUMBRELEASE, 0);

//add_event(sipModuleDict, "EVT_SCROLL_ENDSCROLL", EVT_SCROLL_CHANGED, 0);

add_event(sipModuleDict, "EVT_COMMAND_SCROLL", wxEVT_SCROLL_TOP,
                      wxEVT_SCROLL_BOTTOM,
                      wxEVT_SCROLL_LINEUP,
                      wxEVT_SCROLL_LINEDOWN,
                      wxEVT_SCROLL_PAGEUP,
                      wxEVT_SCROLL_PAGEDOWN,
                      wxEVT_SCROLL_THUMBTRACK,
                      wxEVT_SCROLL_THUMBRELEASE,
                      //wxEVT_SCROLL_CHANGED, 
                      0);

add_event(sipModuleDict, "EVT_COMMAND_SCROLL_TOP", wxEVT_SCROLL_TOP, 0);
add_event(sipModuleDict, "EVT_COMMAND_SCROLL_BOTTOM", wxEVT_SCROLL_BOTTOM, 0);
add_event(sipModuleDict, "EVT_COMMAND_SCROLL_LINEUP", wxEVT_SCROLL_LINEUP, 0);
add_event(sipModuleDict, "EVT_COMMAND_SCROLL_LINEDOWN", wxEVT_SCROLL_LINEDOWN, 0);
add_event(sipModuleDict, "EVT_COMMAND_SCROLL_PAGEUP", wxEVT_SCROLL_PAGEUP, 0);
add_event(sipModuleDict, "EVT_COMMAND_SCROLL_PAGEDOWN", wxEVT_SCROLL_PAGEDOWN, 0);
add_event(sipModuleDict, "EVT_COMMAND_SCROLL_THUMBTRACK", wxEVT_SCROLL_THUMBTRACK, 0);
add_event(sipModuleDict, "EVT_COMMAND_SCROLL_THUMBRELEASE", wxEVT_SCROLL_THUMBRELEASE, 0);
//add_event(sipModuleDict, "EVT_COMMAND_SCROLL_CHANGED", wxEVT_SCROLL_CHANGED, 0);
//add_event(sipModuleDict, "EVT_COMMAND_SCROLL_ENDSCROLL", EVT_COMMAND_SCROLL_CHANGED, 0);

add_event(sipModuleDict, "EVT_BUTTON", wxEVT_COMMAND_BUTTON_CLICKED, 0);
add_event(sipModuleDict, "EVT_CHECKBOX", wxEVT_COMMAND_CHECKBOX_CLICKED, 0);
add_event(sipModuleDict, "EVT_CHOICE", wxEVT_COMMAND_CHOICE_SELECTED, 0);
add_event(sipModuleDict, "EVT_LISTBOX", wxEVT_COMMAND_LISTBOX_SELECTED, 0);
add_event(sipModuleDict, "EVT_LISTBOX_DCLICK", wxEVT_COMMAND_LISTBOX_DOUBLECLICKED, 0);
add_event(sipModuleDict, "EVT_MENU", wxEVT_COMMAND_MENU_SELECTED, 0);
add_event(sipModuleDict, "EVT_MENU_RANGE", wxEVT_COMMAND_MENU_SELECTED, 0);
add_event(sipModuleDict, "EVT_SLIDER", wxEVT_COMMAND_SLIDER_UPDATED, 0);
add_event(sipModuleDict, "EVT_RADIOBOX", wxEVT_COMMAND_RADIOBOX_SELECTED, 0);
add_event(sipModuleDict, "EVT_RADIOBUTTON", wxEVT_COMMAND_RADIOBUTTON_SELECTED, 0);

add_event(sipModuleDict, "EVT_SCROLLBAR", wxEVT_COMMAND_SCROLLBAR_UPDATED, 0);
add_event(sipModuleDict, "EVT_VLBOX", wxEVT_COMMAND_VLBOX_SELECTED, 0);
add_event(sipModuleDict, "EVT_COMBOBOX", wxEVT_COMMAND_COMBOBOX_SELECTED, 0);
add_event(sipModuleDict, "EVT_TOOL", wxEVT_COMMAND_TOOL_CLICKED, 0);
add_event(sipModuleDict, "EVT_TOOL_RANGE", wxEVT_COMMAND_TOOL_CLICKED, 0);
add_event(sipModuleDict, "EVT_TOOL_RCLICKED", wxEVT_COMMAND_TOOL_RCLICKED, 0);
add_event(sipModuleDict, "EVT_TOOL_RCLICKED_RANGE", wxEVT_COMMAND_TOOL_RCLICKED, 0);
add_event(sipModuleDict, "EVT_TOOL_ENTER", wxEVT_COMMAND_TOOL_ENTER, 0);
add_event(sipModuleDict, "EVT_CHECKLISTBOX", wxEVT_COMMAND_CHECKLISTBOX_TOGGLED, 0);


add_event(sipModuleDict, "EVT_TEXT_CUT",    wxEVT_COMMAND_TEXT_CUT, 0);
add_event(sipModuleDict, "EVT_TEXT_COPY",   wxEVT_COMMAND_TEXT_COPY, 0);
add_event(sipModuleDict, "EVT_TEXT_PASTE",  wxEVT_COMMAND_TEXT_PASTE, 0);



/*

%constant wxEventType wxEVT_TASKBAR_MOVE;
%constant wxEventType wxEVT_TASKBAR_LEFT_DOWN;
%constant wxEventType wxEVT_TASKBAR_LEFT_UP;
%constant wxEventType wxEVT_TASKBAR_RIGHT_DOWN;
%constant wxEventType wxEVT_TASKBAR_RIGHT_UP;
%constant wxEventType wxEVT_TASKBAR_LEFT_DCLICK;
%constant wxEventType wxEVT_TASKBAR_RIGHT_DCLICK;
%constant wxEventType wxEVT_TASKBAR_CLICK;


%pythoncode {
EVT_TASKBAR_MOVE = wx.PyEventBinder (         wxEVT_TASKBAR_MOVE )
EVT_TASKBAR_LEFT_DOWN = wx.PyEventBinder (    wxEVT_TASKBAR_LEFT_DOWN )
EVT_TASKBAR_LEFT_UP = wx.PyEventBinder (      wxEVT_TASKBAR_LEFT_UP )
EVT_TASKBAR_RIGHT_DOWN = wx.PyEventBinder (   wxEVT_TASKBAR_RIGHT_DOWN )
EVT_TASKBAR_RIGHT_UP = wx.PyEventBinder (     wxEVT_TASKBAR_RIGHT_UP )
EVT_TASKBAR_LEFT_DCLICK = wx.PyEventBinder (  wxEVT_TASKBAR_LEFT_DCLICK )
EVT_TASKBAR_RIGHT_DCLICK = wx.PyEventBinder ( wxEVT_TASKBAR_RIGHT_DCLICK )
EVT_TASKBAR_CLICK =  wx.PyEventBinder (       wxEVT_TASKBAR_CLICK )
}
*/


#ifdef __WXMOTIF__
#define wxPlatform "__WXMOTIF__"
#define wxPlatName "wxMotif"
#endif
#ifdef __WXX11__
#define wxPlatform "__WXX11__"
#define wxPlatName "wxX11"
#endif
#ifdef __WXGTK__
#define wxPlatform "__WXGTK__"
#define wxPlatName "wxGTK"
#endif
#ifdef __WXMSW__
#define wxPlatform "__WXMSW__"
#define wxPlatName "wxMSW"
#endif
#ifdef __WXMAC__
#define wxPlatform "__WXMAC__"
#define wxPlatName "wxMac"
#endif


#ifdef __WXDEBUG__
    int wxdebug = 1;
#else
    int wxdebug = 0;
#endif


        // These should be deprecated in favor of the PlatformInfo tuple built below...
        PyDict_SetItemString(sipModuleDict, "Platform", PyString_FromString(wxPlatform));
        PyDict_SetItemString(sipModuleDict, "USE_UNICODE", PyInt_FromLong(wxUSE_UNICODE));
        PyDict_SetItemString(sipModuleDict, "__WXDEBUG__", PyInt_FromLong(wxdebug));

        // Make a tuple of strings that gives more info about the platform.
        PyObject* PlatInfo = PyList_New(0);
        PyObject* obj;

    #define _AddInfoString(st) \
        obj = PyString_FromString(st); \
        PyList_Append(PlatInfo, obj); \
        Py_DECREF(obj)

        _AddInfoString(wxPlatform);
        _AddInfoString(wxPlatName);
    #if wxUSE_UNICODE
        _AddInfoString("unicode");
    #else
        _AddInfoString("ansi");
    #endif
    #ifdef __WXGTK__
    #ifdef __WXGTK20__
        _AddInfoString("gtk2");
    #else
        _AddInfoString("gtk1");
    #endif
    #endif
    #ifdef __WXDEBUG__
        _AddInfoString("wx-assertions-on");
    #else
        _AddInfoString("wx-assertions-off");
    #endif
//        _AddInfoString(wxPy_SWIG_VERSION);    
    #ifdef __WXMAC__
        #if wxMAC_USE_CORE_GRAPHICS
            _AddInfoString("mac-cg");
        #else
            _AddInfoString("mac-qd");
        #endif
        #if wxMAC_USE_NATIVE_TOOLBAR
            _AddInfoString("mac-native-tb");
        #else
            _AddInfoString("mac-no-native-tb");
        #endif
    #endif

    #undef _AddInfoString

        PyObject* PlatInfoTuple = PyList_AsTuple(PlatInfo);
        Py_DECREF(PlatInfo);
        PyDict_SetItemString(sipModuleDict, "PlatformInfo", PlatInfoTuple);


%End

