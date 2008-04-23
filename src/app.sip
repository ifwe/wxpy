%ModuleHeaderCode
#include <wx/app.h>
%End

%PreInitialisationCode

/* disables Mac events (they are crashing atm)*/
wxApp::sm_isEmbedded = true;

%End

int EntryStart();
%MethodCode
    int argc = 0;
    char** argv = NULL;
    sipRes = wxEntryStart(argc, argv);
%End


class wxApp : wxEvtHandler
{
public:
    wxApp() /Transfer/;
    ~wxApp();
    
    virtual bool OnInit();
    bool OnInitGui();
    
    void OnUnhandledException();
%MethodCode
#ifdef __WXDEBUG__
    // we're called from an exception handler so we can re-throw the exception
    // to recover its type
    wxString what;
    try
    {
        throw;
    }
#if wxUSE_STL
    catch ( std::exception& e )
    {
        what.Printf("std::exception of type \"%s\", what() = \"%s\"",
                    typeid(e).name(), e.what());
    }
#endif // wxUSE_STL
    catch ( ... )
    {
        what = "unknown exception";
    }

    wxMessageOutputBest().Printf(
        "*** Caught unhandled %s; terminating\n", what
    );
#endif // __WXDEBUG__
%End

    wxString GetAppName() const;
    void SetAppName(const wxString& name);
    wxString GetClassName() const;
    void SetClassName(const wxString& name);
    const wxString& GetVendorName() const;
    void SetVendorName(const wxString& name);
//  wxAppTraits*, GetTraits(),
    void ProcessPendingEvents();
    bool Yield(bool onlyIfNeeded = false);
    void WakeUpIdle();
    static bool IsMainLoopRunning() const;
    int MainLoop();
    void Exit();
    wxLayoutDirection GetLayoutDirection() const;
    void ExitMainLoop();
    bool Pending();
    bool Dispatch();
    bool ProcessIdle();
//  virtual bool SendIdleEvents(wxWindow* win, wxIdleEvent& event);
    virtual bool IsActive() const;
    void SetTopWindow(wxWindow *win);
    virtual wxWindow* GetTopWindow() const;
    void SetExitOnFrameDelete(bool flag);
    bool GetExitOnFrameDelete() const;
    void SetUseBestVisual( bool flag, bool forceTrueColour = false  );
    bool GetUseBestVisual() const;
    virtual void SetPrintMode(int mode);
    int GetPrintMode() const;
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
