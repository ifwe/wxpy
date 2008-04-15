%Platforms {WXMSW WXCOCOA WXMAC WXGTK}

%Module wx

%SIPOptions (RenameWx, AutoProperties)

%Include core.sip
%Include gdi.sip
%Include controls.sip

%ModuleHeaderCode
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

    PyDict_SetItemString(module_dict, name, list);
    Py_DECREF(list);
}
%End

%PostInitialisationCode

PyDict_SetItemString(sipModuleDict, "DefaultSize", sipConvertFromInstance((void*)&wxDefaultSize, sipClass_wxSize, NULL));
PyDict_SetItemString(sipModuleDict, "DefaultPosition", sipConvertFromInstance((void*)&wxDefaultPosition, sipClass_wxPoint, NULL));


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


%End

