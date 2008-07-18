%ModuleHeaderCode
void add_event(PyObject* module_dict, const char* name, ...);
#ifndef WXPY_PREC
#include <wx/taskbar.h>
#endif
%End

%PostInitialisationCode
add_event(sipModuleDict, "EVT_TASKBAR_MOVE",       wxEVT_TASKBAR_MOVE, 0);
add_event(sipModuleDict, "EVT_TASKBAR_LEFT_DOWN",  wxEVT_TASKBAR_LEFT_DOWN, 0);
add_event(sipModuleDict, "EVT_TASKBAR_LEFT_UP",    wxEVT_TASKBAR_LEFT_UP, 0);
add_event(sipModuleDict, "EVT_TASKBAR_RIGHT_DOWN", wxEVT_TASKBAR_RIGHT_DOWN, 0);

add_event(sipModuleDict, "EVT_TASKBAR_RIGHT_UP",     wxEVT_TASKBAR_RIGHT_UP, 0);
add_event(sipModuleDict, "EVT_TASKBAR_LEFT_DCLICK",  wxEVT_TASKBAR_LEFT_DCLICK, 0);
add_event(sipModuleDict, "EVT_TASKBAR_RIGHT_DCLICK", wxEVT_TASKBAR_RIGHT_DCLICK, 0);
add_event(sipModuleDict, "EVT_TASKBAR_CLICK",        wxEVT_TASKBAR_CLICK, 0);
%End

class wxTaskBarIcon : wxEvtHandler
{
public:
    wxTaskBarIcon() /Transfer/;
    virtual ~wxTaskBarIcon();

    void Destroy();
%MethodCode
    delete sipCpp;
%End

    bool IsOk() const;
    bool IsIconInstalled() const;
    bool SetIcon(const wxIcon& icon, const wxString& tooltip = wxEmptyString);
    bool RemoveIcon();
    bool PopupMenu(wxMenu *menu);

%If (wxUSE_TASKBARICON_BALLOONS)
    bool ShowBalloon(const wxString& title,
                     const wxString& text,
                     unsigned msec = 0,
                     int flags = 0);
%End
};



class wxTaskBarIconEvent : wxEvent
{
public:
    wxTaskBarIconEvent(wxEventType evtType, wxTaskBarIcon *tbIcon);
    virtual ~wxTaskBarIconEvent();
};
