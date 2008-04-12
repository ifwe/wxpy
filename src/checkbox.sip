enum wxCheckBoxState
{
    wxCHK_UNCHECKED,
    wxCHK_CHECKED,
    wxCHK_UNDETERMINED /* 3-state checkbox only */
};

class wxCheckBox: wxControl
{
public:
    wxCheckBox(wxWindow *parent /TransferThis/,
               wxWindowID id,
               const wxString& label,
               const wxPoint& pos = wxDefaultPosition,
               const wxSize& size = wxDefaultSize,
               long style = 0,
               const wxValidator& validator = wxDefaultValidator,
               const wxString& name = wxCheckBoxNameStr);
               
    void SetValue(bool value);
    bool GetValue() const;
    bool IsChecked() const;
    wxCheckBoxState Get3StateValue() const;
    void Set3StateValue(wxCheckBoxState state);
    bool Is3State() const;
    bool Is3rdStateAllowedForUser() const;
};
