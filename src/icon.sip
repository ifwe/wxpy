wxIcon IconFromBitmap(const wxBitmap& bitmap);
%MethodCode
    sipRes = new wxIcon();
    sipRes->CopyFromBitmap(*a0);
%End

wxIcon IconFromFile(const wxString& name, wxBitmapType type = wxBITMAP_TYPE_ANY, int desiredWidth = -1, int desiredHeight = -1);
%MethodCode
    sipRes = new wxIcon(*a0, a1, a2, a3);
%End

class wxIcon: wxGDIObject
{
public:
    wxIcon();
    virtual ~wxIcon();

    int GetHeight() const;
    int GetWidth() const;
    int GetDepth() const;
    bool IsOk() const;
};


wxIconBundle IconBundleFromFile(const wxString& file, long type);
%MethodCode
    sipRes = new wxIconBundle(*a0, a1);
%End

wxIconBundle IconBundleFromIcon(const wxIcon& icon);
%MethodCode
    sipRes = new wxIconBundle(*a0);
%End

class wxIconBundle
{
public:
    wxIconBundle();
    virtual ~wxIconBundle();

    void AddIcon(const wxIcon& icon);
    void AddIcon(const wxString& file, long type) /PyName=AddIconFromFile/;
    const wxIcon& GetIcon(const wxSize& size) const;
};
