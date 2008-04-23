wxIcon IconFromBitmap(const wxBitmap& bitmap);
%MethodCode
    sipRes = new wxIcon();
    sipRes->CopyFromBitmap(*a0);
%End

class wxIcon: wxGDIObject
{
public:
    wxIcon();
    ~wxIcon();
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
    ~wxIconBundle();
    void AddIcon(const wxIcon& icon);
    void AddIcon(const wxString& file, long type) /PyName=AddIconFromFile/;
    const wxIcon& GetIcon( const wxSize& size ) const;
};
