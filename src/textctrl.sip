%If (wxUSE_TEXTCTRL)

typedef long wxTextPos;
typedef long wxTextCoord;


enum wxTextCtrlHitTestResult
{
    wxTE_HT_UNKNOWN = -2,   // this means HitTest() is simply not implemented
    wxTE_HT_BEFORE,         // either to the left or upper
    wxTE_HT_ON_TEXT,        // directly on
    wxTE_HT_BELOW,          // below [the last line]
    wxTE_HT_BEYOND          // after [the end of line]
};

enum wxTextAttrAlignment
{
    wxTEXT_ALIGNMENT_DEFAULT,
    wxTEXT_ALIGNMENT_LEFT,
    wxTEXT_ALIGNMENT_CENTRE,
    wxTEXT_ALIGNMENT_CENTER = wxTEXT_ALIGNMENT_CENTRE,
    wxTEXT_ALIGNMENT_RIGHT,
    wxTEXT_ALIGNMENT_JUSTIFIED
};

class wxTextAttr
{
public:

    wxTextAttr(const wxColour& colText,
               const wxColour& colBack = wxNullColour,
               const wxFont& font = wxNullFont,
               wxTextAttrAlignment alignment = wxTEXT_ALIGNMENT_DEFAULT);

    static wxTextAttr Merge(const wxTextAttr& base, const wxTextAttr& overlay);
    void Merge(const wxTextAttr& overlay);

   // void operator=(const wxTextAttr& attr);

    void SetTextColour(const wxColour& colText);
    void SetBackgroundColour(const wxColour& colBack);
    void SetFont(const wxFont& font, long flags = wxTEXT_ATTR_FONT);
    void SetAlignment(wxTextAttrAlignment alignment);
    //void SetTabs(const wxArrayInt& tabs);
    void SetLeftIndent(int indent, int subIndent );
    void SetRightIndent(int indent);
    void SetFlags(long flags);

    bool HasTextColour() const;
    bool HasBackgroundColour() const;
    bool HasFont() const;
    bool HasAlignment() const;
    bool HasTabs() const;
    bool HasLeftIndent() const;
    bool HasRightIndent() const;
    bool HasFlag(long flag) const;

    const wxColour& GetTextColour() const;
    const wxColour& GetBackgroundColour() const;
    const wxFont& GetFont() const;
    wxTextAttrAlignment GetAlignment() const;
    //const wxArrayInt& GetTabs() const;
    long GetLeftIndent() const;
    long GetLeftSubIndent() const;
    long GetRightIndent() const;
    long GetFlags() const;

    bool IsDefault() const;
/*
    static wxTextAttr Combine(const wxTextAttr& attr,
                              const wxTextAttr& attrDef,
                              const wxTextCtrl *text);
                              */
};

class wxTextCtrl: wxControl
{
public:
    wxTextCtrl(wxWindow *parent /TransferThis/, wxWindowID id,
               const wxString& value = wxEmptyString,
               const wxPoint& pos = wxDefaultPosition,
               const wxSize& size = wxDefaultSize,
               long style = 0,
               const wxValidator& validator = wxDefaultValidator,
               const wxString& name = wxTextCtrlNameStr);    

     wxString GetValue() const;
     bool IsEmpty() const;

     void SetValue(const wxString& value);
     void ChangeValue(const wxString& value);

     wxString GetRange(long from, long to) const;

     int GetLineLength(long lineNo) const;
     wxString GetLineText(long lineNo) const;
     int GetNumberOfLines() const;

     bool IsModified() const;
     bool IsEditable() const;

    bool IsSingleLine() const;
    bool IsMultiLine() const;

    void GetSelection(long* from /Out/, long* to /Out/) const;

     wxString GetStringSelection() const;

     void Clear();
     void Replace(long from, long to, const wxString& value);
     void Remove(long from, long to);

     bool LoadFile(const wxString& file, int fileType = wxTEXT_TYPE_ANY);
     bool SaveFile(const wxString& file = wxEmptyString, int fileType = wxTEXT_TYPE_ANY);

     void MarkDirty();
     void DiscardEdits();
     void SetModified(bool modified);

     void SetMaxLength(unsigned long len);

     void WriteText(const wxString& text);
     void AppendText(const wxString& text);

     bool EmulateKeyPress(const wxKeyEvent& event);

     bool SetStyle(long start, long end, const wxTextAttr& style);
     bool GetStyle(long position, wxTextAttr& style /Out/);
     bool SetDefaultStyle(const wxTextAttr& style);
     const wxTextAttr& GetDefaultStyle() const;

     long XYToPosition(long x, long y) const;
     bool PositionToXY(long pos, long *x /Out/, long *y /Out/) const;
     void ShowPosition(long pos);

     wxTextCtrlHitTestResult HitTest(const wxPoint& pt, long *pos /Out/) const /PyName=HitTestPos/;
     wxTextCtrlHitTestResult HitTest(const wxPoint& pt, wxTextCoord *col /Out/, wxTextCoord *row /Out/) const;

     void Copy();
     void Cut();
     void Paste();

     bool CanCopy() const;
     bool CanCut() const;
     bool CanPaste() const;

    // Undo/redo
     void Undo();
     void Redo();

     bool CanUndo() const;
     bool CanRedo() const;

    // Insertion point
     void SetInsertionPoint(long pos);
     void SetInsertionPointEnd();
     long GetInsertionPoint() const;
     wxTextPos GetLastPosition() const;

     void SetSelection(long from, long to);
     void SelectAll();
     void SetEditable(bool editable);

    void SendTextUpdatedEvent();
private:
    wxTextCtrl(const wxTextCtrl&);
};

%End