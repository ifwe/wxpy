%ModuleHeaderCode
#ifndef WXPY_PREC
#include <wx/app.h>
#endif

#include <sip.h>

static const sipAPIDef *get_sip_api();
%End

%ModuleCode
static const sipAPIDef *get_sip_api()
{
    PyObject *sip_module;
    PyObject *sip_module_dict;
    PyObject *c_api;

    /* Import the SIP module. */
    sip_module = PyImport_ImportModule("sip");

    if (!sip_module)
        return 0;

    /* Get the module's dictionary. */
    sip_module_dict = PyModule_GetDict(sip_module);

    /* Get the "_C_API" attribute. */
    c_api = PyDict_GetItemString(sip_module_dict, "_C_API");
    Py_DECREF(sip_module);

    if (!c_api)
        return NULL;

    /* Sanity check that it is the right type. */
    if (!PyCObject_Check(c_api))
        return NULL;

    /* Get the actual pointer from the object. */
    return (const sipAPIDef *)PyCObject_AsVoidPtr(c_api);
}

%End


//
// inform SIP of new threads
//
void SipNewThread();
%MethodCode
    const sipAPIDef* api = get_sip_api();
    if (api)
        api->api_start_thread();
    else
        fprintf(stderr, "SipNewThread: could not obtain SIP api\n");
%End

void SipEndThread();
%MethodCode
    const sipAPIDef* api = get_sip_api();
    if (api)
        api->api_end_thread();
    else
        fprintf(stderr, "SipNewThread: could not obtain SIP api\n");
%End

%ModuleHeaderCode

enum {
    wxPYAPP_ASSERT_SUPPRESS  = 1,
    wxPYAPP_ASSERT_EXCEPTION = 2,
    wxPYAPP_ASSERT_DIALOG    = 4,
    wxPYAPP_ASSERT_LOG       = 8
};

class wxPyApp : public wxApp
{
public:
    wxPyApp();
    ~wxPyApp();

    virtual void OnAssertFailure(const wxChar *file, int line, const wxChar *func, const wxChar *cond, const wxChar *msg);

    int  GetAssertMode() { return m_assertMode; }
    void SetAssertMode(int mode) { m_assertMode = mode; }

    PyObject* callAfterCbs;

    wxString crash_cmd;
    int crash_report_flags;
protected:
    int m_assertMode;
};

%End // TypeHeaderCode

%ModuleCode

#ifdef __WXMSW__
#include <wx/msw/crashrpt.h>
#include <wx/msw/seh.h>

wxPyApp::wxPyApp()
    : crash_report_flags(wxCRASH_REPORT_DEFAULT)
    , m_assertMode(wxPYAPP_ASSERT_EXCEPTION)
{
    callAfterCbs = PyList_New(0);
}
wxPyApp::~wxPyApp()
{
    SIP_BLOCK_THREADS
    fprintf(stderr, "~wxPyApp(), clearing callAfterCbs\n");
    Py_CLEAR(callAfterCbs);
    SIP_UNBLOCK_THREADS
}

// on an exception, the excp. info is stored in this global
extern EXCEPTION_POINTERS *wxGlobalSEInformation = NULL;

static void call_crashreport_process(const wxString& cmd)
{
#ifdef __WXMSW__
    STARTUPINFO si = { sizeof(STARTUPINFO) };
    PROCESS_INFORMATION pi;

    if (CreateProcessW(NULL, (LPWSTR)cmd.wc_str(), NULL, NULL, FALSE, 0, NULL, NULL, &si, &pi)) {
        CloseHandle(pi.hProcess);
        CloseHandle(pi.hThread);
    } else
        wxLogError(L"  error: Could not run \"%ws\"\n", cmd);
#else
#error call_crashreport_process is not implemented on this platform
#endif
}

static bool did_crash_report = false;

unsigned long wxGlobalSEHandler(EXCEPTION_POINTERS *pExcPtrs)
{
    // store the pointer to exception info
    wxGlobalSEInformation = pExcPtrs;
    wxString cmd;

    wxSEH_TRY
    {
        wxTheApp->OnFatalException();
    }
    wxSEH_IGNORE

    wxSEH_TRY
    {
        wxPyApp* app = (wxPyApp*)wxTheApp;
        if (!app->crash_cmd.IsEmpty() && !did_crash_report) {
            did_crash_report = true;

            wxCrashReport::Generate(app->crash_report_flags, pExcPtrs);

            // Turn a "%s" in the crash command string into the filename
            // of the dump file.
            if (app->crash_cmd.Find(wxT("%s")) != wxNOT_FOUND)
                cmd.Printf(app->crash_cmd, wxCrashReport::GetFileName());
            else
                cmd = app->crash_cmd;

            call_crashreport_process(cmd);
        }
    }
    wxSEH_IGNORE

    wxGlobalSEInformation = NULL;

    return EXCEPTION_CONTINUE_SEARCH;
}

#endif // __WXMSW__

void wxPyApp::OnAssertFailure(const wxChar *file, int line, const wxChar *szFunc, const wxChar *cond, const wxChar *szMsg)
{
    wxString msg;

    if (m_assertMode & wxPYAPP_ASSERT_SUPPRESS)
        return;

    msg.Alloc(2048);
    msg.Printf(wxT("C++ assertion \"%s\" failed at %s(%d)"), cond, file, line);

    // add the function name, if any
    if ( szFunc && *szFunc )
        msg << _T(" in ") << szFunc << _T("()");

    // and the message itself
    if ( szMsg )
        msg << _T(": ") << szMsg;
    else // no message given
        msg << _T('.');

    if (m_assertMode & wxPYAPP_ASSERT_EXCEPTION) {
        SIP_BLOCK_THREADS
        PyErr_SetString(PyExc_AssertionError, msg.ToAscii());
        SIP_UNBLOCK_THREADS
    }

    if (m_assertMode & wxPYAPP_ASSERT_LOG && !(m_assertMode & wxPYAPP_ASSERT_DIALOG))
        wxLogDebug(msg);
    else if (m_assertMode & wxPYAPP_ASSERT_DIALOG)
        wxApp::OnAssertFailure(file, line, szFunc, cond, szMsg);
}

%End // ModuleCode


int EntryStart();
%MethodCode
    int argc = 0;
    char** argv = 0;
    wxApp* app = wxTheApp;

    /* Ensure the wxApp was created already. */
    if (!app) {
        PyErr_SetString(PyExc_AssertionError, "wxEntryStart called without a wxApp created yet");
        sipIsErr = 1;
    }

    /* Call wxEntryStart for wx initialization */
    sipRes = wxEntryStart(argc, argv);

    /* Connect the CallAfter mechanism. */
    initializeCallAfter();
%End

class wxApp : wxEvtHandler
{
public:
    wxApp();
    ~wxApp();
};

enum {
    wxPYAPP_ASSERT_SUPPRESS,
    wxPYAPP_ASSERT_EXCEPTION,
    wxPYAPP_ASSERT_DIALOG,
    wxPYAPP_ASSERT_LOG
};

class wxPyApp : wxApp
{

%TypeHeaderCode
#include <wx/msw/seh.h>
%End


// expose the CallAfter list to the cyclic garbage collector

//%GCTraverseCode
//    PyObject *obj = sipCpp->callAfterCbs;
//    sipRes = obj ? sipVisit(obj, sipArg) : 0;
//%End
//
//%GCClearCode
//    Py_CLEAR(sipCpp->callAfterCbs);
//    sipRes = 0;
//%End


public:
    wxPyApp() /Transfer/;
    ~wxPyApp();
    virtual bool OnInit();
    virtual bool OnInitGui();

    void SetCrashCommand(const wxString& exc);
%MethodCode
    sipCpp->crash_cmd = *a0;
%End

    wxString GetCrashCommand() const;
%MethodCode
    sipRes = new wxString(sipCpp->crash_cmd);
%End

    int crash_report_flags;

    int MainLoop();
%MethodCode
    Py_BEGIN_ALLOW_THREADS
#if __WXMSW__
    wxSEH_TRY
    {
#endif
        sipRes = sipCpp->wxApp::MainLoop();
#if __WXMSW__
    }
    wxSEH_HANDLE(-1)
#endif
    Py_END_ALLOW_THREADS
%End

    virtual void OnFatalException();

    wxString GetAppName() const;
    void SetAppName(const wxString& name);

    wxString GetClassName() const;
    void SetClassName(const wxString& name);

    const wxString& GetVendorName() const;
    void SetVendorName(const wxString& name);

    bool Yield(bool onlyIfNeeded = false) /ReleaseGIL/;
    void WakeUpIdle() /ReleaseGIL/;
    static bool IsMainLoopRunning() const /ReleaseGIL/;

    void Exit();
    void ExitMainLoop();

    bool Pending();
    bool ProcessIdle() /ReleaseGIL/;
    bool IsActive();

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

    SIP_PYLIST callAfterCbs;
    wxString GetCrashFile();
%MethodCode
    sipRes = new wxString(wxCrashReport::GetFileName());
%End

};

wxApp* GetApp();
%MethodCode
    sipRes = wxTheApp;
%End

%If (WXMSW)
    SIP_PYOBJECT SEHGuard(SIP_PYCALLABLE cb);
%MethodCode
    wxSEH_TRY
    {
        SIP_BLOCK_THREADS
        sipRes = PyObject_CallFunction(a0, NULL);
        SIP_UNBLOCK_THREADS
    }
    wxSEH_HANDLE(-1)
%End
%End
