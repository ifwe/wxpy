typedef int wxBitmapType;

class wxMask : wxObject
{
private:
    wxMask(const wxMask&);
    wxMask();

public:
    wxMask(const wxBitmap& bitmap, const wxColour& colour = wxNullColour);
    virtual ~wxMask();
};

wxBitmap wxBitmapFromIcon(const wxIcon& icon);
%MethodCode
    sipRes = new wxBitmap(*a0);
%End

wxBitmap wxBitmapFromImage(const wxImage& image, int depth = -1);
%MethodCode
    if (!a0->Ok())
    {
        PyErr_SetString(PyExc_AssertionError, "wxImage.Ok() must be True");
        sipIsErr = 1;
    }
    else
        sipRes = new wxBitmap(*a0);
%End

wxBitmap wxTransparentBitmap(int w, int h);
%MethodCode
    sipRes = new wxBitmap(a0, a1, 32);
    sipRes->UseAlpha();
%End



wxBitmap wxEmptyBitmap(int width, int height);
%MethodCode
    sipRes = new wxBitmap(a0, a1);
    sipRes->UseAlpha();
%End

class wxBitmap : wxGDIObject
{
private:
    wxBitmap();
    wxBitmap(const wxBitmap&);

public:
    wxBitmap(const wxString& filename, long type = wxBITMAP_TYPE_ANY);

    virtual ~wxBitmap();

    bool IsOk();
    bool Ok();
%MethodCode
        sipRes = sipCpp->IsOk();
%End
    int __nonzero__();
%MethodCode
    sipRes = (int)sipCpp->IsOk();
%End

    int GetWidth();
    int GetHeight();


    wxSize GetSize();
%MethodCode
    sipRes = new wxSize(sipCpp->GetWidth(), sipCpp->GetHeight());
%End



    int GetDepth();
    // wxSize GetSize();

    wxImage ConvertToImage() const;
    wxMask* GetMask() const;
    void SetMask(wxMask* mask /Transfer/);
    void SetMaskColour(const wxColour& color);
%MethodCode
        wxMask *mask = new wxMask(*sipCpp, *a0);
        sipCpp->SetMask(mask);
%End

    wxBitmap GetSubBitmap(const wxRect& rect) const;
//  bool SaveFile(const wxString& name, wxBitmapType type, wxPalette* palette = NULL);
//  bool LoadFile(const wxString& name, wxBitmapType type);

    wxPalette* GetPalette() const;

    bool CopyFromIcon(const wxIcon& icon);

    void SetHeight(int height);
    void SetWidth(int width);
    void SetDepth(int depth);

    bool HasAlpha() const;
    void UseAlpha();

    // non zero
};