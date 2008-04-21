class wxChoice : wxControlWithItems
{
public:
    wxChoice(wxWindow *parent /TransferThis/, wxWindowID id=-1,
             const wxPoint& pos = wxDefaultPosition,
             const wxSize& size = wxDefaultSize,
             const wxArrayString& choices = NULL,
             long style = 0,
             const wxValidator& validator = wxDefaultValidator,
             const wxString& name = wxChoiceNameStr);
    int GetCurrentSelection() const;    
};
