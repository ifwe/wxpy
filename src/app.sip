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

    if (sip_module == NULL)
        return NULL;

    /* Get the module's dictionary. */
    sip_module_dict = PyModule_GetDict(sip_module);

    /* Get the "_C_API" attribute. */
    c_api = PyDict_GetItemString(sip_module_dict, "_C_API");

    if (c_api == NULL)
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
    get_sip_api()->api_start_thread();
%End

void SipEndThread();
%MethodCode
    get_sip_api()->api_end_thread();
%End

%ModuleHeaderCode

class wxPyApp : public wxApp
{
public:
    wxPyApp();
    ~wxPyApp();

    virtual void OnAssertFailure(const wxChar *file, int line, const wxChar *func, const wxChar *cond, const wxChar *msg);
    PyObject* callAfterCbs;
    wxString crash_cmd;
};

%End // TypeHeaderCode

%ModuleCode

#ifdef __WXMSW__
#ifndef WXPY_PREC
#include <wx/msw/crashrpt.h>
#include <wx/msw/seh.h>
#endif

wxPyApp::wxPyApp()
{
    SIP_BLOCK_THREADS
    callAfterCbs = PyList_New(0);
    SIP_UNBLOCK_THREADS
}
wxPyApp::~wxPyApp()
{
    SIP_BLOCK_THREADS
    Py_DECREF(callAfterCbs);
    callAfterCbs = NULL;
    SIP_UNBLOCK_THREADS
}

static void traceback_print_stack()
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
}

extern EXCEPTION_POINTERS *wxGlobalSEInformation = NULL;

#include <wx/msw/seh.h>

static void call_crashreport_process(const wxString& cmd)
{
#ifdef __WXMSW__
    STARTUPINFO si = { sizeof(STARTUPINFO) };
    si.dwFlags = STARTF_USESHOWWINDOW;
    si.wShowWindow = SW_HIDE;

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
        if (!did_crash_report) {
            did_crash_report = true;

            wxCrashReport::Generate(wxCRASH_REPORT_DEFAULT, pExcPtrs);
            wxPyApp* app = (wxPyApp*)wxTheApp;

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

    // this will execute our handler and terminate the process
    return EXCEPTION_CONTINUE_SEARCH;//return EXCEPTION_EXECUTE_HANDLER;
}

#endif // __WXMSW__

void wxPyApp::OnAssertFailure(const wxChar *file, int line, const wxChar *szFunc, const wxChar *cond, const wxChar *szMsg)
{
    traceback_print_stack();

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

class wxApp : wxEvtHandler
{
    wxApp();
    ~wxApp();
};

class wxPyApp : wxApp
{

%TypeHeaderCode
#include <wx/msw/seh.h>
%End


// expose the CallAfter list to the cyclic garbage collector

%GCTraverseCode
    PyObject *obj = sipCpp->callAfterCbs;
    sipRes = obj ? sipVisit(obj, sipArg) : 0;
%End

%GCClearCode
    PyObject* obj = sipCpp->callAfterCbs;
    sipCpp->callAfterCbs = 0;
    Py_XDECREF(obj);
    sipRes = 0;
%End


public:
    wxPyApp();
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

    int MainLoop();
%MethodCode
    Py_BEGIN_ALLOW_THREADS
#if __WXMSW__
    wxSEH_TRY
    {
#endif
        sipRes = sipCpp->MainLoop();
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