%ModuleHeaderCode
#include <wx/srchctrl.h>
%End

%PostInitialisationCode
add_event(sipModuleDict, "EVT_SEARCHCTRL_CANCEL_BTN", wxEVT_COMMAND_SEARCHCTRL_CANCEL_BTN, 0);
add_event(sipModuleDict, "EVT_SEARCHCTRL_SEARCH_BTN", wxEVT_COMMAND_SEARCHCTRL_SEARCH_BTN, 0);
%End

class wxSearchCtrl : wxTextCtrl
{
public:
    wxSearchCtrl(wxWindow *parent /TransferThis/, wxWindowID id=-1,
                 const wxString& value = wxEmptyString,
                 const wxPoint& pos = wxDefaultPosition,
                 const wxSize& size = wxDefaultSize,
                 long style = 0,
                 const wxValidator& validator = wxDefaultValidator,
                 const wxString& name = wxSearchCtrlNameStr);
    virtual ~wxSearchCtrl();

    void SetMenu(wxMenu* menu);
    wxMenu* GetMenu();
    virtual bool CanPaste() const;
    void ShowSearchButton( bool show );
    bool IsSearchButtonVisible() const;
    void ShowCancelButton( bool show );
    bool IsCancelButtonVisible() const;
    void SetDescriptiveText(const wxString& text);
    wxString GetDescriptiveText() const;

    void SetSearchBitmap(const wxBitmap&);
/*
#ifdef __WXMAC__
    %extend {
        void SetSearchBitmap( const wxBitmap& ) {}
        void SetSearchMenuBitmap( const wxBitmap& ) {}
        void SetCancelBitmap( const wxBitmap& ) {}
    }
#else
    void SetSearchBitmap( const wxBitmap& bitmap );
    void SetSearchMenuBitmap( const wxBitmap& bitmap );
    void SetCancelBitmap( const wxBitmap& bitmap );
#endif
*/
};


