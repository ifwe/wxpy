%ModuleHeaderCode
void add_event(PyObject* module_dict, const char* name, ...);
%End

%PostInitialisationCode
add_event(sipModuleDict, "EVT_POWER_SUSPENDING",      wxEVT_POWER_SUSPENDING, 0);
add_event(sipModuleDict, "EVT_POWER_SUSPENDED",       wxEVT_POWER_SUSPENDED, 0);
add_event(sipModuleDict, "EVT_POWER_SUSPEND_CANCEL",  wxEVT_POWER_SUSPEND_CANCEL, 0);
add_event(sipModuleDict, "EVT_POWER_RESUME",          wxEVT_POWER_RESUME, 0);
%End

enum {
    wxEVT_POWER_SUSPENDING,
    wxEVT_POWER_SUSPENDED,
    wxEVT_POWER_SUSPEND_CANCEL,
    wxEVT_POWER_RESUME,
};

enum wxPowerType
{
    wxPOWER_SOCKET,
    wxPOWER_BATTERY,
    wxPOWER_UNKNOWN
};

enum wxBatteryState
{
    wxBATTERY_NORMAL_STATE,    // system is fully usable
    wxBATTERY_LOW_STATE,       // start to worry
    wxBATTERY_CRITICAL_STATE,  // save quickly
    wxBATTERY_SHUTDOWN_STATE,  // too late
    wxBATTERY_UNKNOWN_STATE
};


class wxPowerEvent : wxEvent
{
public:
    wxPowerEvent(wxEventType evtType);
    void Veto();
    bool IsVetoed() const;
};

wxPowerType wxGetPowerType();
wxBatteryState wxGetBatteryState();
