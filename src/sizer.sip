
class wxSizerItem: wxObject {
public:
    wxSizerItem( wxWindow *window,
                 int proportion,
                 int flag,
                 int border,
                 wxObject* userData );

    //wxSizerItem(wxWindow *window, const wxSizerFlags& flags);

    wxSizerItem( wxSizer *sizer,
                 int proportion,
                 int flag,
                 int border,
                 wxObject* userData );

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
    void SetMinSize( int x, int y );
    void SetInitSize( int x, int y );

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

    void SetUserData(wxObject* userData);
    wxObject* GetUserData() const;
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
    
    wxSizerItem* Add(wxWindow*, int proportion = 0, int flag = 0, int border = 0, wxObject* userData = NULL);
    wxSizerItem* Add(wxSizer*, int proportion = 0, int flag = 0, int border = 0, wxObject* userData = NULL);
    wxSizerItem* Add(SIP_PYTUPLE spacerSize, int proportion = 0, int flag = 0, int border = 0, wxObject* userData = NULL);
%MethodCode
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
        {
            sipIsErr = 1;
        }
        else
        {
            //wxSizerItem* Add(int width, int height, int proportion = 0, int flag = 0, int border = 0, wxObject* userData = NULL)
            sipRes = sipCpp->Add(w, h, a1, a2, a3, a4);
        }
    }
%End

    wxSizerItem* AddSpacer(int size);
    
    wxSizerItem* AddSpacer(SIP_PYTUPLE);
%MethodCode
    static const char* AddSpacerMsg = "AddSpacer expects an integer or a sequence of 2 integers";

    PyObject* fast = PySequence_Fast(a0, AddSpacerMsg);
    if (fast == NULL)
    {
        sipIsErr = 1;
    }
    else
    {
        if (PySequence_Fast_GET_SIZE(fast) != 2)
        {
            PyErr_SetString(PyExc_TypeError, AddSpacerMsg);
            sipIsErr = 1;
        }
        else
        {            
            int width  = PyInt_AsLong(PySequence_Fast_GET_ITEM(fast, 0));
            int height = PyInt_AsLong(PySequence_Fast_GET_ITEM(fast, 1));
            if (width == -1 || height == -1 && PyErr_Occurred())
            {
                PyErr_SetString(PyExc_TypeError, AddSpacerMsg);
                sipIsErr = 1;
            }
            else
            {                
                sipRes = sipCpp->Add(width, height, 0);
            }
        }
        Py_DECREF(fast);
    }     
%End
    
    wxSizerItem* AddStretchSpacer(int prop = 1);
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
    wxSize Fit( wxWindow *window );
    void FitInside( wxWindow *window );
    void SetSizeHints( wxWindow *window );
    void SetVirtualSizeHints( wxWindow *window );
    void Clear( bool deleteWindows=false );
    void DeleteWindows();
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


class wxFlexGridSizer : wxSizer
{
public:
    wxFlexGridSizer(int rows, int cols, int vgap, int hgap);
private:
    wxFlexGridSizer(const wxFlexGridSizer&);
};