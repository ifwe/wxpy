class wxGBPosition
{
%TypeHeaderCode
#include <wx/gbsizer.h>
%End
public:
    wxGBPosition(int row = 0, int col = 0);
    virtual ~wxGBPosition();

%ConvertToTypeCode
    if (sipIsErr == NULL)
        return sipCanConvertToInstance(sipPy, sipClass_wxGBPosition, SIP_NO_CONVERTORS)
            || sequence_2_ints_check(sipPy);

    int _x, _y;
    if (sequence_2_ints(sipPy, &_x, &_y)) {
        *sipCppPtr = new wxGBPosition(_x, _y);
        return sipGetState(sipTransferObj);
    }

    *sipCppPtr = reinterpret_cast<wxGBPosition *>(sipConvertToInstance(sipPy, sipClass_wxGBPosition, sipTransferObj, SIP_NO_CONVERTORS, 0, sipIsErr));
    return 0;
%End

    bool operator==(const wxGBPosition&);

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
    wxGBSpan(int rowspan = 1, int colspan = 1);
    virtual ~wxGBSpan();

%ConvertToTypeCode
    if (sipIsErr == NULL)
        return sipCanConvertToInstance(sipPy, sipClass_wxGBSpan, SIP_NO_CONVERTORS)
            || sequence_2_ints_check(sipPy);

    int _x, _y;
    if (sequence_2_ints(sipPy, &_x, &_y)) {
        *sipCppPtr = new wxGBSpan(_x, _y);
        return sipGetState(sipTransferObj);
    }

    *sipCppPtr = reinterpret_cast<wxGBSpan *>(sipConvertToInstance(sipPy, sipClass_wxGBSpan, sipTransferObj, SIP_NO_CONVERTORS, 0, sipIsErr));
    return 0;
%End

    bool operator==(const wxGBSpan&);

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
    virtual ~wxGBSizerItem();

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

private:
    wxGridBagSizer(const wxGridBagSizer&);
public:
    wxGridBagSizer(int vgap = 0, int hgap = 0);
    virtual ~wxGridBagSizer();

    wxSizerItem* Add(wxWindow *window,
                     const wxGBPosition& pos,
                     const wxGBSpan& span = wxDefaultSpan,
                     int flag = 0,
                     int border = 0) /Transfer/;

    wxSizerItem* Add(wxSizer *sizer /Transfer/,
                     const wxGBPosition& pos,
                     const wxGBSpan& span = wxDefaultSpan,
                     int flag = 0,
                     int border = 0) /Transfer/;

    wxSizerItem* Add(SIP_PYTUPLE spacerSize,
                     const wxGBPosition& pos,
                     const wxGBSpan& span = wxDefaultSpan,
                     int flag = 0,
                     int border = 0) /Transfer/;
%MethodCode
    if (PySequence_Fast_GET_SIZE(a0) != 2) {
        PyErr_SetString(PyExc_TypeError, "wx.GridBagSizer.Add (with size argument): first argument must be a sequence of 2 integers");
        sipIsErr = 1;
    } else {
        int w = PyInt_AsLong(PySequence_Fast_GET_ITEM(a0, 0));
        int h = PyInt_AsLong(PySequence_Fast_GET_ITEM(a0, 1));

        if ((w == -1 || h == -1) && PyErr_Occurred())
            sipIsErr = 1;
        else
            sipRes = sipCpp->Add(w, h, *a1, *a2, a3, a4);
    }
%End

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

    wxGBSizerItem* FindItem(wxWindow* window) /Transfer/;
    wxGBSizerItem* FindItem(wxSizer* sizer) /Transfer/;
    wxGBSizerItem* FindItemAtPosition(const wxGBPosition& pos) /Transfer/;
    wxGBSizerItem* FindItemAtPoint(const wxPoint& pt) /Transfer/;

    bool CheckForIntersection(wxGBSizerItem* item, wxGBSizerItem* excludeItem = NULL);
    bool CheckForIntersection(const wxGBPosition& pos, const wxGBSpan& span, wxGBSizerItem* excludeItem = NULL);

    void RecalcSizes();
};

