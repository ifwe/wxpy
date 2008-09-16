%ModuleHeaderCode
#include <wx/hyperlink.h>
%End


enum {
    wxHL_CONTEXTMENU,
    wxHL_ALIGN_LEFT,
    wxHL_ALIGN_RIGHT,
    wxHL_ALIGN_CENTRE,
    wxHL_DEFAULT_STYLE,
};


class wxHyperlinkCtrl : wxControl
{
public:
    wxHyperlinkCtrl(wxWindow *parent /TransferThis/,
                    wxWindowID id,
                    const wxString& label, const wxString& url,
                    const wxPoint& pos = wxDefaultPosition,
                    const wxSize& size = wxDefaultSize,
                    long style = wxHL_DEFAULT_STYLE,
                    const wxString& name = wxHyperlinkCtrlNameStr);
    virtual ~wxHyperlinkCtrl();


    wxColour GetHoverColour() const;
    void SetHoverColour(const wxColour &colour);

    wxColour GetNormalColour() const;
    void SetNormalColour(const wxColour &colour);

    wxColour GetVisitedColour() const;
    void SetVisitedColour(const wxColour &colour);

    wxString GetURL() const;
    void SetURL (const wxString &url);

    void SetVisited(bool visited = true);
    bool GetVisited() const;
};


class wxHyperlinkEvent : wxCommandEvent
{
public:
    wxHyperlinkEvent(wxObject *generator, wxWindowID id, const wxString& url);
    virtual ~wxHyperlinkEvent();


    wxString GetURL() const;
    void SetURL(const wxString &url);
};


%PostInitialisationCode
    add_event(sipModuleDict, "EVT_HYPERLINK", wxEVT_COMMAND_HYPERLINK, 0);
%End
