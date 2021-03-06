

class wxVScrolledWindow : wxPanel
{
%TypeHeaderCode
#include <wx/vscroll.h>
%End

public:
    wxVScrolledWindow(wxWindow *parent /TransferThis/,
                      wxWindowID id = wxID_ANY,
                      const wxPoint& pos = wxDefaultPosition,
                      const wxSize& size = wxDefaultSize,
                      long style = 0,
                      const wxString& name = wxPanelNameStr);
    virtual ~wxVScrolledWindow();

    void SetLineCount(size_t count);
    bool ScrollToLine(size_t line);

    bool ScrollLines(int lines);
    bool ScrollPages(int pages);
    void RefreshLine(size_t line);
    void RefreshLines(size_t from, size_t to);

    int HitTest(wxCoord x, wxCoord y) const;
    int HitTest(const wxPoint& pt) const;

    virtual void RefreshAll();

    size_t GetLineCount() const;
    size_t GetVisibleBegin() const;
    size_t GetVisibleEnd() const;
    bool IsVisible(size_t line) const;

    size_t GetFirstVisibleLine() const;
    size_t GetLastVisibleLine() const;

protected:
    virtual wxCoord OnGetLineHeight(size_t n) const = 0;
    virtual void OnGetLinesHint(size_t lineMin, size_t lineMax) const;
    virtual wxCoord EstimateTotalHeight() const;
};



class wxVListBox : wxVScrolledWindow
{
%TypeHeaderCode
#include <wx/vlbox.h>
%End

private:
    wxVListBox();
    wxVListBox(const wxVListBox&);

public:
    virtual ~wxVListBox();

    size_t GetItemCount() const;
    bool HasMultipleSelection() const;
    int GetSelection() const;
    bool IsCurrent(size_t item) const;
    bool IsSelected(size_t item) const;
    size_t GetSelectedCount() const;

    int GetFirstSelected(unsigned long& cookie /Out/) const;
    SIP_PYOBJECT GetNextSelected(unsigned long cookie) const;
%MethodCode
    unsigned long cookie = a0;
    int index = sipCpp->GetNextSelected(cookie);
    sipRes = Py_BuildValue("(ik)", index, cookie);
%End

    wxPoint GetMargins() const;
    const wxColour& GetSelectionBackground() const;

    void SetItemCount(size_t count);
    void Clear();
    void SetSelection(int selection);
    bool Select(size_t item, bool select = true);

    bool SelectRange(size_t from, size_t to);
    void Toggle(size_t item);
    bool SelectAll();
    bool DeselectAll();

    void SetMargins(const wxPoint& pt);
    void SetMargins(wxCoord x, wxCoord y);

    void SetSelectionBackground(const wxColour& col);

protected:
    wxVListBox(wxWindow *parent /TransferThis/,
               wxWindowID id = wxID_ANY,
               const wxPoint& pos = wxDefaultPosition,
               const wxSize& size = wxDefaultSize,
               long style = 0,
               const wxString& name = wxVListBoxNameStr);

    virtual void OnDrawItem(wxDC& dc, const wxRect& rect, size_t n) const = 0;
    virtual void OnDrawBackground(wxDC& dc, const wxRect& rect, size_t n) const;
    virtual void OnDrawSeparator(wxDC&, wxRect&, size_t) const;
    virtual wxCoord OnMeasureItem(size_t n) const = 0;

    virtual wxCoord OnGetLineHeight(size_t line) const; // don't use -- overload OnMeasureItem
};

