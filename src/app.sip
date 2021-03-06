%ModuleHeaderCode
#include <wx/app.h>
#include <sip.h>
#include "PythonUtils.h"

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
    virtual ~wxPyApp();

    virtual void OnAssertFailure(const wxChar *file, int line, const wxChar *func, const wxChar *cond, const wxChar *msg);

    int  GetAssertMode() { return m_assertMode; }
    void SetAssertMode(int mode) { m_assertMode = mode; }

    unsigned long long GetMainLoopCount() const { return m_mainLoopCount; }

    virtual bool ProcessIdle()
    {
        // maintain a counter approximating main loop iterations
        ++m_mainLoopCount;
        return wxApp::ProcessIdle();
    }

    PyObject* callAfterCbs;
    PyObject* pendingDelete;

    wxString crash_cmd;
    int crash_report_flags;
protected:
    int m_assertMode;
    unsigned long long m_mainLoopCount;
};

%End // TypeHeaderCode

%ModuleCode

#ifdef __WXMSW__
#include <wx/msw/crashrpt.h>
#include <wx/msw/seh.h>

wxPyApp::wxPyApp()
    : crash_report_flags(wxCRASH_REPORT_DEFAULT)
    , m_assertMode(wxPYAPP_ASSERT_EXCEPTION)
    , m_mainLoopCount(0)
{
    callAfterCbs = PyList_New(0);
    pendingDelete = PySet_New(NULL);
}

wxPyApp::~wxPyApp()
{
    SIP_BLOCK_THREADS
    Py_CLEAR(callAfterCbs);
    Py_CLEAR(pendingDelete);
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
static wxString seh_cmd;


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
        wxLogError(wxT("Digsby crashed"));
        print_python_stack();
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
                seh_cmd.Printf(app->crash_cmd, wxCrashReport::GetFileName());
            else
                seh_cmd = app->crash_cmd;

            if (!IsDebuggerPresent())
                // don't spawn the crash reporter process if we're already under a debugger.
                call_crashreport_process(seh_cmd);
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
    virtual ~wxApp();
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

public:
    wxPyApp() /Transfer/;
    virtual ~wxPyApp();
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

    int  GetAssertMode();
    void SetAssertMode(int mode);

    int crash_report_flags;

/*
    Surrounds wxApp::MainLoop with wxSEH_TRY and wxSEH_HANDLE.
*/
    int MainLoop();
%MethodCode

    wxTimer* timer = new PendingDeleteTimer();
    timer->Start(1000);

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
    void Dispatch() /ReleaseGIL/;
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

    void SetUseBestVisual(bool flag, bool forceTrueColour = false);
    bool GetUseBestVisual() const;

    void SetPrintMode(int mode);
    int GetPrintMode() const;

    unsigned long long GetMainLoopCount() const;

    static void SetInstance(wxApp* app);
    wxLayoutDirection GetLayoutDirection() const;

    SIP_PYLIST callAfterCbs;
    SIP_PYLIST pendingDelete;

    wxString GetCrashFile();
%MethodCode
    sipRes = new wxString(wxCrashReport::GetFileName());
%End

};

wxApp* GetApp();
%MethodCode
    sipRes = wxTheApp;
%End

/*
    Surrounds a Python callable with wxSEH_TRY and wxSEH_HANDLE.
*/
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

/*
   When the garbage collector cleans up cycles on subthreads, it may involve
   the dealloc functions for wx objects, whose destructors are not thread-
   safe.
  
   These functions schedule objects for deletion later on the main thread.
*/

%ModuleHeaderCode
void wxpy_add_pending_delete(sipClassTypeDef *type, void *sipCppV, int state);
void wxpy_remove_pending_delete(sipClassTypeDef *type, void *sipCppV, int state);

class PendingDeleteTimer : public wxTimer
{
public:
    PendingDeleteTimer();
    virtual ~PendingDeleteTimer();
    virtual void Notify();
};

%End

%ModuleCode

/**
 * wxObject subclasses do reference counting with copy on write semantics.
 * Unfortunately, the reference counting is not threadsafe.
 *
 * Since these bindings allow some wxObject subclasses to be owned by Python,
 * and destroyed by Python when their Python objects' reference count hits
 * zero, we need to watch out for the case when a cycle is broken by the
 * garbage collector on a thread other than the main thread.
 *
 * Normally this would result in the wxObject destructor running on a
 * subthread--which we don't want. So we make the generated code call this
 * method instead, which adds the object (via PyCObject_FromVoidPtr) to the set
 * at app->pendingDelete. Then periodically we call wxpy_flush_pending_delete
 * to empty the set and delete its members.
 */
static void wxpy_do_pending_delete(int add, sipClassTypeDef *type, void *sipCppV, int state)
{
    wxPyApp* app = (wxPyApp*)wxTheApp;

    PyObject* type_vp = PyCObject_FromVoidPtr(type, NULL);
    PyObject* cpp_vp = PyCObject_FromVoidPtr(sipCppV, NULL);
    PyObject* to_delete = Py_BuildValue("OOi", type_vp, cpp_vp, state);

    if (to_delete) {
        if (add)
            PySet_Add(app->pendingDelete, to_delete);
        else
            PySet_Discard(app->pendingDelete, to_delete);
        Py_DECREF(to_delete);
    }

    Py_DECREF(type_vp);
    Py_DECREF(cpp_vp);
}

void wxpy_add_pending_delete(sipClassTypeDef *type, void *sipCppV, int state)
{
    wxpy_do_pending_delete(1, type, sipCppV, state);
}

void wxpy_remove_pending_delete(sipClassTypeDef *type, void *sipCppV, int state)
{
    wxpy_do_pending_delete(0, type, sipCppV, state);
}

// call destructors on all objects pending deletion and clear the list
static int wxpy_flush_pending_delete()
{
    int count = 0;

    SIP_BLOCK_THREADS
    PyObject* pendingDelete = ((wxPyApp*)wxTheApp)->pendingDelete;

    while (PySet_GET_SIZE(pendingDelete)) {
        // TODO: elements are popped off the set in an arbitrary order. is this ok?
        PyObject* to_delete = PySet_Pop(pendingDelete);
        if (!to_delete)
            return count;

        // parse (sipTypeDef*, sipWrapper*, and int) out of the tuple
        PyObject* type_cobj = PyTuple_GET_ITEM(to_delete, 0);
        PyObject* cpp_cobj  = PyTuple_GET_ITEM(to_delete, 1);
        int state = PyInt_AsLong(PyTuple_GET_ITEM(to_delete, 2));

        // convert PyCObject void pointer objects to actual void*s
        sipClassTypeDef* type = (sipClassTypeDef*)PyCObject_AsVoidPtr(type_cobj);
        void* sipCppV = PyCObject_AsVoidPtr(cpp_cobj);

        // invoke the destructor
        type->ctd_release(sipCppV, state);
        ++count;

        Py_DECREF(to_delete);
    }
    SIP_UNBLOCK_THREADS

    return count;
}

PendingDeleteTimer::PendingDeleteTimer() {}
PendingDeleteTimer::~PendingDeleteTimer() {}

void PendingDeleteTimer::Notify()
{
    wxpy_flush_pending_delete();
}
%End

%PostInitialisationCode
// Export functions for other modules to use.
#define EXPORT_WXPY_SYMBOL(name, func) do { \
 int err = sipExportSymbol(name, (void *)&func); \
 if (err != 0) \
     fprintf(stderr, "error exporting '" #name "' symbol: %d\n", err); \
 } while(0)

EXPORT_WXPY_SYMBOL("wxpy_add_event", add_event);
EXPORT_WXPY_SYMBOL("wxpy_add_pending_delete", wxpy_add_pending_delete);
EXPORT_WXPY_SYMBOL("wxpy_remove_pending_delete", wxpy_remove_pending_delete);
%End

int flush_pending_delete();
%MethodCode
    sipRes = wxpy_flush_pending_delete();
%End
