

%If (!wxUSE_HOTKEY)
%ModuleHeaderCode
#define wxEVT_HOTKEY -9999
%End
%End


%ModuleHeaderCode
#include <list>

class CallAfterCallback : public wxObject
{
public:
    CallAfterCallback() {}
    virtual ~CallAfterCallback() {}

    void EventThunker(wxEvent& event);
};

static wxEventType g_callAfterId = 0;
void initializeCallAfter();
%End

%ModuleCode

/* Connects a special event ID to the app through which CallAfter
   calls get routed. */
void initializeCallAfter()
{
    static CallAfterCallback* g_callAfterEvent = 0;

    if (!g_callAfterId) {
        g_callAfterEvent = new CallAfterCallback;
        g_callAfterId = wxNewEventType();
        wxASSERT_MSG(g_callAfterId, wxT("wxNewEventType returned 0"));
        wxASSERT_MSG(wxTheApp, wxT("initializeCallAfter(): wxTheApp is NULL"));
        wxTheApp->Connect(-1, -1, g_callAfterId,
                          (wxObjectEventFunction)&CallAfterCallback::EventThunker,
                          g_callAfterEvent, NULL);
    }
}

/* All wx.CallAfter calls are routed through here. */
void CallAfterCallback::EventThunker(wxEvent&)
{
    SIP_BLOCK_THREADS
    PyObject* cbs = ((wxPyApp*)wxTheApp)->callAfterCbs;

    const Py_ssize_t num_cbs = PyList_GET_SIZE(cbs);

    // Keep this reentrant
    PyObject* temp_list = PyList_New(num_cbs);
    if (!temp_list) {
        PyErr_SetString(PyExc_AssertionError, "Could not create temp_list");
        PyErr_Print();
    } else {
        if (-1 == PyList_SetSlice(temp_list, 0, num_cbs, cbs) ||
            -1 == PyList_SetSlice(cbs, 0, num_cbs, NULL)) {
            PyErr_SetString(PyExc_AssertionError, "Could not slice call after list");
            PyErr_Print();
        } else {
            for(Py_ssize_t i = 0; i < num_cbs; ++i) {
                PyObject* func = PyList_GET_ITEM(temp_list, i);
                PyObject* result = PyObject_CallObject(func, NULL);

                if (result)
                    Py_DECREF(result);
                else
                    PyErr_Print();
            }
        }
        Py_DECREF(temp_list);
    }

    SIP_UNBLOCK_THREADS
}
%End

// may be called from any thread
void CallAfter(SIP_PYCALLABLE);
%MethodCode
    /* append the callable to the end of our list */
    PyObject* cbs = ((wxPyApp*)wxTheApp)->callAfterCbs;

    if (-1 == PyList_Append(cbs, a0))
        sipIsErr = 1;
    else {
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



class wxEvent : wxObject
{
private:
    wxEvent();
    wxEvent(const wxEvent&);

%ConvertToSubClassCode
    wxClassInfo* c = sipCpp->GetClassInfo();

    /* TODO: automate this by grepping for wxXXXEvent and putting
     * entries here before build :( */
    if(0) ;
#define C(clz) else if (c == CLASSINFO(clz)) { sipClass = sipClass_ ## clz; }
        C(wxKeyEvent)
        C(wxCommandEvent)
        C(wxMouseEvent)
        C(wxTimerEvent)
        C(wxShowEvent)
        C(wxSizeEvent)
        C(wxMenuEvent)
        C(wxShowEvent)
        C(wxMoveEvent)
        C(wxActivateEvent)
        C(wxMaximizeEvent)
        C(wxIconizeEvent)
        C(wxHyperlinkEvent)
        C(wxInitDialogEvent)
        C(wxNotifyEvent)
        C(wxListEvent)
        C(wxDropFilesEvent)
        C(wxTreeEvent)
        C(wxUpdateUIEvent)
        C(wxContextMenuEvent)
        C(wxCloseEvent)
        C(wxWindowDestroyEvent)
        C(wxFocusEvent)
        C(wxClipboardTextEvent)
        C(wxNavigationKeyEvent)
        C(wxEvent)
    else
        sipClass = NULL;
#undef C
%End

public:
    wxEventType GetEventType() const;
    void SetEventType(wxEventType);

    wxObject* GetEventObject() const;
    void SetEventObject(wxObject* obj);

    long GetTimestamp() const;
    void SetTimestamp(long ts = 0);

    int GetId() const;
    void SetId(int Id);

    bool IsCommandEvent() const;
    void Skip(bool skip = true);
    bool GetSkipped() const;

    bool ShouldPropogate() const;
    int StopPropogation();
    void ResumePropogation(int propogationLevel);

    virtual ~wxEvent();
};

%ModuleHeaderCode
class wxPyEvent : public wxEvent
{
public:
    virtual wxEvent* Clone() const { return new wxPyEvent(*this); }
};
%End

class wxPyEvent : wxEvent
{
public:
    wxPyEvent();
    virtual ~wxPyEvent();
};


class wxSysColourChangedEvent : wxEvent
{
public:
    wxSysColourChangedEvent();
    virtual ~wxSysColourChangedEvent();
};

class wxInitDialogEvent : wxEvent
{
public:
    wxInitDialogEvent();
    virtual ~wxInitDialogEvent();
};


class wxScrollWinEvent : wxEvent
{
public:
    wxScrollWinEvent(wxEventType commandType = wxEVT_NULL,
                     int pos = 0, int orient = 0);
    virtual ~wxScrollWinEvent();

    int GetOrientation() const;
    int GetPosition() const;

    void SetOrientation(int orient);
    void SetPosition(int pos);
};

class wxMoveEvent : wxEvent
{
public:
    wxMoveEvent(const wxPoint& pt, int id = 0);
    virtual ~wxMoveEvent();

    wxPoint GetPosition() const;
};

class wxSizeEvent : wxEvent
{
public:
    wxSizeEvent(const wxSize& sz, int id = 0);
    virtual ~wxSizeEvent();

    wxSize GetSize() const;
};

class wxMouseEvent : wxEvent
{
public:
    wxMouseEvent(wxEventType mouseType = wxEVT_NULL);
    virtual ~wxMouseEvent();

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

    int m_x;
    int m_y;
};


class wxKeyEvent: wxEvent
{
public:
    wxKeyEvent(wxEventType eventType = wxEVT_NULL);
    virtual ~wxKeyEvent();

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

    long          m_keyCode;
    bool          m_controlDown;
    bool          m_shiftDown;
    bool          m_altDown;
    bool          m_metaDown;
    bool          m_scanCode;
    wxChar        m_uniChar;
    wxUint32      m_rawCode;
    wxUint32      m_rawFlags;
};

class wxCommandEvent : wxEvent
{
%TypeHeaderCode
#include <wx/clntdata.h>
    class PyClientData : public wxClientData
    {
    public:
        PyClientData(PyObject* object)
            : m_obj(object)
        {
            Py_XINCREF(m_obj);
        }

        virtual ~PyClientData()
        {
            SIP_BLOCK_THREADS
            Py_CLEAR(m_obj);
            SIP_UNBLOCK_THREADS
        }

        operator PyObject*() const { return m_obj; }
        PyObject* pyobject() const { return m_obj; }

    protected:
        PyObject* m_obj;

    private:
        PyClientData(const PyClientData&);
    };
%End
public:
    wxCommandEvent(wxEventType commandType = wxEVT_NULL, int winid = 0);
    virtual ~wxCommandEvent();

    int GetSelection() const;
    wxString GetString() const;
    void SetString(const wxString& string);
    bool IsChecked() const;
    bool IsSelection() const;
    long GetExtraLong() const;
    void SetInt(int i);
    int GetInt() const;

    void SetClientData(SIP_PYOBJECT);
%MethodCode
        sipCpp->SetClientObject(new PyClientData(a0));
%End

    SIP_PYOBJECT GetClientData();
%MethodCode
        PyClientData* data = dynamic_cast<PyClientData*>(sipCpp->GetClientObject());

        if (data)
            sipRes = data->pyobject();
        else
            sipRes = Py_None;

        Py_INCREF(sipRes);
%End
};

class wxNotifyEvent : wxCommandEvent
{
public:
    wxNotifyEvent(wxEventType commandType = wxEVT_NULL, int winid = 0);
    virtual ~wxNotifyEvent();

    void Veto();
    void Allow();
    void IsAllowed();
};

class wxActivateEvent: wxEvent
{
public:
    wxActivateEvent(wxEventType eventType = 0, bool active = true, int id = 0);
    virtual ~wxActivateEvent();

    bool GetActive() const;
};

class wxContextMenuEvent : wxCommandEvent
{
public:
    wxContextMenuEvent(wxEventType type = wxEVT_NULL,
                       wxWindowID winid = 0,
                       const wxPoint& pt = wxDefaultPosition);
    virtual ~wxContextMenuEvent();

    const wxPoint& GetPosition() const;
    void SetPosition(const wxPoint& pos);
};

class wxMenuEvent : wxEvent
{
public:
    wxMenuEvent(wxEventType type = wxEVT_NULL, int winid = 0, wxMenu* menu = NULL);
    virtual ~wxMenuEvent();
    int GetMenuId() const;
    bool IsPopup() const;
    wxMenu* GetMenu() const;
};

class wxCloseEvent : wxEvent
{
public:
    wxCloseEvent(wxEventType type = wxEVT_NULL, int winid = 0);
    virtual ~wxCloseEvent();
    void SetLoggingOff(bool logOff);
    bool GetLoggingOff() const;
    void Veto(bool veto = true);

    // GetVeto is disabled here because automatic property generation turns .Veto
    // into a variable.
    //
    // either a) make autoprops smart enough to ignore b/c of Veto
    // or b) make a /NoProperty/ annotation
    //
    // bool GetVeto() const;
    
    void SetCanVeto(bool canVeto);
    bool CanVeto() const;
};

class wxShowEvent : wxEvent
{
public:
    wxShowEvent(int winid = 0, bool show = false);
    virtual ~wxShowEvent();

    void SetShow(bool show);
    bool GetShow() const;

    int __nonzero__();
%MethodCode
    sipRes = (int)sipCpp->GetShow();
%End
};
class wxIconizeEvent: wxEvent

{
public:
    wxIconizeEvent(int id = 0, bool iconized = true);
    virtual ~wxIconizeEvent();

    bool Iconized();
};

class wxMaximizeEvent: wxEvent
{
public:
    wxMaximizeEvent(int id = 0);
    virtual ~wxMaximizeEvent();

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
    virtual ~wxUpdateUIEvent();

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

enum wxIdleMode
{
    wxIDLE_PROCESS_ALL,
    wxIDLE_PROCESS_SPECIFIED
};

class wxIdleEvent : wxEvent
{
public:
    wxIdleEvent();
    virtual ~wxIdleEvent();

    void RequestMore(bool needMore = true);
    bool MoreRequested() const;
    static void SetMode(wxIdleMode mode);
    static wxIdleMode GetMode();
    static bool CanSend(wxWindow* win);
};


class wxPaintEvent : wxEvent
{
public:
    wxPaintEvent(int Id = 0);
    virtual ~wxPaintEvent();

};


class wxNcPaintEvent : wxEvent
{
public:
    wxNcPaintEvent(int winid = 0);
    virtual ~wxNcPaintEvent();

};

class wxEraseEvent : wxEvent
{
public:
    wxEraseEvent(int Id = 0, wxDC *dc = NULL);
    virtual ~wxEraseEvent();

    wxDC * GetDC() const;
};

class wxWindowDestroyEvent : wxCommandEvent
{
    wxWindowDestroyEvent(wxWindow* win = NULL);
    virtual ~wxWindowDestroyEvent();
};

class wxDateEvent : wxCommandEvent
{
public:
    wxDateEvent(wxWindow *win, const wxDateTime& dt, wxEventType type);
    const wxDateTime& GetDate() const;
    void SetDate(const wxDateTime &date);
};

class wxFocusEvent : wxEvent
{
public:
    wxFocusEvent(int eventType = 0, int id = 0);
    virtual ~wxFocusEvent();

    wxWindow* GetWindow();
};

class wxNavigationKeyEvent : wxEvent
{
    wxNavigationKeyEvent();

    bool GetDirection() const;
    void SetDirection();

    bool IsWindowChange() const;
    void SetWindowChange(bool);

    bool IsFromTab() const;
    void SetFromTab(bool);

    wxWindow* GetCurrentFocus() const;
    void SetCurrentFocus(wxWindow*);
};

class wxClipboardTextEvent : wxCommandEvent
{
private:
    wxClipboardTextEvent();
}; 

