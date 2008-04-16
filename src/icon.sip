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