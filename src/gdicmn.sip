//
// gdicmn.sip
//

class wxPoint
{

%TypeHeaderCode
#ifndef WXPY_PREC
#include <wx/gdicmn.h>
#endif
%End

public:
    wxPoint(int x = 0, int y = 0);
    ~wxPoint();

%ConvertToTypeCode
    if (sipIsErr == NULL)
        return sequence_2_ints_check(sipPy)
            || sipCanConvertToInstance(sipPy, sipClass_wxPoint, SIP_NO_CONVERTORS);

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
    else
    {
        PyErr_Format(PyExc_IndexError, "index out of range: %d", a0);
        sipIsErr = 1;
    }
%End

    void __setitem__(int i, int val);
%MethodCode
    if (a0 == 0) sipCpp->x = a1;
    else if (a0 == 1) sipCpp->y = a1;
    else
    {
        PyErr_SetString(PyExc_IndexError, "index out of range");
        sipIsErr = 1;
    }
%End

    int __len__();
%MethodCode
    sipRes = 2;
%End


    SIP_PYOBJECT __repr__();
%MethodCode
    sipRes = PyString_FromFormat("<wx.Point (%d, %d)>", sipCpp->x, sipCpp->y);
%End

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
#ifndef WXPY_PREC
#include <wx/gdicmn.h>
#endif
%End

public:
    wxSize();
    wxSize(int width, int height);
    ~wxSize();

    wxSize operator+(const wxSize&);
    wxSize operator-(const wxSize&);

    bool operator==(const wxSize&);

    void IncTo(const wxSize& sz);
    void DecTo(const wxSize& sz);
    void IncBy(int dx, int dy);
    void DecBy(int dx, int dy);
    bool IsFullySpecified() const;
    void SetDefaults(const wxSize&);

// Convert from tuples of two integers
%ConvertToTypeCode
    if (sipIsErr == NULL)
        return sequence_2_ints_check(sipPy) ||
            sipCanConvertToInstance(sipPy, sipClass_wxSize, SIP_NO_CONVERTORS);

    int _x, _y;
    if (sequence_2_ints(sipPy, &_x, &_y)) {
        *sipCppPtr = new wxSize(_x, _y);
        return sipGetState(sipTransferObj);
    }

    *sipCppPtr = reinterpret_cast<wxSize *>(sipConvertToInstance(sipPy, sipClass_wxSize, sipTransferObj, SIP_NO_CONVERTORS, 0, sipIsErr));
    return 0;
%End

    int __getitem__(int i);
%MethodCode
    if (a0 == 0) sipRes = sipCpp->x;
    else if (a0 == 1) sipRes = sipCpp->y;
    else
    {
        PyErr_SetString(PyExc_IndexError, "index out of range");
        sipIsErr = 1;
    }
%End

    int __len__();
%MethodCode
    sipRes = 2;
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
#ifndef WXPY_PREC
#include <wx/gdicmn.h>
#endif
%End

public:
%ConvertToTypeCode
    if (sipIsErr == NULL)
        return sequence_4_ints_check(sipPy)
            || sipCanConvertToInstance(sipPy, sipClass_wxRect, SIP_NO_CONVERTORS);

    int _x, _y, _w, _h;
    if (sequence_4_ints(sipPy, &_x, &_y, &_w, &_h)) {
        *sipCppPtr = new wxRect(_x, _y, _w, _h);
        return sipGetState(sipTransferObj);
    }

    *sipCppPtr = reinterpret_cast<wxRect *>(sipConvertToInstance(sipPy, sipClass_wxRect, sipTransferObj, SIP_NO_CONVERTORS, 0, sipIsErr));
    return 0;
%End

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

    void Offset(const wxPoint& pt);

    int GetLeft()   const;
    int GetTop()    const;
    int GetBottom() const;
    int GetRight()  const;

    void SetLeft(int left);
    void SetRight(int right);
    void SetTop(int top);
    void SetBottom(int bottom);

    wxRect Deflate(wxCoord dx, wxCoord dy) const;
%MethodCode
        sipCpp->Deflate(a0, a1);
        sipRes = new wxRect(*sipCpp);
%End


    wxRect Inflate(wxCoord dx, wxCoord dy) const;
%MethodCode
        sipCpp->Inflate(a0, a1);
        sipRes = new wxRect(*sipCpp);
%End

    bool Contains(int x, int y) const /PyName=ContainsXY/;
    bool Contains(const wxPoint& pt) const;
    bool Contains(const wxRect& rect) const /PyName=ContainsRect/;

    bool Intersects(const wxRect &rect) const;
    void Union(const wxRect &otherRect);

    SIP_PYOBJECT __repr__();
%MethodCode
    sipRes = PyString_FromFormat("<wx.Rect (%d, %d, %d, %d)>",
                sipCpp->x, sipCpp->y, sipCpp->width, sipCpp->height);
%End

    int __len__();
%MethodCode
    sipRes = 4;
%End

    SIP_PYTUPLE __getitem__(SIP_PYSLICE);
%MethodCode
//    int PySlice_GetIndicesEx(	PySliceObject *slice, Py_ssize_t length, Py_ssize_t *start, Py_ssize_t *stop, Py_ssize_t *step, Py_ssize_t *slicelength)

    Py_ssize_t start, stop, step, length;
    PySlice_GetIndicesEx((PySliceObject*)a0, 4, &start, &stop, &step, &length);

    sipRes = PyTuple_New(length);
    int c = 0;
    int val;
    int i;

    for (i = start; (step > 0 ? i < stop : i > stop); i += step) {
        switch (i) {
            case 0: val = sipCpp->x; break;
            case 1: val = sipCpp->y; break;
            case 2: val = sipCpp->width; break;
            case 3: val = sipCpp->height; break;
            default:
                PyErr_SetString(PyExc_IndexError, "index out of range");
                sipIsErr = 1;
        }

        if (sipIsErr) break;
        PyTuple_SET_ITEM(sipRes, c++, PyInt_FromLong(val));
    }

    if (sipIsErr)
        Py_DECREF(sipRes);
%End

    int __getitem__(size_t i);
%MethodCode
    switch (a0)
    {
        case 0:
            sipRes = sipCpp->x;
            break;
        case 1:
            sipRes = sipCpp->y;
            break;
        case 2:
            sipRes = sipCpp->width;
            break;
        case 3:
            sipRes = sipCpp->height;
            break;
        default:
            PyErr_SetString(PyExc_IndexError, "index out of range");
            sipIsErr = 1;
    }
%End

    bool operator==(const wxRect&);

    int x;
    int y;
    int width;
    int height;
};


class wxPen: wxGDIObject
{
public:
    wxPen(wxColour& colour, int width=1, int style=wxSOLID);
    ~wxPen();

    int GetCap();
    wxColour GetColour();
    int GetJoin();
    int GetStyle();
    int GetWidth();

    bool IsOk();

    void SetCap(int cap_style);
    void SetColour(wxColour& colour);
    void SetJoin(int join_style);
    void SetStyle(int style);
    void SetWidth(int width);

    //void SetDashes(int dashes, wxDash* dashes_array);
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

%If (!WXMAC)
%ModuleHeaderCode
#define wxCURSOR_COPY_ARROW wxCURSOR_ARROW
%End
%End

enum // wxStockCursor
{
    wxCURSOR_NONE,          // should be 0
    wxCURSOR_ARROW,
    wxCURSOR_RIGHT_ARROW,
    wxCURSOR_BULLSEYE,
    wxCURSOR_CHAR,
    wxCURSOR_CROSS,
    wxCURSOR_HAND,
    wxCURSOR_IBEAM,
    wxCURSOR_LEFT_BUTTON,
    wxCURSOR_MAGNIFIER,
    wxCURSOR_MIDDLE_BUTTON,
    wxCURSOR_NO_ENTRY,
    wxCURSOR_PAINT_BRUSH,
    wxCURSOR_PENCIL,
    wxCURSOR_POINT_LEFT,
    wxCURSOR_POINT_RIGHT,
    wxCURSOR_QUESTION_ARROW,
    wxCURSOR_RIGHT_BUTTON,
    wxCURSOR_SIZENESW,
    wxCURSOR_SIZENS,
    wxCURSOR_SIZENWSE,
    wxCURSOR_SIZEWE,
    wxCURSOR_SIZING,
    wxCURSOR_SPRAYCAN,
    wxCURSOR_WAIT,
    wxCURSOR_WATCH,
    wxCURSOR_BLANK,
    wxCURSOR_DEFAULT, // standard X11 cursor
    wxCURSOR_COPY_ARROW , // MacOS Theme Plus arrow

// #ifdef __X__
//     // Not yet implemented for Windows
//     wxCURSOR_CROSS_REVERSE,
//     wxCURSOR_DOUBLE_ARROW,
//     wxCURSOR_BASED_ARROW_UP,
//     wxCURSOR_BASED_ARROW_DOWN,
// #endif // X11

    wxCURSOR_ARROWWAIT,

    wxCURSOR_MAX
};

/*
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
*/

/*
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
*/
