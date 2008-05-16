%If (!wxUSE_HOTKEY)
%ModuleHeaderCode
#define wxEVT_HOTKEY -9999
%End
%End


%ModuleHeaderCode
#include <list>
typedef std::list<PyObject*> callAfterCbList;

class CallAfterCallback: public wxObject
{
public:
    CallAfterCallback() {}
    ~CallAfterCallback() {}

    void EventThunker(wxEvent& event);
};

static wxEventType g_callAfterId = 0;
void initializeCallAfter();
%End

%ModuleCode

/* the global CallAfter callable object list */
static callAfterCbList g_callAfterCbs;

/* Connects a special event ID to the app through which CallAfter
   calls get routed. */
void initializeCallAfter()
{
    // static wxEventType g_callAfterId = 0;
    static CallAfterCallback g_callafterEvent;

    if (!g_callAfterId) {
        g_callAfterId = wxNewEventType();
        wxTheApp->Connect(-1, -1, g_callAfterId,
                          (wxObjectEventFunction)&CallAfterCallback::EventThunker,
                          &g_callafterEvent, NULL);
    }
}

/* All wx.CallAfter calls are routed through here. */
void CallAfterCallback::EventThunker(wxEvent& event) {
    SIP_BLOCK_THREADS

    callAfterCbList::iterator iter;
    for(iter = g_callAfterCbs.begin(); iter != g_callAfterCbs.end(); iter++)
    {
        PyObject* func = *iter;

        PyObject* result = PyObject_CallObject(func, NULL);
        if (result)
        {
            Py_DECREF(result);

            if (PyErr_Occurred())
                PyErr_Print();
        } else
            PyErr_Print();

        Py_DECREF(func);
    }

    g_callAfterCbs.clear();


    SIP_UNBLOCK_THREADS
}
%End

%PostInitialisationCode

%End


// may be called from any thread
void CallAfter(SIP_PYCALLABLE);
%MethodCode
    if (!wxTheApp)
    {
        SIP_BLOCK_THREADS
        PyErr_SetString(PyExc_AssertionError, "No wx.App created yet");
        SIP_UNBLOCK_THREADS
        sipIsErr = 1;
    }
    else
    {
        /* append the callable to the end of our list */
        SIP_BLOCK_THREADS
        Py_INCREF(a0);
        g_callAfterCbs.push_back(a0);
        SIP_UNBLOCK_THREADS

        wxCommandEvent e(g_callAfterId, -1);
        wxTheApp->AddPendingEvent(e);
    }
%End

int wxNewEventType();

enum {
wxEVT_NULL,
wxEVT_FIRST,
wxEVT_USER_FIRST,

wxEVT_COMMAND_BUTTON_CLICKED,
wxEVT_COMMAND_CHECKBOX_CLICKED,
wxEVT_COMMAND_CHOICE_SELECTED,
wxEVT_COMMAND_LISTBOX_SELECTED,
wxEVT_COMMAND_LISTBOX_DOUBLECLICKED,
wxEVT_COMMAND_CHECKLISTBOX_TOGGLED,

wxEVT_COMMAND_MENU_SELECTED,
wxEVT_COMMAND_TOOL_CLICKED,
wxEVT_COMMAND_SLIDER_UPDATED,
wxEVT_COMMAND_RADIOBOX_SELECTED,
wxEVT_COMMAND_RADIOBUTTON_SELECTED,

wxEVT_COMMAND_SCROLLBAR_UPDATED,
wxEVT_COMMAND_VLBOX_SELECTED,
wxEVT_COMMAND_COMBOBOX_SELECTED,
wxEVT_COMMAND_TOOL_RCLICKED,
wxEVT_COMMAND_TOOL_ENTER,

wxEVT_LEFT_DOWN,
wxEVT_LEFT_UP,
wxEVT_MIDDLE_DOWN,
wxEVT_MIDDLE_UP,
wxEVT_RIGHT_DOWN,
wxEVT_RIGHT_UP,
wxEVT_MOTION,
wxEVT_ENTER_WINDOW,
wxEVT_LEAVE_WINDOW,
wxEVT_LEFT_DCLICK,
wxEVT_MIDDLE_DCLICK,
wxEVT_RIGHT_DCLICK,
wxEVT_SET_FOCUS,
wxEVT_KILL_FOCUS,
wxEVT_CHILD_FOCUS,
wxEVT_MOUSEWHEEL,

wxEVT_NC_LEFT_DOWN,
wxEVT_NC_LEFT_UP,
wxEVT_NC_MIDDLE_DOWN,
wxEVT_NC_MIDDLE_UP,
wxEVT_NC_RIGHT_DOWN,
wxEVT_NC_RIGHT_UP,
wxEVT_NC_MOTION,
wxEVT_NC_ENTER_WINDOW,
wxEVT_NC_LEAVE_WINDOW,
wxEVT_NC_LEFT_DCLICK,
wxEVT_NC_MIDDLE_DCLICK,
wxEVT_NC_RIGHT_DCLICK,

wxEVT_CHAR,
wxEVT_CHAR_HOOK,
wxEVT_NAVIGATION_KEY,
wxEVT_KEY_DOWN,
wxEVT_KEY_UP,

wxEVT_SET_CURSOR,

wxEVT_SCROLL_TOP,
wxEVT_SCROLL_BOTTOM,
wxEVT_SCROLL_LINEUP,
wxEVT_SCROLL_LINEDOWN,
wxEVT_SCROLL_PAGEUP,
wxEVT_SCROLL_PAGEDOWN,
wxEVT_SCROLL_THUMBTRACK,
wxEVT_SCROLL_THUMBRELEASE,
wxEVT_SCROLL_CHANGED,

wxEVT_SCROLLWIN_TOP,
wxEVT_SCROLLWIN_BOTTOM,
wxEVT_SCROLLWIN_LINEUP,
wxEVT_SCROLLWIN_LINEDOWN,
wxEVT_SCROLLWIN_PAGEUP,
wxEVT_SCROLLWIN_PAGEDOWN,
wxEVT_SCROLLWIN_THUMBTRACK,
wxEVT_SCROLLWIN_THUMBRELEASE,

wxEVT_SIZE,
wxEVT_MOVE,
wxEVT_CLOSE_WINDOW,
wxEVT_END_SESSION,
wxEVT_QUERY_END_SESSION,
wxEVT_ACTIVATE_APP,
wxEVT_ACTIVATE,
wxEVT_CREATE,
wxEVT_DESTROY,
wxEVT_SHOW,
wxEVT_ICONIZE,
wxEVT_MAXIMIZE,
wxEVT_MOUSE_CAPTURE_CHANGED,
wxEVT_MOUSE_CAPTURE_LOST,
wxEVT_PAINT,
wxEVT_ERASE_BACKGROUND,
wxEVT_NC_PAINT,
wxEVT_PAINT_ICON,
wxEVT_MENU_OPEN,
wxEVT_MENU_CLOSE,
wxEVT_MENU_HIGHLIGHT,

wxEVT_CONTEXT_MENU,
wxEVT_SYS_COLOUR_CHANGED,
wxEVT_DISPLAY_CHANGED,
wxEVT_SETTING_CHANGED,
wxEVT_QUERY_NEW_PALETTE,
wxEVT_PALETTE_CHANGED,
wxEVT_DROP_FILES,
wxEVT_DRAW_ITEM,
wxEVT_MEASURE_ITEM,
wxEVT_COMPARE_ITEM,
wxEVT_INIT_DIALOG,
wxEVT_IDLE,
wxEVT_UPDATE_UI,
wxEVT_SIZING,
wxEVT_MOVING,
wxEVT_HIBERNATE,

wxEVT_COMMAND_TEXT_COPY,
wxEVT_COMMAND_TEXT_CUT,
wxEVT_COMMAND_TEXT_PASTE,

wxEVT_COMMAND_LEFT_CLICK,
wxEVT_COMMAND_LEFT_DCLICK,
wxEVT_COMMAND_RIGHT_CLICK,
wxEVT_COMMAND_RIGHT_DCLICK,
wxEVT_COMMAND_SET_FOCUS,
wxEVT_COMMAND_KILL_FOCUS,
wxEVT_COMMAND_ENTER,
};



class wxEvent : wxObject  {
public:

%ConvertToSubClassCode
    // QEvent sub-classes provide a unique type ID.
    wxClassInfo* c = sipCpp -> GetClassInfo();

    /* TODO: automate this :( */
    if(0) ;
    #define C(clz) else if (c == CLASSINFO(clz)) sipClass = sipClass_ ## clz;

        C(wxKeyEvent)
        C(wxMouseEvent)
        C(wxTimerEvent)
        C(wxShowEvent)
        C(wxMenuEvent)
        C(wxShowEvent)
        C(wxMaximizeEvent)
        C(wxIconizeEvent)
        C(wxHyperlinkEvent)
        C(wxInitDialogEvent)
        C(wxNotifyEvent)
        C(wxListEvent)

    else
        sipClass = NULL;
%End

    wxEventType GetEventType() const;
    wxObject* GetEventObject() const;
    void SetEventObject(wxObject* obj);

    long GetTimestamp() const;
    void SetTimestamp(long ts = 0);

    int GetId() const;
    void SetId(int Id);

    bool IsCommandEvent() const;
    void Skip(bool skip = true);
    bool GetSkipped() const;

    ~wxEvent();

private:
    wxEvent();
};

class wxSysColourChangedEvent: wxEvent  {
public:
    wxSysColourChangedEvent();
};

class wxInitDialogEvent: wxEvent  {
public:
    wxInitDialogEvent();
};


class wxScrollWinEvent : wxEvent
{
public:
    wxScrollWinEvent(wxEventType commandType = wxEVT_NULL,
                     int pos = 0, int orient = 0);

    int GetOrientation() const;
    int GetPosition() const;

    void SetOrientation(int orient);
    void SetPosition(int pos);
};



class wxMouseEvent : wxEvent
{
public:
    wxMouseEvent(wxEventType mouseType = wxEVT_NULL);
    bool IsButton() const;
    bool ButtonDown(int but = wxMOUSE_BTN_ANY) const;
    bool ButtonDClick(int but = wxMOUSE_BTN_ANY) const;
    bool ButtonUp(int but = wxMOUSE_BTN_ANY) const;
    bool Button(int button) const;
    bool ButtonIsDown(int but) const;

    int GetButton() const;
    bool ControlDown() const;
    bool MetaDown() const;
    bool AltDown() const;
    bool ShiftDown() const;
    bool CmdDown() const;

    bool LeftDown() const;
    bool MiddleDown() const;
    bool RightDown() const;
    bool LeftUp() const;
    bool MiddleUp() const;
    bool RightUp() const;
    bool LeftDClick() const;
    bool MiddleDClick() const;
    bool RightDClick() const;
    bool LeftIsDown();
    bool MiddleIsDown();
    bool RightIsDown();
    bool Dragging() const;
    bool Moving() const;
    bool Entering() const;
    bool Leaving() const;

    wxPoint GetPosition();
    wxPoint GetLogicalPosition(const wxDC& dc) const;

    wxCoord GetX() const;
    wxCoord GetY() const;

    int GetWheelRotation() const;
    int GetWheelDelta() const;
    int GetLinesPerAction() const;
    bool IsPageScroll() const;
};


class wxKeyEvent: wxEvent {
public:
    wxKeyEvent(wxEventType eventType = wxEVT_NULL);
    int GetModifiers() const;
    bool ControlDown() const;
    bool MetaDown() const;
    bool AltDown() const;
    bool ShiftDown() const;
    bool CmdDown() const;
    bool HasModifiers() const;
    int  GetKeyCode() const;
    int  GetUnicodeKey() const;
    wxUint32 GetRawKeyCode() const;
    wxUint32 GetRawKeyFlags() const;
    wxPoint GetPosition();
    wxCoord GetX() const;
    wxCoord GetY() const;
};

class wxCommandEvent : wxEvent {
public:
    wxCommandEvent(wxEventType commandType = wxEVT_NULL, int winid = 0);
    int GetSelection() const;
    wxString GetString() const;
    bool IsChecked() const;
    bool IsSelection() const;
    long GetExtraLong() const;
    void SetInt(int i);
    int GetInt() const;
};

class wxNotifyEvent : wxCommandEvent {
public:
    wxNotifyEvent(wxEventType commandType = wxEVT_NULL, int winid = 0);
    void Veto();
    void Allow();
    void IsAllowed();
};

class wxActivateEvent: wxEvent {
public:
    wxActivateEvent(wxEventType eventType = 0, bool active = true, int id = 0);
    bool GetActive() const;
};

class wxContextMenuEvent : wxCommandEvent
{
public:
    wxContextMenuEvent(wxEventType type = wxEVT_NULL,
                       wxWindowID winid = 0,
                       const wxPoint& pt = wxDefaultPosition);

    //const wxPoint& GetPosition() const;
    void SetPosition(const wxPoint& pos);
};

class wxMenuEvent : wxEvent
{
public:
    wxMenuEvent(wxEventType type = wxEVT_NULL, int winid = 0, wxMenu* menu = NULL);
    int GetMenuId() const;
    bool IsPopup() const;
    wxMenu* GetMenu() const;
};

class wxCloseEvent : wxEvent
{
public:
    wxCloseEvent(wxEventType type = wxEVT_NULL, int winid = 0);
    void SetLoggingOff(bool logOff);
    bool GetLoggingOff() const;
    void Veto(bool veto = true);
    bool GetVeto() const;
    void SetCanVeto(bool canVeto);
    bool CanVeto() const;
};

class wxShowEvent : wxEvent
{
public:
    wxShowEvent(int winid = 0, bool show = false);

    void SetShow(bool show);
    bool GetShow() const;
};

class wxIconizeEvent: wxEvent
{
public:
    wxIconizeEvent(int id = 0, bool iconized = true);
    bool Iconized();
};

class wxMaximizeEvent: wxEvent
{
public:
    wxMaximizeEvent(int id = 0);
};

class wxDropFilesEvent: wxEvent
{
public:
    wxPoint GetPosition();
    int GetNumberOfFiles();
};

enum wxUpdateUIMode
{
    wxUPDATE_UI_PROCESS_ALL,
    wxUPDATE_UI_PROCESS_SPECIFIED
};

class wxUpdateUIEvent : wxCommandEvent
{
public:
    wxUpdateUIEvent(wxWindowID commandId = 0);
    bool GetChecked() const;
    bool GetEnabled() const;
    bool GetShown() const;
    wxString GetText() const;
    bool GetSetText() const;
    bool GetSetChecked() const;
    bool GetSetEnabled() const;
    bool GetSetShown() const;
    void Check(bool check);
    void Enable(bool enable);
    void Show(bool show);
    void SetText(const wxString& text);
    static void SetUpdateInterval(long updateInterval);
    static long GetUpdateInterval();
    static bool CanUpdate(wxWindow *win);
    static void ResetUpdateTime();
    static void SetMode(wxUpdateUIMode mode);
    static wxUpdateUIMode GetMode();
};
