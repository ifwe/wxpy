%Module wx._webview
%Import wx.sip

%ModuleHeaderCode
#include "wx/wxprec.h"
#include "wx/wx.h"
#include "wx/webview.h"
%End

class wxWebViewCachePolicy
{
public:
    wxWebViewCachePolicy(unsigned minDead = 0, 
                         unsigned maxDead = 8388608,
                         unsigned totalCapacity = 8388608);
    ~wxWebViewCachePolicy();

    unsigned GetCapacity() const;
    void SetCapacity(int capacity);

    unsigned GetMinDeadCapacity() const;
    void SetMinDeadCapacity(unsigned minDeadCapacity);

    unsigned GetMaxDeadCapacity() const;
    void SetMaxDeadCapacity(unsigned maxDeadCapacity);
};

enum wxProxyType {
    HTTP,
    Socks4,
    Socks4A,
    Socks5,
    Socks5Hostname
};

enum wxEditableLinkBehavior {
    wxEditableLinkDefaultBehavior,
    wxEditableLinkAlwaysLive,
    wxEditableLinkOnlyLiveWithShiftKey,
    wxEditableLinkLiveWhenNotFocused,
    wxEditableLinkNeverLive
};

class wxWebSettings {
public:
    ~wxWebSettings();

    void SetDefaultFixedFontSize(int size);
    int GetDefaultFixedFontSize() const;
    
    void SetDefaultFontSize(int size);
    int GetDefaultFontSize() const;
    
    void SetMinimumFontSize(int size);
    int GetMinimumFontSize() const;
    
    void SetLoadsImagesAutomatically(bool loadAutomatically);
    bool LoadsImagesAutomatically() const;
    
    void SetJavaScriptEnabled(bool enabled);
    bool IsJavaScriptEnabled() const;
    
    void SetLocalStoragePath(const wxString& path);
    wxString GetLocalStoragePath() const;
    
    void SetEditableLinkBehavior(wxEditableLinkBehavior behavior);
    wxEditableLinkBehavior GetEditableLinkBehavior() const;
    
    void SetPluginsEnabled(bool enabled);
    bool ArePluginsEnabled() const;

    void SetAllowUniversalAccessFromFileURLs(bool allow);
    bool GetAllowUniversalAccessFromFileURLs() const;
};

class wxWebView : wxWindow
{
public:

%ConvertToSubClassCode
wxClassInfo* c = sipCpp->GetClassInfo();

if(0) {}
#define C(clz) else if (c == CLASSINFO(clz)) { sipClass = sipClass_ ## clz; }
    C(wxWebView)
else
    sipClass = NULL;
#undef C
%End

    wxWebView(wxWindow* parent /TransferThis/, int id = wxID_ANY,
              const wxPoint& point = wxDefaultPosition,
              const wxSize& size = wxDefaultSize,
              long style = 0,
              const wxString& name = wxWebViewNameStr);
    virtual ~wxWebView();

    void LoadURL(const wxString& url);
    bool GoBack();
    bool GoForward();
    void Stop();
    void Reload();

    bool CanGoBack();
    bool CanGoForward();

    bool CanCut();
    bool CanCopy();
    bool CanPaste();

    void Cut();
    void Copy();
    void Paste();

    //bool CanGetPageSource();
    wxString GetPageSource();
    void SetPageSource(const wxString& source, const wxString& baseUrl = wxEmptyString);

    wxString GetInnerText();
    wxString GetAsMarkup();
    wxString GetExternalRepresentation();

    wxString RunScript(const wxString& javascript);
%MethodCode
    if (!wxIsMainThread()) {
        PyErr_SetString(PyExc_AssertionError, "wx.WebView.RunScript called from subthread");
        sipIsErr = 1;
    } else
        sipRes = new wxString(sipCpp->RunScript(*a0));
%End

    //void PaintOnDC(wxMemoryDC& dc, bool useUpdateRegion);

    bool FindString(const wxString& string, bool forward, bool caseSensitive, bool wrapSelection, bool startInSelection);

    bool CanIncreaseTextSize() const;
    void IncreaseTextSize();
    bool CanDecreaseTextSize() const;
    void DecreaseTextSize();
    void ResetTextSize();
    void SetPageZoom(float percent);
    void MakeEditable(bool enable);
    bool IsEditable() const;

    wxString GetPageTitle() const;
    void SetPageTitle(const wxString& title);

    void SetTransparent(bool transparent);
    bool IsTransparent() const;

    wxWebViewDOMElementInfo HitTest(const wxPoint& pos) const;
    int GetParseMode() const;

    wxString GetDatabasePath(const wxString& name);
    static void SetDatabaseDirectory(const wxString& databaseDirectory);
    static wxString GetDatabaseDirectory();

    static void SetCachePolicy(const wxWebViewCachePolicy& cachePolicy);
    static wxWebViewCachePolicy GetCachePolicy();

    static wxString GetStatistics();

    virtual wxWebView* CreateWindow(bool menubar, bool statusbar, bool toolbar, bool locationbar);

    void GarbageCollect();

    wxBitmap GetCachedBitmap(const wxString& url);

    static void InvalidateFontCache();

    static void SetProxyInfo(const wxString& host = wxEmptyString,
                             unsigned long port = 0,
                             wxProxyType type = HTTP,
                             const wxString& username = wxEmptyString,
                             const wxString& password = wxEmptyString);

    bool GetMouseWheelZooms() const;
    void SetMouseWheelZooms(bool mouseWheelZooms);

    void SetMinimumFontSize(int minimumFontSize);
    int GetMinimumFontSize() const;

    wxWebSettings GetWebSettings();

    void ClearCookies();

    static void ReloadPlugins();

    void GrantUniversalAccess();

    static void AddOriginAccessWhitelistEntry(
            const wxString& sourceOrigin,
            const wxString& destinationProtocol,
            const wxString& destinationHost,
            bool allowDestinationSubdomains);
};

enum {
    wxWEBVIEW_LOAD_STARTED = 1,
    wxWEBVIEW_LOAD_NEGOTIATING = 2,
    wxWEBVIEW_LOAD_REDIRECTING = 4,
    wxWEBVIEW_LOAD_TRANSFERRING = 8,
    wxWEBVIEW_LOAD_STOPPED = 16,
    wxWEBVIEW_LOAD_FAILED = 32,
    wxWEBVIEW_LOAD_DL_COMPLETED = 64,
    wxWEBVIEW_LOAD_DOC_COMPLETED = 128,
    wxWEBVIEW_LOAD_ONLOAD_HANDLED = 256,
    wxWEBVIEW_LOAD_WINDOW_OBJECT_CLEARED = 512
};

enum {
    wxWEBVIEW_NAV_LINK_CLICKED = 1,
    wxWEBVIEW_NAV_BACK_NEXT = 2,
    wxWEBVIEW_NAV_FORM_SUBMITTED = 4,
    wxWEBVIEW_NAV_RELOAD = 8,
    wxWEBVIEW_NAV_FORM_RESUBMITTED = 16,
    wxWEBVIEW_NAV_OTHER = 32
};

class wxWebViewDOMElementInfo
{
public:
    wxWebViewDOMElementInfo();
    virtual ~wxWebViewDOMElementInfo();

    wxString GetTagName() const;
    void SetTagName(const wxString& name);

    bool IsSelected() const;
    void SetSelected(bool sel);

    wxString GetText() const;
    void SetText(const wxString& text);

    wxString GetImageSrc();
    void SetImageSrc(const wxString& src);

    wxString GetLink();
    void SetLink(const wxString& link);
};

class wxWebViewBeforeLoadEvent : wxCommandEvent
{

public:
    bool IsCancelled() const;
    void Cancel(bool cancel = true);
    wxString GetURL() const;
    void SetURL(const wxString& url);
    void SetNavigationType(int navType);
    int GetNavigationType() const;

    wxWebViewBeforeLoadEvent(wxWindow* win = NULL);
    virtual ~wxWebViewBeforeLoadEvent();
};

class wxWebViewLoadEvent : wxCommandEvent
{
public:
    int GetState() const;
    void SetState(const int state);
    wxString GetURL() const;
    void SetURL(const wxString& url);

    wxWebViewLoadEvent(wxWindow* win = NULL);
    virtual ~wxWebViewLoadEvent();
};

class wxWebKitWindowFeatures
{
public:
    wxWebKitWindowFeatures();

    bool menuBarVisible;
    bool statusBarVisible;
    bool toolBarVisible;
    bool locationBarVisible;
    bool scrollbarsVisible;
    bool resizable;
    bool fullscreen;
    bool dialog;
};

class wxWebViewNewWindowEvent : wxCommandEvent
{
public:

%ConvertToSubClassCode
wxClassInfo* c = sipCpp->GetClassInfo();

if(0) {}
#define C(clz) else if (c == CLASSINFO(clz)) { sipClass = sipClass_ ## clz; }
    C(wxWebViewNewWindowEvent)
    C(wxWebViewBeforeLoadEvent)
    C(wxWebViewLoadEvent)
    C(wxWebViewNewWindowEvent)
    C(wxWebViewRightClickEvent)
    C(wxWebViewConsoleMessageEvent)
    C(wxWebViewReceivedTitleEvent)
else
    sipClass = NULL;
#undef C
%End

    wxString GetURL() const;
    void SetURL(const wxString& url);
    wxString GetTargetName() const;
    void SetTargetName(const wxString& name);
    wxWebView* GetWebView();
    void SetWebView(wxWebView* webView);
    wxWebKitWindowFeatures GetWindowFeatures();
    void SetWindowFeatures(wxWebKitWindowFeatures features);

    wxWebViewNewWindowEvent(wxWindow* win = NULL);
    virtual ~wxWebViewNewWindowEvent();
};

class wxWebViewRightClickEvent : wxCommandEvent
{
public:
    wxWebViewRightClickEvent(wxWindow* win = NULL);
    virtual ~wxWebViewRightClickEvent();

    wxWebViewDOMElementInfo GetInfo() const;
    void SetInfo(wxWebViewDOMElementInfo info);

    wxPoint GetPosition() const;
    void SetPosition(wxPoint pos);
};

enum wxWebViewConsoleMessageLevel {
    TipMessageLevel,
    LogMessageLevel,
    WarningMessageLevel,
    ErrorMessageLevel
};

class wxWebViewConsoleMessageEvent : wxCommandEvent
{
public:
    wxWebViewConsoleMessageEvent(wxWindow* win = NULL);
    virtual ~wxWebViewConsoleMessageEvent();

    wxString GetMessage() const;
    void SetMessage(const wxString& message);

    unsigned int GetLineNumber() const;
    void SetLineNumber(unsigned int lineNumber);

    wxString GetSourceID() const;
    void SetSourceID(const wxString& sourceID);

    wxWebViewConsoleMessageLevel GetLevel() const;
    void SetLevel(wxWebViewConsoleMessageLevel level);
};

class wxWebViewReceivedTitleEvent : wxCommandEvent
{
public:
    wxString GetTitle() const;
    void SetTitle(const wxString& title);

    wxWebViewReceivedTitleEvent(wxWindow* win = static_cast<wxWindow*>(NULL));
    virtual ~wxWebViewReceivedTitleEvent();
};


enum
{
    wxEVT_WEBVIEW_BEFORE_LOAD,
    wxEVT_WEBVIEW_LOAD,
    wxEVT_WEBVIEW_NEW_WINDOW,
    wxEVT_WEBVIEW_RIGHT_CLICK,
    wxEVT_WEBVIEW_CONSOLE_MESSAGE,
    wxEVT_WEBVIEW_RECEIVED_TITLE
};


%PostInitialisationCode
typedef void (*add_event_type)(PyObject* module_dict, const char* name, ...);

add_event_type add_event = (add_event_type)sipImportSymbol("wxpy_add_event");

add_event(sipModuleDict, "EVT_WEBVIEW_BEFORE_LOAD", wxEVT_WEBVIEW_BEFORE_LOAD, 0);
add_event(sipModuleDict, "EVT_WEBVIEW_LOAD", wxEVT_WEBVIEW_LOAD, 0);
add_event(sipModuleDict, "EVT_WEBVIEW_NEW_WINDOW", wxEVT_WEBVIEW_NEW_WINDOW, 0);
add_event(sipModuleDict, "EVT_WEBVIEW_RIGHT_CLICK", wxEVT_WEBVIEW_RIGHT_CLICK, 0);
add_event(sipModuleDict, "EVT_WEBVIEW_CONSOLE_MESSAGE", wxEVT_WEBVIEW_CONSOLE_MESSAGE, 0);
add_event(sipModuleDict, "EVT_WEBVIEW_RECEIVED_TITLE", wxEVT_WEBVIEW_RECEIVED_TITLE, 0);
%End

