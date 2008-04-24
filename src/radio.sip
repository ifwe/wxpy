class wxRadioBox : wxControl
{
public:
    wxRadioBox(wxWindow* parent, wxWindowID id=-1,
               const wxString& label = wxEmptyString,
               const wxPoint& pos = wxDefaultPosition,
               const wxSize& size = wxDefaultSize,
               const wxArrayString& choices = NULL,
               int majorDimension = 0,
               long style = wxRA_HORIZONTAL,
               const wxValidator& validator = wxDefaultValidator,
               const wxString& name = wxRadioBoxNameStr);

    void SetSelection(int n);
    int GetSelection() const;

    wxString GetStringSelection() const;
    bool SetStringSelection(const wxString& s);

    // string access
    size_t GetCount() const;
    int FindString(const wxString& s) const;
    
    wxString GetString(int n) const;
    void SetString(int n, const wxString& label);
//    %pythoncode { GetItemLabel = GetString };
//    %pythoncode { SetItemLabel = SetString };

    // change the individual radio button state
    void Enable(unsigned int n, bool enable = true) /PyName=EnableItem/;
    void Show(unsigned int n, bool show = true) /PyName=ShowItem/;
    bool IsItemEnabled(unsigned int n) const;
    bool IsItemShown(unsigned int n) const;

    // layout parameters
    unsigned int GetColumnCount() const;
    unsigned int GetRowCount() const;

    int GetNextItem(int item, wxDirection dir, long style) const;

    void SetItemToolTip(unsigned int item, const wxString& text);
    wxToolTip *GetItemToolTip(unsigned int item) const;

    void SetItemHelpText(unsigned int n, const wxString& helpText);
    wxString GetItemHelpText(unsigned int n) const;
};

class wxRadioButton : wxControl
{
public:
    wxRadioButton(wxWindow* parent /TransferThis/,
                  wxWindowID id = -1,
                  const wxString& label = wxEmptyString,
                  const wxPoint& pos = wxDefaultPosition,
                  const wxSize& size = wxDefaultSize,
                  long style = 0,
                  const wxValidator& validator = wxDefaultValidator,
                  const wxString& name = wxRadioButtonNameStr);

    bool GetValue();
    void SetValue(bool value);
};