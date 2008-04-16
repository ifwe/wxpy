enum {
    wxIMAGE_ALPHA_TRANSPARENT,
    wxIMAGE_ALPHA_THRESHOLD,
    wxIMAGE_ALPHA_OPAQUE
};

enum
{
    wxIMAGE_QUALITY_NORMAL = 0,
    wxIMAGE_QUALITY_HIGH = 1
};

wxImage ImageFromBitmap(const wxBitmap& bitmap);
%MethodCode
    sipRes = new wxImage(a0->ConvertToImage());
%End

wxImage ImageFromDataWithAlpha(int width, 
                               int height,
                               SIP_PYOBJECT buffer,
                               int DATASIZE,
                               SIP_PYOBJECT buffer,
                               int ALPHASIZE);
%MethodCode
    fprintf(stderr, "NOT IMPLEMENTED: ImageFromDataWithAlpha\n");
    sipRes = new wxImage(a0, a1);
%End

class wxImage: wxObject
{
public:
    // from file
    wxImage(const wxString& name, long type = wxBITMAP_TYPE_ANY, int index = -1);

    wxImage Scale(int width, int height, int quality = wxIMAGE_QUALITY_NORMAL);
    wxImage& Rescale(int width, int height, int quality = wxIMAGE_QUALITY_NORMAL);

    ~wxImage();
};