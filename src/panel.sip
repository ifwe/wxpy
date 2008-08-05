class wxPanel : wxWindow
{
public:
    wxPanel(wxWindow* parent /TransferThis/,
            const wxWindowID id = -1,
            const wxPoint& pos = wxDefaultPosition,
            const wxSize& size = wxDefaultSize,
            long style = wxTAB_TRAVERSAL | wxNO_BORDER,
            const wxString& name = wxPanelNameStr);
    virtual ~wxPanel();


    void InitDialog();

    void SetFocus();
    void SetFocusIgnoringChildren();
};

class wxScrolledWindow : wxPanel
{
public:
    wxScrolledWindow(wxWindow* parent /TransferThis/,
                     const wxWindowID id = -1,
                     const wxPoint& pos = wxDefaultPosition,
                     const wxSize& size = wxDefaultSize,
                     long style = wxHSCROLL | wxVSCROLL,
                     const wxString& name = wxPanelNameStr);
    virtual ~wxScrolledWindow();


    void SetScrollbars(int pixelsPerUnitX, int pixelsPerUnitY,
                               int noUnitsX, int noUnitsY,
                               int xPos = 0, int yPos = 0,
                               bool noRefresh = false );

    void Scroll(int x, int y);

    int GetScrollPageSize(int orient) const;
    void SetScrollPageSize(int orient, int pageSize);
    void SetScrollRate(int xstep, int ystep);
    void GetScrollPixelsPerUnit(int *x, int *y) const;
    void EnableScrolling(bool x_scrolling, bool y_scrolling);

    wxPoint GetViewStart() const;
%MethodCode
        int x = 0, y = 0;
        sipCpp->GetViewStart(&x, &y);
        sipRes = new wxPoint(x, y);
%End

    //void GetViewStart(int *x, int *y) const;
    void SetScale(double xs, double ys);
    double GetScaleX() const;
    double GetScaleY() const;
    wxPoint CalcScrolledPosition(const wxPoint& pt) const;
    wxPoint CalcUnscrolledPosition(const wxPoint& pt) const;
    void AdjustScrollbars();
    int CalcScrollInc(wxScrollWinEvent& event);
    void SetTargetWindow(wxWindow *target);
    wxWindow *GetTargetWindow() const;
};

%ModuleHeaderCode

typedef wxWindow wxPyWindow;
typedef wxPanel wxPyPanel;

%End

class wxPyWindow : wxWindow
{
public:
    wxPyWindow();
    wxPyWindow(wxWindow* parent, const wxWindowID id,
               const wxPoint& pos = wxDefaultPosition,
               const wxSize& size = wxDefaultSize,
               long style = 0,
               const wxString& name = wxPanelNameStr);
        //: wxWindow(parent, id, pos, size, style, name) {}
//
//
//    bool DoEraseBackground(wxDC* dc) {
//#ifdef __WXMSW__
//        return wxWindow::DoEraseBackground(dc->GetHDC());
//#else
//        dc->SetBackground(wxBrush(GetBackgroundColour()));
//        dc->Clear();
//        return true;
//#endif
//    }

protected:
    virtual void DoMoveWindow(int x, int y, int width, int height);
    virtual void DoSetSize(int x, int y, int width, int height, int sizeFlags);
    virtual void DoSetClientSize(int width, int height);
    virtual void DoSetVirtualSize(int x, int y);

    virtual void DoGetSize(int* x, int* y);
    virtual void DoGetClientSize(int *x, int* y);
    virtual void DoGetPosition(int* x, int* y);
    virtual wxPoint GetClientAreaOrigin() const;

    virtual wxSize DoGetVirtualSize() const;
    virtual wxSize DoGetBestSize() const;

public:

    virtual void InitDialog();
    virtual bool TransferDataFromWindow();
    virtual bool TransferDataToWindow();
    virtual bool Validate();

    virtual bool AcceptsFocus() const;
    virtual bool AcceptsFocusFromKeyboard() const;
    virtual wxSize GetMaxSize() const;

    virtual void AddChild(wxWindowBase* child);
    virtual void RemoveChild(wxWindowBase* child);

    virtual bool ShouldInheritColours() const;
    //DEC_PYCALLBACK_VIZATTR_(GetDefaultAttributes);

    virtual bool HasTransparentBackground();

    virtual void OnInternalIdle();
};

class wxPyPanel : wxPanel
{
public:
    wxPyPanel(wxWindow* parent, const wxWindowID id,
               const wxPoint& pos = wxDefaultPosition,
               const wxSize& size = wxDefaultSize,
               long style = wxTAB_TRAVERSAL | wxNO_BORDER,
               const wxString& name = wxPanelNameStr);

//    bool DoEraseBackground(wxDC* dc) {
//#ifdef __WXMSW__
//        return wxWindow::DoEraseBackground(dc->GetHDC());
//#else
//        dc->SetBackground(wxBrush(GetBackgroundColour()));
//        dc->Clear();
//        return true;
//#endif
//    }

protected:
    virtual void DoMoveWindow(int x, int y, int width, int height);
    virtual void DoSetSize(int x, int y, int width, int height, int sizeFlags);
    virtual void DoSetClientSize(int width, int height);
    virtual void DoSetVirtualSize(int x, int y);

    virtual void DoGetSize(int* x, int* y);
    virtual void DoGetClientSize(int *x, int* y);
    virtual void DoGetPosition(int* x, int* y);
    virtual wxPoint GetClientAreaOrigin() const;

    virtual wxSize DoGetVirtualSize() const;
    virtual wxSize DoGetBestSize() const;

public:
    virtual void InitDialog();
    virtual bool TransferDataFromWindow();
    virtual bool TransferDataToWindow();
    virtual bool Validate();

    virtual bool AcceptsFocus() const;
    virtual bool AcceptsFocusFromKeyboard() const;
    virtual wxSize GetMaxSize() const;

    virtual void AddChild(wxWindowBase* child);
    virtual void RemoveChild(wxWindowBase* child);

    virtual bool ShouldInheritColours() const;
    //DEC_PYCALLBACK_VIZATTR_(GetDefaultAttributes);

    virtual bool HasTransparentBackground();
    virtual void OnInternalIdle();
};

