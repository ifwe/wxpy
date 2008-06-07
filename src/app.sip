%ModuleHeaderCode
#ifndef WXPY_PREC
#include <wx/app.h>
#endif
%End

%ModuleHeaderCode

class wxPyApp : public wxApp
{
public:
    wxPyApp();
    ~wxPyApp();

    virtual void OnAssertFailure(const wxChar *file, int line, const wxChar *func, const wxChar *cond, const wxChar *msg);
    PyObject* callAfterCbs;
    wxString executable;
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

unsigned long wxGlobalSEHandler(EXCEPTION_POINTERS *pExcPtrs)
{
    // store the pointer to exception info
    wxGlobalSEInformation = pExcPtrs;

    wxSEH_TRY
    {
        wxTheApp->OnFatalException();
    }
    wxSEH_IGNORE

    wxSEH_TRY
    {
        wxPyApp* app = (wxPyApp*)wxTheApp;
        wxString cmd(app->executable);

        wxCrashReport::Generate(wxCRASH_REPORT_DEFAULT, pExcPtrs);

        cmd << wxT(" --crashreport ") << wxCrashReport::GetFileName();
        wxExecute(cmd);
    }
    wxSEH_IGNORE

    wxGlobalSEInformation = NULL;

    // this will execute our handler and terminate the process
    return EXCEPTION_EXECUTE_HANDLER;
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


public:
    wxPyApp() /Transfer/;
    ~wxPyApp();
    virtual bool OnInit();
    virtual bool OnInitGui();

    void SetExecutable(const wxString& exc);
%MethodCode
    sipCpp->executable = *a0;
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

    void ReleaseGIL();
%MethodCode
    Py_BEGIN_ALLOW_THREADS
    Py_END_ALLOW_THREADS
%End

    int Crash();
%MethodCode
    int a = 1;
    int b = 1;
    b--;
    int c = a/b;
    sipRes = c;
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
