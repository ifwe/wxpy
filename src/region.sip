enum wxRegionContain
{
    wxOutRegion = 0,
    wxPartRegion = 1,
    wxInRegion = 2
};

wxRegion RegionFromBitmap(const wxBitmap& bitmap);
%MethodCode
    sipRes = new wxRegion(*a0);
%End

class wxRegion
{
private:
    wxRegion(const wxRegion&);
public:
    wxRegion(wxCoord x=0, wxCoord y=0, wxCoord width=0, wxCoord height=0);
    wxRegion(const wxRect& rect) /PyName=RegionFromRect/;
    virtual ~wxRegion();

    bool Ok() const;
    bool IsOk() const;

    bool IsEmpty() const;
    bool Empty() const;
    bool IsEqual(const wxRegion& region) const;

    wxRect GetBox() const;

    // Test if the given point or rectangle is inside this region
    wxRegionContain Contains(wxCoord x, wxCoord y) const;
    wxRegionContain Contains(const wxPoint& pt) const /PyName=ContainsPoint/;
    wxRegionContain Contains(const wxRect& rect) const /PyName=ContainsRect/;

    void Clear();

    bool Offset(wxCoord x, wxCoord y);

    bool Union(const wxRect& rect) /PyName=UnionRect/;
    bool Union(const wxRegion& region);

%If (wxUSE_IMAGE)
    bool Union(const wxBitmap& bmp);
    bool Union(const wxBitmap& bmp, const wxColour& transp, int tolerance = 0);
%End

    bool Intersect(wxCoord x, wxCoord y, wxCoord w, wxCoord h);
    bool Intersect(const wxRect& rect) /PyName=IntersectRect/;
    bool Intersect(const wxRegion& region) /PyName=IntersectRegion/;

    bool Subtract(wxCoord x, wxCoord y, wxCoord w, wxCoord h);
    bool Subtract(const wxRect& rect) /PyName=SubtractRect/;
    bool Subtract(const wxRegion& region) /PyName=SubtractRegion/;

    bool Xor(wxCoord x, wxCoord y, wxCoord w, wxCoord h);
    bool Xor(const wxRect& rect) /PyName=XorRect/;
    bool Xor(const wxRegion& region) /PyName=XorRegion/;

    wxBitmap ConvertToBitmap() const;
};
