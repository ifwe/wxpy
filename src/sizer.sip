
class wxSizerItem: wxObject {
public:
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
    wxSizerItem();
    virtual ~wxSizerItem();

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

private:
    wxSizerItem(const wxSizerItem&);
};

class wxSizer: wxObject {
public:
    ~wxSizer();

    //
    // Add
    //

    wxSizerItem* Add(wxWindow* item, int proportion = 0, int flag = 0, int border = 0) /Transfer/;
    wxSizerItem* Add(wxSizer* item,  int proportion = 0, int flag = 0, int border = 0) /Transfer/;

    // TODO: transfer ownership for the return value of this function
    wxSizerItem* Add(SIP_PYTUPLE spacerSize, int proportion = 0, int flag = 0, int border = 0) /Transfer/;
%MethodCode
    SIP_BLOCK_THREADS
    if (PySequence_Fast_GET_SIZE(a0) != 2)
    {
        PyErr_SetString(PyExc_TypeError, "wx.Sizer.Add: first argument size must be 2 integers");
        sipIsErr = 1;
    }
    else
    {
        int w = PyInt_AsLong(PySequence_Fast_GET_ITEM(a0, 0));
        int h = PyInt_AsLong(PySequence_Fast_GET_ITEM(a0, 1));

        if ((w == -1 || h == -1) && PyErr_Occurred())
            sipIsErr = 1;
        else {
            //wxSizerItem* Add(int width, int height, int proportion = 0, int flag = 0, int border = 0, wxObject* userData = NULL)
            sipRes = sipCpp->Add(w, h, a1, a2, a3);
            //sipTransferTo(sipRes, NULL); /*<<TODO: PyObject form of sipCpp should go here!>> */
        }
    }
    SIP_UNBLOCK_THREADS
%End

    wxSizerItem* AddStretchSpacer(int prop = 1) /Transfer/;
    wxSizerItem* AddSpacer(int size) /Transfer/;

    //
    // Insert
    //

    wxSizerItem* Insert(int index, wxWindow* item, int proportion = 0, int flag = 0, int border = 0) /Transfer/;
    wxSizerItem* Insert(int index, wxSizer* item,  int proportion = 0, int flag = 0, int border = 0) /Transfer/;

    wxSizerItem* AddSpacer(SIP_PYTUPLE) /Transfer/;
%MethodCode
    static const char* AddSpacerMsg = "AddSpacer expects an integer or a sequence of 2 integers";

    PyObject* fast = PySequence_Fast(a0, AddSpacerMsg);
    if (fast == NULL) {
        sipIsErr = 1;
    } else {
        if (PySequence_Fast_GET_SIZE(fast) != 2) {
            PyErr_SetString(PyExc_TypeError, AddSpacerMsg);
            sipIsErr = 1;
        }
        else {
            int width  = PyInt_AsLong(PySequence_Fast_GET_ITEM(fast, 0));
            int height = PyInt_AsLong(PySequence_Fast_GET_ITEM(fast, 1));

            if (width == -1 || height == -1 && PyErr_Occurred()) {
                PyErr_SetString(PyExc_TypeError, AddSpacerMsg);
                sipIsErr = 1;
            } else {
                sipRes = sipCpp->Add(width, height, 0);
                //sipTransferTo(sipRes); /* <<TODO: PyObject form of sipCpp should go here!>> */
            }
        }
        Py_DECREF(fast);
    }
%End

    bool Remove(wxWindow* window);
    bool Remove(wxSizer* sizer);
    bool Remove(size_t index);

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

    //wxSizerItemList& GetChildren();

/*
    %extend {
        DocAStr(Show,
                "Show(self, item, bool show=True, bool recursive=false) -> bool",
                "Shows or hides an item managed by the sizer.  To make a sizer item
disappear or reappear, use Show followed by `Layout`.  The *item*
parameter can be either a window, a sizer, or the zero-based index of
the item.  Use the recursive parameter to show or hide an item in a
subsizer.  Returns True if the item was found.", "");
        bool Show(PyObject* item, bool show = true, bool recursive=false) {
            wxPyBlock_t blocked = wxPyBeginBlockThreads();
            wxPySizerItemInfo info = wxPySizerItemTypeHelper(item, false, true);
            wxPyEndBlockThreads(blocked);
            if ( info.window )
                return self->Show(info.window, show, recursive);
            else if ( info.sizer )
                return self->Show(info.sizer, show, recursive);
            else if ( info.gotPos )
                return self->Show(info.pos, show);
            else
                return false;
        }

        DocAStr(IsShown,
                "IsShown(self, item)",
                "Determines if the item is currently shown. To make a sizer
item disappear or reappear, use Show followed by `Layout`.  The *item*
parameter can be either a window, a sizer, or the zero-based index of
the item.", "");
        bool IsShown(PyObject* item) {
            wxPyBlock_t blocked = wxPyBeginBlockThreads();
            wxPySizerItemInfo info = wxPySizerItemTypeHelper(item, false, false);
            wxPyEndBlockThreads(blocked);
            if ( info.window )
                return self->IsShown(info.window);
            else if ( info.sizer )
                return self->IsShown(info.sizer);
            else if ( info.gotPos )
                return self->IsShown(info.pos);
            else
                return false;
        }
    }

    %pythoncode {
    def Hide(self, item, recursive=False):
        """
        A convenience method for `Show` (item, False, recursive).
        """
        return self.Show(item, False, recursive)
    }
*/

    void ShowItems(bool show);

private:
    wxSizer(); // abstract
};

class wxBoxSizer: wxSizer
{
public:
    wxBoxSizer(int orient);
    void RecalcSizes();

    wxSize CalcMin();

    int GetOrientation() const;
    void SetOrientation(int orient);
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
    void RecalcSizes();

    wxStaticBox* GetStaticBox();
private:
    wxStaticBoxSizer(const wxStaticBoxSizer&);
};
