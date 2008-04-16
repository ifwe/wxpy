
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

    wxSizerItem* AddSpacer(int size);
    wxSizerItem* AddStretchSpacer(int prop = 1);
    
    void RecalcSizes() = 0;

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