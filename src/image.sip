
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