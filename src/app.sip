%ModuleHeaderCode
#include <wx/app.h>
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
    virtual bool ProcessIdle();
//  virtual bool SendIdleEvents(wxWindow* win, wxIdleEvent& event);
    bool IsActive() const;
    void SetTopWindow(wxWindow *win);
    wxWindow* GetTopWindow() const;
    void SetExitOnFrameDelete(bool flag);
    bool GetExitOnFrameDelete() const;
    void SetUseBestVisual( bool flag, bool forceTrueColour = false  );
    bool GetUseBestVisual() const;
    void SetPrintMode(int mode);
    int GetPrintMode() const;

    static void SetInstance(wxApp* app);
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

