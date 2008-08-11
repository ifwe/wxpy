%Module wx._wxcore

%Copying

copyright 2008 Kevin Watters
released under the wxWidgets License
%End

%Platforms {WXMSW WXCOCOA WXMAC WXGTK}

// Enable stripping of "wx" from Python names, and auto generation of
// properties from GetXXX() and SetXXX() methods.
%SIPOptions (RenameWx, AutoProperties, ThreadChecking)

%UnitCode
#include "stdwxpy.h"
%End // UnitCode

%ModuleHeaderCode
#define WXSIP 1
%End


%Include vector.sip

%Include core.sip
%Include generated/lists.sip
%Include gdi.sip
%Include controls.sip

%ModuleHeaderCode
void add_event(PyObject* module_dict, const char* name, ...);
%End

%ModuleCode
void add_event(PyObject* module_dict, const char* name, ...)
{
    // todo: build tuples, not lists
    va_list argp;
    va_start(argp, name);

    PyObject* list = PyList_New(0);

    int i = va_arg(argp, int);
    while (i)
    {
        PyList_Append(list, PyInt_FromLong(i));
        i = va_arg(argp, int);
    }

    PyObject *tuple = PyList_AsTuple(list);
    PyDict_SetItemString(module_dict, name, tuple);
    Py_DECREF(list);
}
%End // ModuleCode

%PostInitialisationCode

//
// Export add_event for other modules to use.
//
if (0 != sipExportSymbol("wxpy_add_event", (void *)&add_event))
    fprintf(stderr, "error exporting 'wxpy_add_event' symbol\n");

%End

enum
{
    wxEVT_ACTIVATE
};

%PostInitialisationCode

//
// define a macro for adding items to the main module dictionary.
//
#define AddItem(name, obj, class) \
    PyDict_SetItemString(sipModuleDict, name, sipConvertFromInstance((void*)obj, class, NULL));

AddItem("DefaultSize",      &wxDefaultSize,      sipClass_wxSize);
AddItem("DefaultPosition",  &wxDefaultPosition,  sipClass_wxPoint);
AddItem("DefaultValidator", &wxDefaultValidator, sipClass_wxValidator);
PyDict_SetItemString(sipModuleDict, "TextEntryDialogStyle", PyInt_FromLong(wxTextEntryDialogStyle));

AddItem("NORMAL_FONT", wxNORMAL_FONT, sipClass_wxFont);

AddItem("BLACK", wxBLACK, sipClass_wxColour);
AddItem("WHITE", wxWHITE, sipClass_wxColour);
AddItem("RED",   wxRED,   sipClass_wxColour);
AddItem("BLUE",  wxBLUE,  sipClass_wxColour);
AddItem("GREEN", wxGREEN, sipClass_wxColour);

AddItem("TRANSPARENT_PEN",   wxTRANSPARENT_PEN,   sipClass_wxPen);
AddItem("RED_PEN",           wxRED_PEN,           sipClass_wxPen);
AddItem("BLACK_PEN",         wxBLACK_PEN,         sipClass_wxPen);

AddItem("TRANSPARENT_BRUSH", wxTRANSPARENT_BRUSH, sipClass_wxBrush);
AddItem("BLACK_BRUSH",       wxBLACK_BRUSH,       sipClass_wxBrush);
AddItem("WHITE_BRUSH",       wxWHITE_BRUSH,       sipClass_wxBrush);
AddItem("RED_BRUSH",         wxRED_BRUSH,         sipClass_wxBrush);
AddItem("BLUE_BRUSH",        wxBLUE_BRUSH,        sipClass_wxBrush);

AddItem("NullBitmap",        &wxNullBitmap,       sipClass_wxBitmap);


add_event(sipModuleDict, "EVT_TIMER", wxEVT_TIMER, 0);

add_event(sipModuleDict, "EVT_CLOSE", wxEVT_CLOSE_WINDOW, 0);

add_event(sipModuleDict, "EVT_HOTKEY", wxEVT_HOTKEY, 0);
add_event(sipModuleDict, "EVT_MENU_HIGHLIGHT", wxEVT_MENU_HIGHLIGHT, 0);
add_event(sipModuleDict, "EVT_MENU_HIGHLIGHT_ALL", wxEVT_MENU_HIGHLIGHT, 0);
add_event(sipModuleDict, "EVT_WINDOW_CREATE", wxEVT_CREATE, 0);
add_event(sipModuleDict, "EVT_WINDOW_DESTROY", wxEVT_DESTROY, 0);


//
// for compatibility with wxPython :[
//
#define evtconstant(X) PyDict_SetItemString(sipModuleDict, #X, PyInt_FromLong(X));
evtconstant(wxEVT_RIGHT_DOWN)
evtconstant(wxEVT_LEFT_DOWN)
evtconstant(wxEVT_LEFT_UP)
evtconstant(wxEVT_RIGHT_UP)

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


add_event(sipModuleDict, "EVT_TEXT", wxEVT_COMMAND_TEXT_UPDATED, 0);
add_event(sipModuleDict, "EVT_TEXT_ENTER", wxEVT_COMMAND_TEXT_ENTER, 0);
add_event(sipModuleDict, "EVT_TEXT_URL", wxEVT_COMMAND_TEXT_URL, 0);
add_event(sipModuleDict, "EVT_TEXT_MAXLEN", wxEVT_COMMAND_TEXT_MAXLEN, 0);


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

    // Show the SIP version used to build
    PyDict_SetItemString(sipModuleDict, "SIP_VERSION", PyString_FromString(SIP_VERSION_STR));

    // These should be deprecated in favor of the PlatformInfo tuple built below...
    PyDict_SetItemString(sipModuleDict, "Platform", PyString_FromString(wxPlatform));
    PyDict_SetItemString(sipModuleDict, "USE_UNICODE", PyInt_FromLong(wxUSE_UNICODE));
    PyDict_SetItemString(sipModuleDict, "__WXDEBUG__", PyInt_FromLong(wxdebug));
    PyDict_SetItemString(sipModuleDict, "ABI_VERSION", PyInt_FromLong(wxABI_VERSION));

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

