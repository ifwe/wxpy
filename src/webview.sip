%Module wx._webview
%Import wx.sip

%ModuleHeaderCode
#include "wx/wxprec.h"
#include "wx/wx.h"
#include "wx/webview.h"
%End


class wxWebView : wxWindow
{
public:

%ConvertToSubClassCode
wxClassInfo* c = sipCpp->GetClassInfo();

if(0) {}
#define C(clz) else if (c == CLASSINFO(clz)) { sipClass = sipClass_ ## clz; }
    C(wxWebView)
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

    bool FindString(const wxString& string, bool forward, bool caseSensitive, bool wrapSelection, bool startInSelection);

    bool CanIncreaseTextSize() const;
    void IncreaseTextSize();
    bool CanDecreaseTextSize() const;
    void DecreaseTextSize();
    void ResetTextSize();
    void MakeEditable(bool enable);
    bool IsEditable() const;

    wxString GetPageTitle() const;
    void SetPageTitle(const wxString& title);

    void SetTransparent(bool transparent);
    bool IsTransparent() const;

    //wxBitmap GetBitmap() const;
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

class wxWebViewNewWindowEvent : wxCommandEvent
{
public:
    wxString GetURL() const;
    void SetURL(const wxString& url);
    wxString GetTargetName() const;
    void SetTargetName(const wxString& name);

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

