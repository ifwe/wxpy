
class wxSizerItem: wxObject
{
private:
    wxSizerItem(const wxSizerItem&);
    wxSizerItem();

public:
    virtual ~wxSizerItem();
/*
    wxSizerItem(wxWindow *window,
                int proportion,
                int flag,
                int border,
                wxObject* userData);

    //wxSizerItem(wxWindow *window, const wxSizerFlags& flags);

    wxSizerItem(wxSizer *sizer,
                int proportion,
                int flag,
                int border,
                wxObject* userData);

    //wxSizerItem(wxSizer *sizer, const wxSizerFlags& flags);

    // spacer
    wxSizerItem( int width,
                 int height,
                 int proportion,
                 int flag,
                 int border,
                 wxObject* userData);

    // spacer with flags
    //wxSizerItem(int width, int height, const wxSizerFlags& flags);
*/
    void DeleteWindows();
    void DetachSizer();

    wxSize GetSize() const;
    wxSize CalcMin();
    void SetDimension( const wxPoint& pos, const wxSize& size );

    wxSize GetMinSize() const;
    wxSize GetMinSizeWithBorder() const;
    void SetMinSize(const wxSize& size);
    void SetInitSize(int x, int y);

    // if either of dimensions is zero, ratio is assumed to be 1
    // to avoid "divide by zero" errors
    void SetRatio(int width, int height);
    void SetRatio(const wxSize& size);
    void SetRatio(float ratio);
    float GetRatio() const;

    wxRect GetRect();

    bool IsWindow();
    bool IsSizer();
    bool IsSpacer();

    void SetProportion( int proportion );
    int GetProportion() const;
    void SetFlag( int flag );
    int GetFlag() const;
    void SetBorder( int border );
    int GetBorder() const;

    wxWindow *GetWindow() const;
    wxSizer *GetSizer() const;
    wxSize GetSpacer() const;

    bool IsShown() const;
    void Show(bool show);

//    void SetUserData(wxObject* userData);
//    wxObject* GetUserData() const;

    wxPoint GetPosition() const;

    void SetWindow(wxWindow *window);
    void SetSizer(wxSizer *sizer);

    void SetSpacer(const wxSize& size);
    void SetSpacer(int width, int height);

};

class wxSizer: wxObject
{
public:
    virtual ~wxSizer();

    //
    // Add
    //

    wxSizerItem* Add(wxWindow* item, int proportion = 0, int flag = 0, int border = 0) /Transfer/;
/*%MethodCode
        printf("Sizer.Add(wxWindow* %p)\n", a0);
        sipRes = sipCpp->Add(a0, a1, a2, a3);
        printf("new child count is %d\n", sipCpp->GetChildren().size());
%End*/

    wxSizerItem* Add(wxSizer* item /Transfer/,  int proportion = 0, int flag = 0, int border = 0) /Transfer/;

    wxSizerItem* Add(const wxSize& size, int proportion = 0, int flag = 0, int border = 0) /Transfer/;
%MethodCode
    sipRes = sipCpp->Add(a0->x, a0->y, a1, a2, a3);
%End

//
//    // TODO: transfer ownership for the return value of this function
//    wxSizerItem* Add(SIP_PYTUPLE spacerSize, int proportion = 0, int flag = 0, int border = 0) /Transfer/;
//%MethodCode
//    printf("in wxSizer::Add(tuple)\n");
//    //printf("yes\n");
//    if (PySequence_Fast_GET_SIZE(a0) != 2)
//    {
//        PyErr_SetString(PyExc_TypeError, "wx.Sizer.Add: first argument size must be 2 integers");
//        sipIsErr = 1;
//    }
//    else
//    {
//        int w = PyInt_AsLong(PySequence_Fast_GET_ITEM(a0, 0));
//        int h = PyInt_AsLong(PySequence_Fast_GET_ITEM(a0, 1));
//
//        if ((w == -1 || h == -1) && PyErr_Occurred())
//            sipIsErr = 1;
//        else
//            sipRes = sipCpp->Add(w, h, a1, a2, a3);
//    }
//%End

    wxSizerItem* AddStretchSpacer(int prop = 1) /Transfer/;
    wxSizerItem* AddSpacer(int size) /Transfer/;

    //
    // Insert
    //

    wxSizerItem* Insert(int index, wxWindow* item, int proportion = 0, int flag = 0, int border = 0) /Transfer/;
    wxSizerItem* Insert(int index, wxSizer* item /Transfer/,  int proportion = 0, int flag = 0, int border = 0) /Transfer/;

    wxSizerItem* AddSpacer(SIP_PYTUPLE) /Transfer/;
%MethodCode
    static const char* AddSpacerMsg = "AddSpacer expects an integer or a sequence of 2 integers";

    SIP_BLOCK_THREADS
    PyObject* fast = PySequence_Fast(a0, AddSpacerMsg);
    if (fast)
    {
        if (PySequence_Fast_GET_SIZE(fast) == 2)
        {
            int width  = PyInt_AsLong(PySequence_Fast_GET_ITEM(fast, 0));
            int height = PyInt_AsLong(PySequence_Fast_GET_ITEM(fast, 1));

            if (width != -1 && height != -1 && !PyErr_Occurred())
                sipRes = sipCpp->Add(width, height, 0);
        }
        Py_DECREF(fast);
    }

    if (!sipRes)
    {
        PyErr_SetString(PyExc_TypeError, AddSpacerMsg);
        sipIsErr = 1;
    }

    SIP_UNBLOCK_THREADS
%End

    bool Detach(wxWindow* window);
%MethodCode
    wxSizerItem* item = sipCpp->GetItem(a0);
    sipRes = sipCpp->Detach(a0);
    if (sipRes)
        setDeleted(item, sipClass_wxSizerItem);
%End

    bool Detach(wxSizer* sizer);
%MethodCode
    wxSizerItem* item = sipCpp->GetItem(a0);
    wxSizer* sizer = item ? item->GetSizer() : 0;

    sipRes = sipCpp->Detach(a0);

    if (sipRes)
    {
        transferBack(sizer, sipClass_wxSizer);
        setDeleted(item, sipClass_wxSizerItem);
    }

%End

    bool Detach(size_t index);
%MethodCode
    wxSizerItem* item = sipCpp->GetItem(a0);
    wxSizer* sizer = item ? item->GetSizer() : 0;

    sipRes = sipCpp->Detach(a0);

    if (sipRes)
    {
        // the only owned item by a wxSizerItem is a wxSizer
        transferBack(sizer, sipClass_wxSizer);
        setDeleted(item, sipClass_wxSizerItem);
    }
%End

    bool Show(wxWindow* item, bool show = true, bool recursive = false);
    bool Show(wxSizer*  item, bool show = true, bool recursive = false);
    bool Show(size_t    item, bool show = true);

    bool IsShown(wxWindow *window) const;
    bool IsShown(wxSizer *sizer) const;
    bool IsShown(size_t index) const;

    /* deprecated
    bool Remove(wxWindow* window);
    bool Remove(wxSizer* sizer);
    bool Remove(size_t index);
    */

    void SetDimension( int x, int y, int width, int height );
    void SetMinSize( const wxSize &size );
    wxSize GetSize();
    wxPoint GetPosition();
    wxSize GetMinSize();
    virtual void RecalcSizes() = 0;
    wxSize CalcMin();
    void Layout();
    wxSize ComputeFittingClientSize(wxWindow *window);
    wxSize ComputeFittingWindowSize(wxWindow *window);
    wxSize Fit(wxWindow *window);
    void FitInside(wxWindow *window);
    void SetSizeHints( wxWindow *window );
    void SetVirtualSizeHints( wxWindow *window );
    void Clear(bool deleteWindows = false);

    void DeleteWindows();

    size_t GetChildCount();
%MethodCode
    sipRes = sipCpp->GetChildren().GetCount();
%End

    SIP_PYLIST GetChildren();
%MethodCode
    wxSizerItemList& children = sipCpp->GetChildren();
    if ((sipRes = PyList_New(children.size())) == NULL)
        sipIsErr = 1;
    else
    {
        wxSizerItemList::iterator iter;
        size_t i = 0;
        for (iter = children.begin(); iter != children.end(); ++iter, ++i)
        {
            wxSizerItem *t = *iter;
            PyObject *tobj;

            if ((tobj = sipConvertFromInstance(t, sipClass_wxSizerItem, sipSelf)) == NULL)
            {
                // There was an error so garbage collect the Python list.
                Py_DECREF(sipRes);
                sipIsErr = 1;
                break;
            }

            PyList_SET_ITEM(sipRes, i, tobj);
        }
    }
%End

void ShowItems(bool show);

private:
    wxSizer(); // abstract
};

class wxBoxSizer: wxSizer
{
public:
    wxBoxSizer(int orient);
    virtual ~wxBoxSizer();

    void RecalcSizes();

    wxSize CalcMin();

    int GetOrientation() const;
    void SetOrientation(int orient);
};

class wxGridSizer: wxSizer
{
public:
    wxGridSizer(int rows=1, int cols=0, int vgap=0, int hgap=0);
    virtual ~wxGridSizer();

    void RecalcSizes();

    void SetCols(int cols);
    void SetRows(int rows);
    void SetVGap(int gap);
    void SetHGap(int gap);
    int GetCols();
    int GetRows();
    int GetVGap();
    int GetHGap();
};


enum wxFlexSizerGrowMode
{
    wxFLEX_GROWMODE_NONE,
    wxFLEX_GROWMODE_SPECIFIED,
    wxFLEX_GROWMODE_ALL
};

class wxFlexGridSizer : wxSizer
{
public:
    wxFlexGridSizer(int rows, int cols, int vgap = 0, int hgap = 0);
    virtual ~wxFlexGridSizer();

    void RecalcSizes();

    void AddGrowableRow(size_t idx, int proportion = 0);
    void RemoveGrowableRow(size_t idx);
    void AddGrowableCol(size_t idx, int proportion = 0);
    void RemoveGrowableCol(size_t idx);
    void SetFlexibleDirection(int direction);

    int GetFlexibleDirection();
    void SetNonFlexibleGrowMode(wxFlexSizerGrowMode mode);

    wxFlexSizerGrowMode GetNonFlexibleGrowMode();

    //const wxArrayInt& GetRowHeights() const;
    //const wxArrayInt& GetColWidths() const;

private:
    wxFlexGridSizer(const wxFlexGridSizer&);
};


class wxStaticBoxSizer : wxBoxSizer
{
public:
    wxStaticBoxSizer(wxStaticBox *box /Transfer/, int orient = wxHORIZONTAL);
    virtual ~wxStaticBoxSizer();

    void RecalcSizes();

    wxStaticBox* GetStaticBox();
private:
    wxStaticBoxSizer(const wxStaticBoxSizer&);
};
