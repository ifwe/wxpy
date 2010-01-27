%If (WXMSW)
class wxComboBox : wxChoice
{
public:
    wxComboBox(wxWindow* parent /TransferThis/,
               wxWindowID id,
               const wxString& value,
               const wxPoint& pos,
               const wxSize& size,
               const wxArrayString& choices,
               long style = 0,
               const wxValidator& validator = wxDefaultValidator,
               const wxString& name = wxComboBoxNameStr);
    virtual ~wxComboBox();

    wxString GetValue() const;
    void SetValue(const wxString& value);

    void Copy();
    void Cut();
    void Paste();

    void SetInsertionPoint(long pos);
    long GetInsertionPoint() const;
    long GetLastPosition() const;

    void Replace(long from, long to, const wxString& value);
    void SetSelection(int n);
    void SetSelection(long from, long to);

    int GetCurrentSelection() const;
    bool SetStringSelection(const wxString& string);
    void SetString(int n, const wxString& string);
    void SetEditable(bool editable);
    void SetInsertionPointEnd();
    void Remove(long from, long to);

    bool IsEditable() const;
    void Undo();
    void Redo();
    void SelectAll();

    bool CanCopy() const;
    bool CanCut() const;
    bool CanPaste() const;
    bool CanUndo() const;
    bool CanRedo() const;

};
%End

%If (!WXMSW)
class wxComboBox : wxControl, wxItemContainer
{
public:
    wxComboBox(wxWindow* parent /TransferThis/,
               wxWindowID id,
               const wxString& value,
               const wxPoint& pos,
               const wxSize& size,
               const wxArrayString& choices,
               long style = 0,
               const wxValidator& validator = wxDefaultValidator,
               const wxString& name = wxComboBoxNameStr);
    virtual ~wxComboBox();

    wxString GetValue() const;
    void SetValue(const wxString& value);

    void Copy();
    void Cut();
    void Paste();

    void SetInsertionPoint(long pos);
    long GetInsertionPoint() const;
    long GetLastPosition() const;

    void Replace(long from, long to, const wxString& value);
    void SetSelection(int n);
    void SetSelection(long from, long to);

    int GetCurrentSelection() const;
    bool SetStringSelection(const wxString& string);
    void SetString(int n, const wxString& string);
    void SetEditable(bool editable);
    void SetInsertionPointEnd();
    void Remove(long from, long to);

    bool IsEditable() const;
    void Undo();
    void Redo();
    void SelectAll();

    bool CanCopy() const;
    bool CanCut() const;
    bool CanPaste() const;
    bool CanUndo() const;
    bool CanRedo() const;
};

%End
