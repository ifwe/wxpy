typedef int wxBitmapType;

class wxMask : wxObject
{
public:
    wxMask(const wxBitmap& bitmap, const wxColour& colour = wxNullColour);
    ~wxMask();
};

wxBitmap wxBitmapFromIcon(const wxIcon& icon);
%MethodCode
    sipRes = new wxBitmap(*a0);
%End

wxBitmap wxBitmapFromImage(const wxImage& image, int depth = -1);
%MethodCode
    sipRes = new wxBitmap(*a0, a1);
%End

class wxBitmap : wxGDIObject
{
public:
    wxBitmap();
    //wxBitmap(const wxIcon& icon) /PyName=BitmapFromIcon/;
    //wxBitmap(const wxImage& image, int depth = -1) /PyName=BitmapFromImage/;
    
    bool IsOk();
    int GetWidth();
    int GetHeight();
    int GetDepth();
    // wxSize GetSize();
    
    wxImage ConvertToImage() const;
    wxMask* GetMask() const;
    void SetMask(wxMask* mask /TransferBack/);
    
    wxBitmap GetSubBitmap(const wxRect& rect) const;
//    bool SaveFile(const wxString& name, wxBitmapType type, wxPalette* palette = NULL);
//    bool LoadFile(const wxString& name, wxBitmapType type);
    
    wxPalette* GetPalette() const;
    
    bool CopyFromIcon(const wxIcon& icon);
    
    void SetHeight(int height);
    void SetWidth(int width);
    void SetDepth(int depth);
    
    bool HasAlpha() const;
    void UseAlpha();
    
    // non zero
    
    
    
    
    ~wxBitmap();
};