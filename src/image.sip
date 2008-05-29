%ModuleHeaderCode
#include <wx/mstream.h>
%End

void wxInitAllImageHandlers();

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

wxImage ImageFromString(SIP_PYOBJECT);
%MethodCode
    if (!PyString_Check(a0))
    {
        PyErr_SetString(PyExc_TypeError, "str object expected");
        sipIsErr = 1;
    }
    else
    {
        wxMemoryInputStream inpStream(PyString_AS_STRING(a0), PyString_GET_SIZE(a0));
        sipRes = new wxImage(inpStream);
    }
%End


wxImage ImageFromBitmap(const wxBitmap& bitmap);
%MethodCode
    sipRes = new wxImage(a0->ConvertToImage());
%End

wxImage* EmptyImage(int width = 0, int height = 0, bool clear = true);
%MethodCode
    if (a0 > 0 && a1 > 0)
        sipRes = new wxImage(a0, a1, a2);
    else
        sipRes = new wxImage;
%End


wxImage ImageFromDataWithAlpha(int width,
                               int height,
                               SIP_PYOBJECT rgb,
                               SIP_PYOBJECT alpha);
%MethodCode
    int width = a0;
    int height = a1;
    PyObject* rgb = a2;
    PyObject* alpha = a3;

    if (!PyString_Check(rgb) || !PyString_Check(alpha))
    {
        PyErr_SetString(PyExc_TypeError, "rgb and alpha must be a strings with image data");
        goto err;
    }

    int DATASIZE  = PyString_GET_SIZE(rgb);
    int ALPHASIZE = PyString_GET_SIZE(alpha);

    if (DATASIZE != width * height * 3)
    {
        PyErr_SetString(PyExc_ValueError, "Invalid data buffer size.");
        goto err;
    }
    else if (ALPHASIZE != width*height)
    {
        PyErr_SetString(PyExc_ValueError, "Invalid alpha buffer size.");
        goto err;
    }

    // Copy the source data so the wxImage can clean it up later
    unsigned char* dcopy = (unsigned char*)sipMalloc(DATASIZE);
    if (dcopy == NULL)
    {
        PyErr_NoMemory();
        goto err;
    }
    memcpy(dcopy, PyString_AsString(rgb), DATASIZE);

    unsigned char* acopy = (unsigned char*)malloc(ALPHASIZE);
    if (acopy == NULL)
    {
        PyErr_NoMemory();
        goto err;
    }
    memcpy(acopy, PyString_AsString(alpha), ALPHASIZE);

    sipRes = new wxImage(width, height, dcopy, acopy, false);
    goto done;
err:
    sipIsErr = 1;
done:

%End

class wxImage: wxObject
{
public:

    SIP_PYOBJECT GetData();
%MethodCode
        unsigned char* data = sipCpp->GetData();
        int len = sipCpp->GetWidth() * sipCpp->GetHeight() * 3;
        sipRes = PyString_FromStringAndSize((char*)data, len);
%End

    SIP_PYOBJECT GetAlphaData();
%MethodCode
        unsigned char* data = sipCpp->GetAlpha();
        if (data == NULL)
            Py_RETURN_NONE;

        int len = sipCpp->GetWidth() * sipCpp->GetHeight();
        sipRes = PyString_FromStringAndSize((char*)data, len);
%End

    // from file
    wxImage(const wxString& name, long type = wxBITMAP_TYPE_ANY, int index = -1);

    wxImage Scale( int width, int height, int quality = wxIMAGE_QUALITY_NORMAL );
    wxImage ResampleBox(int width, int height) const;
    wxImage ResampleBicubic(int width, int height) const;
    wxImage Blur(int radius);
    wxImage BlurHorizontal(int radius);
    wxImage BlurVertical(int radius);
    wxImage ShrinkBy( int xFactor , int yFactor ) const ;
    wxImage& Rescale(int width, int height, int quality = wxIMAGE_QUALITY_NORMAL);
    wxImage& Resize( const wxSize& size, const wxPoint& pos, int r = -1, int g = -1, int b = -1 );
    void SetRGB( int x, int y, byte r, byte g, byte b );
    byte GetRed( int x, int y );
    byte GetGreen( int x, int y );
    byte GetBlue( int x, int y );
    void SetAlpha(int x, int y, byte alpha);
    byte GetAlpha(int x, int y);
    bool HasAlpha();
    void InitAlpha();
    bool IsTransparent(int x, int y, byte threshold = wxIMAGE_ALPHA_THRESHOLD) const;
//  bool FindFirstUnusedColour( byte *OUTPUT, byte *OUTPUT, byte *OUTPUT,
//                                 byte startR = 0, byte startG = 0, byte startB = 0 ) const;
    bool ConvertAlphaToMask(byte threshold = wxIMAGE_ALPHA_THRESHOLD);
    bool ConvertColourToAlpha( byte r, byte g, byte b );
    bool SetMaskFromImage(const wxImage & mask, byte mr, byte mg, byte mb);
    static bool CanRead( const wxString& filename );
    static int GetImageCount( const wxString& filename, long type = wxBITMAP_TYPE_ANY );
    bool LoadFile( const wxString& name, long type = wxBITMAP_TYPE_ANY, int index = -1 );
    bool LoadFile( const wxString& name, const wxString& mimetype, int index = -1 );
    bool SaveFile( const wxString& name, int type );
    bool SaveFile( const wxString& name, const wxString& mimetype );
//  bool SaveFile( wxOutputStream& stream, int type );
//  bool SaveFile( wxOutputStream& stream, const wxString& mimetype );
//  static bool CanRead( wxInputStream& stream );
//  bool LoadFile( wxInputStream& stream, long type = wxBITMAP_TYPE_ANY, int index = -1 );
//  bool LoadFile( wxInputStream& stream, const wxString& mimetype, int index = -1 );
    bool IsOk();
    int GetWidth();
    int GetHeight();

    wxSize GetSize() const;
%MethodCode
    sipRes = new wxSize(sipCpp->GetWidth(), sipCpp->GetHeight());
%End

    wxImage GetSubImage(const wxRect& rect);
    wxImage Size(const wxSize& size, const wxPoint& pos,
        int r = -1, int g = -1, int b = -1 ) const;
    wxImage Copy();
    void Paste( const wxImage &image, int x, int y );
    void SetMaskColour( byte r, byte g, byte b );
    byte GetMaskRed();
    byte GetMaskGreen();
    byte GetMaskBlue();
    void SetMask( bool mask = true );
    bool HasMask();
    wxImage Rotate(double angle, const wxPoint & centre_of_rotation, bool interpolating = true, wxPoint * offset_after_rotation = NULL) const ;
    wxImage Rotate90( bool clockwise = true ) ;
    wxImage Mirror( bool horizontally = true ) ;
    void Replace( byte r1, byte g1, byte b1, byte r2, byte g2, byte b2 );
    wxImage ConvertToGreyscale( double lr = 0.299, double lg = 0.587, double lb = 0.114 ) const;
    wxImage ConvertToMono( byte r, byte g, byte b ) const;
    void SetOption(const wxString& name, const wxString& value);
    void SetOption(const wxString& name, int value);
    wxString GetOption(const wxString& name) const;
    int GetOptionInt(const wxString& name) const;
    bool HasOption(const wxString& name) const;
    unsigned long CountColours( unsigned long stopafter = -1 );
//  unsigned long ComputeHistogram( wxImageHistogram& h );

//  static void AddHandler( wxImageHandler *handler );
//  static void InsertHandler( wxImageHandler *handler );
    static bool RemoveHandler( const wxString& name );

    static wxString GetImageExtWildcard();

    void RotateHue(double angle);
    //static wxImage_HSVValue , RGBtoHSV(wxImage_RGBValue rgb);
    //static wxImage_RGBValue , HSVtoRGB(wxImage_HSVValue hsv);

    int __nonzero__();
%MethodCode
    sipRes = sipCpp->IsOk();
%End

    ~wxImage();
};
