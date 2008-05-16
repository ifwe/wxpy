%Module _wxhtml
//%Platforms {WXMSW WXCOCOA WXMAC WXGTK}
//%SIPOptions (RenameWx, AutoProperties)

%Import wx.sip

%ModuleHeaderCode
#include <wx/html/htmlwin.h>
%End


%PreInitialisationCode

%End

%PostInitialisationCode
typedef void (*add_event_type)(PyObject* module_dict, const char* name, ...);

add_event_type add_event = (add_event_type)sipImportSymbol("wxpy_add_event");

add_event(sipModuleDict, "EVT_HTML_CELL_CLICKED", wxEVT_COMMAND_HTML_CELL_CLICKED, 0);
add_event(sipModuleDict, "EVT_HTML_CELL_HOVER",   wxEVT_COMMAND_HTML_CELL_HOVER, 0);
add_event(sipModuleDict, "EVT_HTML_LINK_CLICKED", wxEVT_COMMAND_HTML_LINK_CLICKED, 0);

%End

enum {
    wxHTML_ALIGN_LEFT,
    wxHTML_ALIGN_CENTER,
    wxHTML_ALIGN_RIGHT,
    wxHTML_ALIGN_BOTTOM,
    wxHTML_ALIGN_TOP,

    wxHTML_CLR_FOREGROUND,
    wxHTML_CLR_BACKGROUND,

    wxHTML_UNITS_PIXELS,
    wxHTML_UNITS_PERCENT,

    wxHTML_INDENT_LEFT,
    wxHTML_INDENT_RIGHT,
    wxHTML_INDENT_TOP,
    wxHTML_INDENT_BOTTOM,

    wxHTML_INDENT_HORIZONTAL,
    wxHTML_INDENT_VERTICAL,
    wxHTML_INDENT_ALL,

    wxHTML_COND_ISANCHOR,
    wxHTML_COND_ISIMAGEMAP,
    wxHTML_COND_USER,

};


enum {
    wxHW_SCROLLBAR_NEVER,
    wxHW_SCROLLBAR_AUTO,
    wxHW_NO_SELECTION,
    wxHW_DEFAULT_STYLE,
};


// enums for wxHtmlWindow::OnOpeningURL
enum wxHtmlOpeningStatus
{
    wxHTML_OPEN,
    wxHTML_BLOCK,
    wxHTML_REDIRECT
};

enum wxHtmlURLType
{
    wxHTML_URL_PAGE,
    wxHTML_URL_IMAGE,
    wxHTML_URL_OTHER
};


class wxHtmlLinkInfo : wxObject {
public:
    wxHtmlLinkInfo(const wxString& href, const wxString& target = wxEmptyString);
    wxString GetHref();
    wxString GetTarget();
    //wxMouseEvent* GetEvent();
    //wxHtmlCell* GetHtmlCell();

    void SetEvent(const wxMouseEvent *e);
    //void SetHtmlCell(const wxHtmlCell * e);
};

class wxHtmlWindow : wxWindow
{
public:
    wxHtmlWindow(wxWindow *parent, int id = -1,
                 const wxPoint& pos = wxDefaultPosition,
                 const wxSize& size = wxDefaultSize,
                 int style = wxHW_DEFAULT_STYLE,
                 const wxString& name = wxT("HtmlWindow"));

    bool SetPage(const wxString& source);
    bool LoadPage(const wxString& location);
    bool LoadFile(const wxString& filename);
    bool AppendToPage(const wxString& source);
    wxString GetOpenedPage();
    wxString GetOpenedAnchor();
    wxString GetOpenedPageTitle();

    void SetRelatedFrame(wxFrame* frame, const wxString& format);
    wxFrame* GetRelatedFrame();

    void SetRelatedStatusBar(int bar);

    void SetStandardFonts(int size = -1,
                          const wxString& normal_face = wxEmptyString,
                          const wxString& fixed_face = wxEmptyString);

    void SetLabel(const wxString& title);

    // Sets space between text and window borders.
    void SetBorders(int b);

    // Sets the bitmap to use for background (currnetly it will be tiled,
    // when/if we have CSS support we could add other possibilities...)
    void SetBackgroundImage(const wxBitmap& bmpBg);

    // Saves custom settings into cfg config. it will use the path 'path'
    // if given, otherwise it will save info into currently selected path.
    // saved values : things set by SetFonts, SetBorders.
    //void ReadCustomization(wxConfigBase *cfg, wxString path = wxEmptyString);
    //void WriteCustomization(wxConfigBase *cfg, wxString path = wxEmptyString);

    void SetFonts(wxString normal_face, wxString fixed_face);

    // Goes to previous/next page (in browsing history)
    // Returns True if successful, False otherwise
    bool HistoryBack();
    bool HistoryForward();
    bool HistoryCanBack();
    bool HistoryCanForward();
    void HistoryClear();

    // wxHtmlContainerCell* GetInternalRepresentation();
    //wxHtmlWinParser* GetParser();

//    bool ScrollToAnchor(const wxString& anchor);
//    bool HasAnchor(const wxString& anchor);

    //Adds input filter
    //static void AddFilter(wxPyHtmlFilter *filter);

    void SelectWord(const wxPoint& pos);
    void SelectLine(const wxPoint& pos);
    void SelectAll();

    wxString SelectionToText();
    wxString ToText();

    enum HTMLCursor
    {
        HTMLCursor_Default,
        HTMLCursor_Link,
        HTMLCursor_Text
    };

    static wxCursor GetDefaultHTMLCursor(HTMLCursor type);
};
