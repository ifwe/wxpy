class wxGBPosition
{
%TypeHeaderCode
#include <wx/gbsizer.h>
%End    
public:
    wxGBPosition(int row = 0, int col = 0);
    ~wxGBPosition();
    
    int GetRow() const;
    int GetCol() const;
    void SetRow(int row);
    void SetCol(int col);
};

class wxGBSpan
{
%TypeHeaderCode
#include <wx/gbsizer.h>
%End    

public:
    wxGBSpan(int rowspan=1, int colspan=1);
    ~wxGBSpan();

    int GetRowspan() const;
    int GetColspan() const;
    void SetRowspan(int rowspan);
    void SetColspan(int colspan);
};


class wxGBSizerItem: wxSizerItem
{
%TypeHeaderCode
#include <wx/gbsizer.h>
%End    

public:
    wxGBSizerItem();
    ~wxGBSizerItem();
    
    wxGBPosition GetPos() const;
    wxGBSpan GetSpan() const;
    
    bool SetPos(const wxGBPosition& pos);
    bool SetSpan(const wxGBSpan& span);
    bool Intersects(const wxGBSizerItem& other);
    bool Intersects(const wxGBPosition& pos, const wxGBSpan& span);
    wxGridBagSizer* GetGBSizer() const;
    void SetGBSizer(wxGridBagSizer* sizer);
};


class wxGridBagSizer : wxFlexGridSizer
{
%TypeHeaderCode
#include <wx/gbsizer.h>
%End    

public:
    wxGridBagSizer(int vgap = 0, int hgap = 0 );
/*        wxGBSizerItem* Add(PyObject* item,
                           const wxGBPosition& pos,
                           const wxGBSpan& span = wxDefaultSpan,
                           int flag = 0,
                           int border = 0,
                           PyObject* userData = NULL );
  */                          
    //wxGBSizerItem* Add( wxGBSizerItem *item );
    wxSize GetCellSize(int row, int col) const;
    wxSize GetEmptyCellSize() const;
    void SetEmptyCellSize(const wxSize& sz);

    wxGBPosition GetItemPosition(wxWindow *window);
    wxGBPosition GetItemPosition(wxSizer *sizer);
    wxGBPosition GetItemPosition(size_t index);

    bool SetItemPosition(wxWindow *window, const wxGBPosition& pos);
    bool SetItemPosition(wxSizer *sizer, const wxGBPosition& pos);
    bool SetItemPosition(size_t index, const wxGBPosition& pos);

    wxGBSpan GetItemSpan(wxWindow *window);
    wxGBSpan GetItemSpan(wxSizer *sizer);
    wxGBSpan GetItemSpan(size_t index);

    bool SetItemSpan(wxWindow *window, const wxGBSpan& span);
    bool SetItemSpan(wxSizer *sizer, const wxGBSpan& span);
    bool SetItemSpan(size_t index, const wxGBSpan& span);

    wxGBSizerItem* FindItem(wxWindow* window);
    wxGBSizerItem* FindItem(wxSizer* sizer);
    wxGBSizerItem* FindItemAtPosition(const wxGBPosition& pos);
    wxGBSizerItem* FindItemAtPoint(const wxPoint& pt);

    bool CheckForIntersection(wxGBSizerItem* item, wxGBSizerItem* excludeItem = NULL);

    bool CheckForIntersection(const wxGBPosition& pos, const wxGBSpan& span, wxGBSizerItem* excludeItem = NULL);
private:
    wxGridBagSizer(const wxGridBagSizer&);
};

