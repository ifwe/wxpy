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
    wxRegion(wxCoord x=0, wxCoord y=0, wxCoord width=0, wxCoord height=0);
    virtual ~wxRegion();
};
