class wxPanel : wxWindow
{
public:
    wxPanel(wxWindow* parent /TransferThis/,
            const wxWindowID id = -1,
            const wxPoint& pos = wxDefaultPosition,
            const wxSize& size = wxDefaultSize,
            long style = wxTAB_TRAVERSAL | wxNO_BORDER,
            const wxString& name = wxPanelNameStr);

    void InitDialog();

    void SetFocus();
    void SetFocusIgnoringChildren();
};

class wxScrolledWindow : wxPanel
{
public:
    wxScrolledWindow(wxWindow* parent,
                     const wxWindowID id = -1,
                     const wxPoint& pos = wxDefaultPosition,
                     const wxSize& size = wxDefaultSize,
                     long style = wxHSCROLL | wxVSCROLL,
                     const wxString& name = wxPanelNameStr);

    void SetScrollbars(int pixelsPerUnitX, int pixelsPerUnitY,
                               int noUnitsX, int noUnitsY,
                               int xPos = 0, int yPos = 0,
                               bool noRefresh = false );

    void Scroll(int x, int y);

    int GetScrollPageSize(int orient) const;
    void SetScrollPageSize(int orient, int pageSize);
    void SetScrollRate( int xstep, int ystep );
    void GetScrollPixelsPerUnit(int *x, int *y) const;
    void EnableScrolling(bool x_scrolling, bool y_scrolling);
    void GetViewStart(int *x, int *y) const;
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

