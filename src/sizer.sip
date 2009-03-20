%ModuleHeaderCode
class wxPyData : public wxObject
{
private:
    wxPyData(const wxPyData&);
public:
    wxPyData() { m_obj = 0; }
    wxPyData(PyObject* obj)
    {
        Py_XINCREF(obj);
        m_obj = obj;
    }

    virtual ~wxPyData()
    {
        SIP_BLOCK_THREADS
        Py_CLEAR(m_obj);
        SIP_UNBLOCK_THREADS
    }

    PyObject* m_obj;
};
%End

class wxSizerItem: wxObject
{
private:
    wxSizerItem(const wxSizerItem&);
    wxSizerItem();
    virtual ~wxSizerItem();

public:
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
    void SetDimension(const wxPoint& pos, const wxSize& size);

    wxSize GetMinSize() const;
    void SetMinSize(const wxSize& size);

    wxSize GetMinSizeWithBorder() const;
    void SetInitSize(int x, int y);

    // if either of dimensions is zero, ratio is assumed to be 1
    // to avoid "divide by zero" errors
    /*
    void SetRatio(int width, int height);
    void SetRatio(const wxSize& size);
    void SetRatio(float ratio);
    float GetRatio() const;
    */

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

//%GCTraverseCode
//    wxPyData* obj = reinterpret_cast<wxPyData*>(sipCpp->GetUserData());
//    if (!obj)
//        return 0;
//
//    sipRes = obj->m_obj ? sipVisit(obj->m_obj, sipArg) : 0;
//%End
//
//%GCClearCode
//    PyObject* obj;
//    obj = reinterpret_cast<PyObject *>(sipCpp->GetUserData());
//    if (obj)
//        sipCpp->SetUserData(0); // calls delete on the wxPyData
//    sipRes = 0;
//%End

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

    wxSizerItem* AddStretchSpacer(int prop = 1) /Transfer/;
    wxSizerItem* AddSpacer(int size) /Transfer/;

    //
    // Insert
    //

    wxSizerItem* Insert(int index, wxWindow* item, int proportion = 0, int flag = 0, int border = 0) /Transfer/;
    wxSizerItem* Insert(int index, wxSizer* item /Transfer/,  int proportion = 0, int flag = 0, int border = 0) /Transfer/;
    wxSizerItem* Insert(int index, const wxSize& size, int proportion = 0, int flag = 0, int border = 0) /Transfer/;
%MethodCode
    sipRes = sipCpp->Insert(a0, a1->x, a1->y, a2, a3, a4);
%End

    wxSizerItem* AddSpacer(SIP_PYTUPLE, int proportion = 0, int flag = 0, int border = 0) /Transfer/;
%MethodCode
    static const char* AddSpacerMsg = "AddSpacer expects an integer or a sequence of 2 integers";

    PyObject* fast = PySequence_Fast(a0, AddSpacerMsg);
    if (fast) {
        if (PySequence_Fast_GET_SIZE(fast) == 2) {
            int width  = PyInt_AsLong(PySequence_Fast_GET_ITEM(fast, 0));
            int height = PyInt_AsLong(PySequence_Fast_GET_ITEM(fast, 1));

            if (width != -1 && height != -1 && !PyErr_Occurred())
                sipRes = sipCpp->Add(width, height, a1, a2, a3);
            else
                sipIsErr = 1;
        }
        Py_DECREF(fast);
    }

    if (!sipRes) {
        PyErr_SetString(PyExc_TypeError, AddSpacerMsg);
        sipIsErr = 1;
    }
%End

    bool Detach(wxWindow* window);
    bool Detach(wxSizer* sizer);
    bool Detach(size_t index);

    wxSizerItem* GetItem(wxWindow* window, bool recursive = false) /Transfer/;
    wxSizerItem* GetItem(wxSizer* sizer, bool recursive = false) /Transfer/;
    //wxSizerItem* GetItem(size_t index) /Transfer/;

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
    sipRes = PyList_New(children.size());
    if (!sipRes)
        sipIsErr = 1;
    else {
        size_t i = 0;
        wxSizerItemList::iterator iter;
        for (iter = children.begin(); iter != children.end(); ++iter, ++i) {
            wxSizerItem *t = *iter;
            PyObject *tobj = sipConvertFromInstance(t, sipClass_wxSizerItem, sipSelf);

            if (!tobj) {
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

//
// wxPySizer: a custom sizer with overridable CalcMin and RecalcSizes
//

%ModuleHeaderCode

class wxPySizer : public wxSizer
{
public:
    wxPySizer() {}
    virtual ~wxPySizer() {}

    virtual wxSize CalcMin() = 0;
    virtual void RecalcSizes() = 0;
};

%End

class wxPySizer : wxSizer
{
public:
    wxPySizer();
    virtual ~wxPySizer();

    virtual wxSize CalcMin() = 0;
    virtual void RecalcSizes() = 0;
};

//
// wxBoxSizer
//

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



class wxFlexGridSizer : wxGridSizer
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


class wxStdDialogButtonSizer : wxBoxSizer
{
private:
    wxStdDialogButtonSizer();
    wxStdDialogButtonSizer(const wxStdDialogButtonSizer&);
public:
    virtual ~wxStdDialogButtonSizer();

    void AddButton(wxButton *button);
    void Realize();

    void SetAffirmativeButton(wxButton *button);
    void SetNegativeButton(wxButton *button);
    void SetCancelButton(wxButton *button);

    wxButton* GetAffirmativeButton() const;
    wxButton* GetApplyButton() const;
    wxButton* GetNegativeButton() const;
    wxButton* GetCancelButton() const;
    wxButton* GetHelpButton() const;
};
