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
    virtual ~wxChoice();

    int GetCurrentSelection() const;

    unsigned int GetCount() const;
    wxString GetString(unsigned int n) const;
    void SetSelection(int n);
};
