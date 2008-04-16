//
// gdicmn.sip
//

class wxPoint
{

%TypeHeaderCode
#include <wx/gdicmn.h>
%End

public:
	wxPoint(int x = 0, int y = 0);
    ~wxPoint();

%ConvertToTypeCode
    if (!sipIsErr) {
        return sequence_2_ints_check(sipPy)
            || sipCanConvertToInstance(sipPy, sipClass_wxPoint, SIP_NO_CONVERTORS);
    }

    int _x, _y;
    if (sequence_2_ints(sipPy, &_x, &_y)) {
        *sipCppPtr = new wxPoint(_x, _y);
        return sipGetState(sipTransferObj);
    }

    *sipCppPtr = reinterpret_cast<wxPoint *>(sipConvertToInstance(sipPy, sipClass_wxPoint, sipTransferObj, SIP_NO_CONVERTORS, 0, sipIsErr));
    return 0;
%End

    int __getitem__(int i);
%MethodCode
    if (a0 == 0) sipRes = sipCpp->x;
    else if (a0 == 1) sipRes = sipCpp->y;
    else PyErr_SetString(PyExc_ValueError, "index out of range");
%End

    void __setitem__(int i, int val);
%MethodCode
    if (a0 == 0) sipCpp->x = a1;
    else if (a0 == 1) sipCpp->y = a1;
    else PyErr_SetString(PyExc_ValueError, "index out of range");
%End

    int __len__();
%MethodCode
    return 2;
%End


    SIP_PYOBJECT __repr__();
%MethodCode
    sipRes = PyString_FromFormat("<wx.Point (%d, %d)>", sipCpp->x, sipCpp->y);
%End
    /*
    bool operator==(const wxPoint&, const wxPoint&);
%MethodCode
    if (sipCanConvertToInstance(a0, sipClass_wxPoint, SIP_NOT_NONE) &&
        sipCanConvertToInstance(a1, sipClass_wxPoint, SIP_NOT_NONE)))
    {
        int state;
        int err;
        wxPoint* p0 = reinterpret_cast<wxPoint*>(sipConvertToInstance(a0, sipClass_wxPoint, NULL, SIP_NOT_NONE, &state, &err));
        wxPoint* p1 = reinterpret_cast<wxPoint*>(sipConvertToInstance(a1, sipClass_wxPoint, NULL, SIP_NOT_NONE, &state, &err));
            
        if (p0->x == p1->x)
            sipRes = PyInt_FromLong(1);
    }
    
    sipRes = PyInt_FromLong(0);
%End
*/
    
    bool operator==(const wxPoint&);
    //bool operator!=(const wxPoint &);
    wxPoint operator+(const wxPoint& pt);
    wxPoint operator-(const wxPoint& pt);
    wxPoint& operator+=(const wxPoint& pt);
    wxPoint& operator-=(const wxPoint& pt);

	int x;
	int y;
};

class wxSize
{
%TypeHeaderCode
#include <wx/gdicmn.h>
%End
    
public:
	wxSize();
    wxSize(int width, int height);
    ~wxSize();

    wxSize operator+(const wxSize&);
    wxSize operator-(const wxSize&);
    bool operator==(const wxSize &);
    bool operator!=(const wxSize &);

    void IncTo(const wxSize& sz);
    void DecTo(const wxSize& sz);
    void IncBy(int dx, int dy);
    void DecBy(int dx, int dy);
    bool IsFullySpecified() const;
    void SetDefaults(const wxSize&);

// Convert from tuples of two integers
%ConvertToTypeCode
    if (!sipIsErr)
    {
        int val = sequence_2_ints_check(sipPy)
            || sipCanConvertToInstance(sipPy, sipClass_wxSize, SIP_NO_CONVERTORS);
        printf("type checking conversion for wxSize: %d\n", val);
        return val;
    }

    int _x, _y;
    if (sequence_2_ints(sipPy, &_x, &_y)) {
    	printf("returning new size from 2 ints: %d, %d\n", _x, _y);
        *sipCppPtr = new wxSize(_x, _y);
        return sipGetState(sipTransferObj);
    }

    *sipCppPtr = reinterpret_cast<wxSize *>(sipConvertToInstance(sipPy, sipClass_wxSize, sipTransferObj, SIP_NO_CONVERTORS, 0, sipIsErr));
    return 0;
%End

    int __len__();
%MethodCode
    return 2;
%End

    SIP_PYOBJECT __repr__();
%MethodCode
    sipRes = PyString_FromFormat("<wx.Size (%d, %d)>", sipCpp->x, sipCpp->y);
%End

    int x;
    int y;
};


wxRect RectPS(const wxPoint& topLeft, const wxPoint& bottomRight);
%MethodCode
    sipRes = new wxRect(*a0, *a1);
%End

    wxRect RectS(const wxSize& size);
%MethodCode
    sipRes = new wxRect(*a0);
%End


class wxRect
{

%TypeHeaderCode
#include <wx/gdicmn.h>
%End

public:
	wxRect(int x=0, int y=0, int width=0, int height=0);
	wxRect(const wxPoint& topLeft, const wxPoint& bottomRight);
    
    ~wxRect();



    int GetX() const;
    void SetX(int x);

    int GetY();
    void SetY(int y);

    int GetWidth() const;
    void SetWidth(int w);

    int GetHeight() const;
    void SetHeight(int h);

    wxPoint GetPosition() const;
    void SetPosition( const wxPoint &p );

    wxSize GetSize() const;
    void SetSize( const wxSize &s );

    bool IsEmpty() const;
    
    wxPoint GetTopLeft() const;
    void SetTopLeft(const wxPoint &p);
    wxPoint GetBottomRight() const;
    void SetBottomRight(const wxPoint &p);

    wxPoint GetTopRight() const;
    void SetTopRight(const wxPoint &p);
    wxPoint GetBottomLeft() const;
    void SetBottomLeft(const wxPoint &p);


    int GetLeft()   const;
    int GetTop()    const;
    int GetBottom() const;
    int GetRight()  const;

    void SetLeft(int left);
    void SetRight(int right);
    void SetTop(int top);
    void SetBottom(int bottom);

    SIP_PYOBJECT __repr__();
%MethodCode
    sipRes = PyString_FromFormat("<wx.Rect (%d, %d, %d, %d)>", 
                sipCpp->x, sipCpp->y, sipCpp->width, sipCpp->height);
%End

    int __len__();
%MethodCode
    return 4;
%End

    int x;
    int y;
    int width;
    int height;
};


class wxPen: wxGDIObject
{
public:
    wxPen();
    ~wxPen();
};

class wxBrush: wxGDIObject
{
public:
    wxBrush();
    wxBrush(const wxColour&);
    ~wxBrush();
    
    void SetColour(const wxColour& color);
    wxColour& GetColour() const;
};



enum wxBitmapType
{
    wxBITMAP_TYPE_INVALID,          // should be == 0 for compatibility!
    wxBITMAP_TYPE_BMP,
    wxBITMAP_TYPE_ICO,
    wxBITMAP_TYPE_CUR,
    wxBITMAP_TYPE_XBM,
    wxBITMAP_TYPE_XBM_DATA,
    wxBITMAP_TYPE_XPM,
    wxBITMAP_TYPE_XPM_DATA,
    wxBITMAP_TYPE_TIF,
    wxBITMAP_TYPE_GIF,
    wxBITMAP_TYPE_PNG,
    wxBITMAP_TYPE_JPEG,
    wxBITMAP_TYPE_PNM,
    wxBITMAP_TYPE_PCX,
    wxBITMAP_TYPE_PICT,
    wxBITMAP_TYPE_ICON,
    wxBITMAP_TYPE_ANI,
    wxBITMAP_TYPE_IFF,
    wxBITMAP_TYPE_TGA,
    wxBITMAP_TYPE_MACCURSOR,

//    wxBITMAP_TYPE_BMP_RESOURCE,
//    wxBITMAP_TYPE_RESOURCE = wxBITMAP_TYPE_BMP_RESOURCE,
//    wxBITMAP_TYPE_ICO_RESOURCE,
//    wxBITMAP_TYPE_CUR_RESOURCE,
//    wxBITMAP_TYPE_TIF_RESOURCE,
//    wxBITMAP_TYPE_GIF_RESOURCE,
//    wxBITMAP_TYPE_PNG_RESOURCE,
//    wxBITMAP_TYPE_JPEG_RESOURCE,
//    wxBITMAP_TYPE_PNM_RESOURCE,
//    wxBITMAP_TYPE_PCX_RESOURCE,
//    wxBITMAP_TYPE_PICT_RESOURCE,
//    wxBITMAP_TYPE_ICON_RESOURCE,
//    wxBITMAP_TYPE_MACCURSOR_RESOURCE,

    wxBITMAP_TYPE_ANY = 50
};

class wxPoint2D
{
public:
    wxPoint2D( double x=0.0 , double y=0.0 );
    wxPoint2D( const wxPoint2D &pt );
    wxPoint2D( const wxPoint &pt );
    ~wxPoint2D();
    void GetFloor( int *x , int *y ) const;
    void GetRounded( int *x , int *y ) const;
    double GetVectorLength() const;
    double GetVectorAngle() const ;
    void SetVectorLength( double length );
    void SetVectorAngle( double degrees );

    // LinkError: void SetPolarCoordinates( double angle , double length );
    // LinkError: void Normalize();
/*    %pythoncode {
    def SetPolarCoordinates(self, angle, length):
        self.SetVectorLength(length)
        self.SetVectorAngle(angle)
    def Normalize(self):
        self.SetVectorLength(1.0)
    }
*/
    double GetDistance( const wxPoint2D &pt ) const;
    double GetDistanceSquare( const wxPoint2D &pt ) const;
    double GetDotProduct( const wxPoint2D &vec ) const;
    double GetCrossProduct( const wxPoint2D &vec ) const;

    wxPoint2D operator-();

    wxPoint2D& operator+=(const wxPoint2D& pt);
    wxPoint2D& operator-=(const wxPoint2D& pt);

    wxPoint2D& operator*=(const wxPoint2D& pt);
    wxPoint2D& operator/=(const wxPoint2D& pt);
};


enum wxOutCode
{
    wxInside = 0x00 ,
    wxOutLeft = 0x01 ,
    wxOutRight = 0x02 ,
    wxOutTop = 0x08 ,
    wxOutBottom = 0x04
};


class wxRect2D
{
public:
    wxRect2D(wxDouble x=0.0, wxDouble y=0.0, wxDouble w=0.0, wxDouble h=0.0);
    ~wxRect2D();

    wxPoint2D GetPosition();
    wxSize GetSize();

    wxDouble GetLeft() const;
    void SetLeft( wxDouble n );
    void MoveLeftTo( wxDouble n );
    wxDouble GetTop() const;
    void SetTop( wxDouble n );
    void MoveTopTo( wxDouble n );
    wxDouble GetBottom() const;
    void SetBottom( wxDouble n );
    void MoveBottomTo( wxDouble n );
    wxDouble GetRight() const;
    void SetRight( wxDouble n );
    void MoveRightTo( wxDouble n );

    wxPoint2D GetLeftTop() const;
    void SetLeftTop( const wxPoint2D &pt );
    void MoveLeftTopTo( const wxPoint2D &pt );
    wxPoint2D GetLeftBottom() const;
    void SetLeftBottom( const wxPoint2D &pt );
    void MoveLeftBottomTo( const wxPoint2D &pt );
    wxPoint2D GetRightTop() const;
    void SetRightTop( const wxPoint2D &pt );
    void MoveRightTopTo( const wxPoint2D &pt );
    wxPoint2D GetRightBottom() const;
    void SetRightBottom( const wxPoint2D &pt );
    void MoveRightBottomTo( const wxPoint2D &pt );
    wxPoint2D GetCentre() const;
    void SetCentre( const wxPoint2D &pt );
    void MoveCentreTo( const wxPoint2D &pt );
    wxOutCode GetOutcode(const wxPoint2D &pt) const;
    bool Contains( const wxPoint2D &pt ) const;
    bool Contains( const wxRect2D &rect ) const;
    bool IsEmpty() const;
    bool HaveEqualSize( const wxRect2D &rect ) const;
    void Inset( wxDouble x , wxDouble y );
    void Inset( wxDouble left , wxDouble top ,wxDouble right , wxDouble bottom  );
    void Offset( const wxPoint2D &pt );

    void ConstrainTo( const wxRect2D &rect );

    wxPoint2D Interpolate( wxInt32 widthfactor , wxInt32 heightfactor );

    //static void Intersect( const wxRect2D &src1 , const wxRect2D &src2 , wxRect2D *dest );

    void Intersect( const wxRect2D &otherRect );
    wxRect2D CreateIntersection( const wxRect2D &otherRect ) const;
    bool Intersects( const wxRect2D &rect ) const;

    // static void Union( const wxRect2D &src1 , const wxRect2D &src2 , wxRect2D *dest );

    void Union( const wxRect2D &otherRect );
    //void Union( const wxPoint2D &pt );
    
    wxRect2D CreateUnion( const wxRect2D &otherRect ) const;

    void Scale( wxDouble f );
    void Scale( int num , int denum );
};

//---------------------------------------------------------------------------
