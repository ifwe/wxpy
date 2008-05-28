%ModuleHeaderCode
#include <wx/app.h>
%End

int EntryStart();
%MethodCode
    int argc = 0;
    char** argv = 0;
    wxApp* app = wxTheApp;

    /* Ensure the wxApp was created already. */
    if (app == NULL)
    {
        PyErr_SetString(PyExc_AssertionError, "wxEntryStart called without a wxApp created yet");
        sipIsErr = 1;
    }

    /* Call wxEntryStart for wx initialization */
    sipRes = wxEntryStart(argc, argv);

    /* Connect the CallAfter mechanism. */
    initializeCallAfter();
%End


%ModuleHeaderCode

class wxPyApp : public wxApp
{
public:
    wxPyApp();
    ~wxPyApp();

    void OnAssertFailure(const wxChar *file, int line, const wxChar *func, const wxChar *cond, const wxChar *msg);
};

%End // ModuleHeaderCode

%ModuleCode

wxPyApp::wxPyApp() {}
wxPyApp::~wxPyApp() {}

void wxPyApp::OnAssertFailure(const wxChar *file, int line, const wxChar *szFunc, const wxChar *cond, const wxChar *szMsg)
{
    SIP_BLOCK_THREADS
    PyObject* traceback = PyImport_ImportModule("traceback");
    if (traceback)
    {
        PyObject* dict = PyModule_GetDict(traceback);
        if (dict)
        {
            PyObject* print_stack = PyDict_GetItemString(dict, "print_stack");
            if (print_stack)
                Py_DECREF(PyObject_CallFunction(print_stack, NULL));
        }
        Py_DECREF(traceback);
    }
    SIP_UNBLOCK_THREADS

    wxString msg;
    msg.reserve(2048);

    // make life easier for people using VC++ IDE by using this format: like
    // this, clicking on the message will take us immediately to the place of
    // the failed assert
    msg.Printf(wxT("%s(%d): assert \"%s\" failed"), file, line, cond);

    // add the function name, if any
    if ( szFunc && *szFunc )
        msg << _T(" in ") << szFunc << _T("()");

    // and the message itself
    if ( szMsg )
        msg << _T(": ") << szMsg;
    else // no message given
        msg << _T('.');

#if wxUSE_STACKTRACE
    msg << "\n" << GetAssertStackTrace();
#endif


    fprintf(stderr, "%s", msg.ToAscii());
}

%End // ModuleCode

class wxApp : wxEvtHandler
{
public:
    wxApp();
    ~wxApp();
};

class wxPyApp : wxApp
{
public:
    wxPyApp() /Transfer/;
    ~wxPyApp();
    virtual bool OnInit();
    virtual bool OnInitGui();
    virtual int MainLoop() /ReleaseGIL/;

    void ReleaseGIL();
%MethodCode
    Py_BEGIN_ALLOW_THREADS
    Py_END_ALLOW_THREADS
%End

    wxString GetAppName() const;
    void SetAppName(const wxString& name);

    wxString GetClassName() const;
    void SetClassName(const wxString& name);

    const wxString& GetVendorName() const;
    void SetVendorName(const wxString& name);

//  wxAppTraits*, GetTraits(),
    bool Yield(bool onlyIfNeeded = false) /ReleaseGIL/;
    void WakeUpIdle() /ReleaseGIL/;
    static bool IsMainLoopRunning() const /ReleaseGIL/;


    void Exit();
    void ExitMainLoop();

    bool Pending() /ReleaseGIL/;
    bool ProcessIdle() /ReleaseGIL/;
    bool IsActive() const /ReleaseGIL/;

    void SetTopWindow(wxWindow *win);
    wxWindow* GetTopWindow() const;

    void SetExitOnFrameDelete(bool flag);
    bool GetExitOnFrameDelete() const;

    void SetUseBestVisual( bool flag, bool forceTrueColour = false  );
    bool GetUseBestVisual() const;

    void SetPrintMode(int mode);
    int GetPrintMode() const;

    static void SetInstance(wxApp* app);
    wxLayoutDirection GetLayoutDirection() const;
/*
%If (WXMAC)
    virtual void         MacOpenFile(const wxString &fileName) ;
    virtual void         MacPrintFile(const wxString &fileName) ;
    virtual void         MacNewFile() ;
    virtual void         MacReopenApp() ;
    void MacHideApp();
%End
*/
/*

    static bool GetMacSupportPCMenuShortcuts();  // TODO, deprecate this
    static long GetMacAboutMenuItemId();
    static long GetMacPreferencesMenuItemId();
    static long GetMacExitMenuItemId();
    static wxString GetMacHelpMenuTitleName();

    static void SetMacSupportPCMenuShortcuts(bool val);  // TODO, deprecate this
    static void SetMacAboutMenuItemId(long val);
    static void SetMacPreferencesMenuItemId(long val);
    static void SetMacExitMenuItemId(long val);
    static void SetMacHelpMenuTitleName(const wxString& val);
*/
};


wxApp* GetApp();
%MethodCode
    sipRes = wxTheApp;
%End
