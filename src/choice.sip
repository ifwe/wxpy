class wxChoice : wxControlWithItems
{
public:
    wxChoice(wxWindow *parent /TransferThis/, wxWindowID id,
             const wxPoint& pos,
             const wxSize& size,
             const wxArrayString& choices,
             long style = 0,
             const wxValidator& validator = wxDefaultValidator,
             const wxString& name = wxChoiceNameStr);
    virtual ~wxChoice();

    int GetCurrentSelection() const;

    unsigned int GetCount() const;
    wxString GetString(unsigned int n) const;
    void SetSelection(int n);
};
