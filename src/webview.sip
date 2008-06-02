%Module _webview

%Import wx.sip

%ModuleHeaderCode
#include "wx/wxprec.h"
#ifndef WX_PRECOMP
    #include "wx/wx.h"
#endif
#include "wx/webview.h"
%End


class WebViewFrameData
{
    private:
    WebViewFrameData();
};

class wxWebView : wxWindow
{

public:
    wxWebView(wxWindow* parent /TransferThis/, int id = wxID_ANY,
              const wxPoint& point = wxDefaultPosition,
              const wxSize& size = wxDefaultSize,
              long style = 0,
              const wxString& name = wxWebViewNameStr,
              WebViewFrameData* data = NULL);

    ~wxWebView();

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

    bool CanIncreaseTextSize() const;
    void IncreaseTextSize();
    bool CanDecreaseTextSize() const;
    void DecreaseTextSize();
    void MakeEditable(bool enable);
    bool IsEditable() const;

    wxString GetPageTitle() const;
    void SetPageTitle(const wxString& title);

};

// ----------------------------------------------------------------------------
// Web Kit Events
// ----------------------------------------------------------------------------

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
    ~wxWebViewDOMElementInfo();

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
%ConvertToSubClassCode
wxClassInfo* c = sipCpp->GetClassInfo();

if(0) ;
#define C(clz) else if (c == CLASSINFO(clz)) sipClass = sipClass_ ## clz;
    C(wxWebViewBeforeLoadEvent)
    C(wxWebViewLoadEvent)
    C(wxWebViewNewWindowEvent)
    C(wxWebViewRightClickEvent)
    C(wxWebViewConsoleMessageEvent)
    C(wxWebViewReceivedTitleEvent)
else
    sipClass = NULL;
%End

public:
    bool IsCancelled() const;
    void Cancel(bool cancel = true);
    wxString GetURL() const;
    void SetURL(const wxString& url);
    void SetNavigationType(int navType);
    int GetNavigationType() const;

    wxWebViewBeforeLoadEvent( wxWindow* win = NULL );
    //wxEvent *Clone(void) const;
};

class wxWebViewLoadEvent : wxCommandEvent
{
public:
    int GetState() const;
    void SetState(const int state);
    wxString GetURL() const;
    void SetURL(const wxString& url);

    wxWebViewLoadEvent( wxWindow* win = NULL );
    //wxEvent *Clone(void) const;
};

class wxWebViewNewWindowEvent : wxCommandEvent
{
public:
    wxString GetURL() const;
    void SetURL(const wxString& url);
    wxString GetTargetName() const;
    void SetTargetName(const wxString& name);

    wxWebViewNewWindowEvent( wxWindow* win = NULL);
    //wxEvent *Clone(void) const;
};

class wxWebViewRightClickEvent : wxCommandEvent
{
public:
    wxWebViewRightClickEvent( wxWindow* win = NULL);
    //wxEvent *Clone(void) const;

    wxWebViewDOMElementInfo GetInfo() const;
    void SetInfo(wxWebViewDOMElementInfo info);

    wxPoint GetPosition() const;
    void SetPosition(wxPoint pos);
};

class wxWebViewConsoleMessageEvent : wxCommandEvent
{
public:
    wxString GetMessage() const;
    void SetMessage(const wxString& message);

    unsigned int GetLineNumber() const;
    void SetLineNumber(unsigned int lineNumber);

    wxString GetSourceID() const;
    void SetSourceID(const wxString& sourceID);

    wxWebViewConsoleMessageEvent( wxWindow* win = NULL );
    //wxEvent *Clone(void) const;
};

class wxWebViewReceivedTitleEvent : wxCommandEvent
{
public:
    wxString GetTitle() const;
    void SetTitle(const wxString& title);

    wxWebViewReceivedTitleEvent( wxWindow* win = static_cast<wxWindow*>(NULL));
    //wxEvent *Clone(void) const;
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

add_event(sipModuleDict, "EVT_WEBVIEW_BEFORE_LOAD", wxEVT_WEBVIEW_BEFORE_LOAD);
add_event(sipModuleDict, "EVT_WEBVIEW_LOAD", wxEVT_WEBVIEW_LOAD);
add_event(sipModuleDict, "EVT_WEBVIEW_NEW_WINDOW", wxEVT_WEBVIEW_NEW_WINDOW);
add_event(sipModuleDict, "EVT_WEBVIEW_RIGHT_CLICK", wxEVT_WEBVIEW_RIGHT_CLICK);
add_event(sipModuleDict, "EVT_WEBVIEW_CONSOLE_MESSAGE", wxEVT_WEBVIEW_CONSOLE_MESSAGE);
add_event(sipModuleDict, "EVT_WEBVIEW_RECEIVED_TITLE", wxEVT_WEBVIEW_RECEIVED_TITLE);
%End
