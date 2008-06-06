
class wxGDIObject : wxObject
{
private:
    wxGDIObject();
    wxGDIObject(const wxGDIObject&);

public:
    virtual ~wxGDIObject();
    bool IsNull();
};
