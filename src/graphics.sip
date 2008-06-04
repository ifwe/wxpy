%ModuleHeaderCode
#ifndef WXPY_PREC
#include <wx/graphics.h>
#include <wx/gdicmn.h>
#include <wx/geometry.h>
#endif
%End


class wxPoint2DDouble
{
public:
    wxPoint2DDouble();
/*    wxPoint2DDouble(wxDouble x, wxDouble y);
    wxPoint2DDouble(const wxPoint2DDouble &pt);
    //wxPoint2DDouble(const wxPoint2DInt &pt )
    //    { m_x = (wxDouble) pt.m_x ; m_y = (wxDouble) pt.m_y ; }
    wxPoint2DDouble(const wxPoint &pt );

    // two different conversions to integers, floor and rounding
    void GetFloor(wxInt32 *x , wxInt32 *y) const;
    void GetRounded(wxInt32 *x , wxInt32 *y) const;

    wxDouble GetVectorLength() const;
     wxDouble GetVectorAngle() const ;
    void SetVectorLength(wxDouble length );
    void SetVectorAngle(wxDouble degrees );
//    void SetPolarCoordinates(wxDouble angle , wxDouble length );
    // set the vector length to 1.0, preserving the angle
    void Normalize();

    wxDouble GetDistance(const wxPoint2DDouble &pt) const;
    wxDouble GetDistanceSquare(const wxPoint2DDouble &pt) const;
    wxDouble GetDotProduct(const wxPoint2DDouble &vec) const;
    wxDouble GetCrossProduct(const wxPoint2DDouble &vec) const;

    // the reflection of this point
    wxPoint2DDouble operator-();

    wxPoint2DDouble& operator+=(const wxPoint2DDouble& pt);
    wxPoint2DDouble& operator-=(const wxPoint2DDouble& pt);
    wxPoint2DDouble& operator*=(const wxPoint2DDouble& pt);
    wxPoint2DDouble& operator*=(wxDouble n);
//    wxPoint2DDouble& operator*=(wxInt32 n);
    wxPoint2DDouble& operator/=(const wxPoint2DDouble& pt);
    wxPoint2DDouble& operator/=(wxDouble n);
//    wxPoint2DDouble& operator/=(wxInt32 n);

    bool operator==(const wxPoint2DDouble& pt) const;
    bool operator!=(const wxPoint2DDouble& pt) const;

    wxDouble m_x;
    wxDouble m_y;
    */
};


class wxGraphicsObject : wxObject
{
public :
    wxGraphicsObject(wxGraphicsRenderer* renderer = NULL);
    virtual ~wxGraphicsObject();

    bool IsNull() const;
    wxGraphicsRenderer* GetRenderer() const;
};

class wxGraphicsPen : wxGraphicsObject
{
public :
    wxGraphicsPen();
    virtual ~wxGraphicsPen();
};

class wxGraphicsBrush : wxGraphicsObject
{
public :
    wxGraphicsBrush();
    virtual ~wxGraphicsBrush();
};

class wxGraphicsFont : wxGraphicsObject
{
public :
    wxGraphicsFont();
    virtual ~wxGraphicsFont();
};

class wxGraphicsMatrix : wxGraphicsObject
{
public :
//    wxGraphicsMatrix();
    virtual ~wxGraphicsMatrix();
    void Concat(const wxGraphicsMatrix& t);
    void Set(wxDouble a=1.0, wxDouble b=0.0, wxDouble c=0.0, wxDouble d=1.0,
                       wxDouble tx=0.0, wxDouble ty=0.0);
    void Get(wxDouble* a, wxDouble* b, wxDouble* c,
                       wxDouble* d, wxDouble* tx, wxDouble* ty);
    void Invert();
    bool IsEqual(const wxGraphicsMatrix& t) const;
    bool IsIdentity() const;
    void Translate(wxDouble dx, wxDouble dy);
    void Scale(wxDouble xScale, wxDouble yScale);
    void Rotate(wxDouble angle);
    void TransformPoint(wxDouble *x, wxDouble *y) const;
    void TransformDistance(wxDouble *x, wxDouble *y) const;
    void * GetNativeMatrix() const;
};

class wxGraphicsPath : wxGraphicsObject
{
public :
//    wxGraphicsPath();
    virtual ~wxGraphicsPath();

    void  MoveToPoint(wxDouble x, wxDouble y);
    void MoveToPoint(const wxPoint2DDouble& p);

    void AddLineToPoint(wxDouble x, wxDouble y);
    void AddLineToPoint(const wxPoint2DDouble& p);

    void AddCurveToPoint(wxDouble cx1, wxDouble cy1,
                         wxDouble cx2, wxDouble cy2,
                         wxDouble x, wxDouble y);
    void AddCurveToPoint(const wxPoint2DDouble& c1, const wxPoint2DDouble& c2, const wxPoint2DDouble& e);

    void AddPath(const wxGraphicsPath& path);
    void CloseSubpath();
    wxPoint2DDouble GetCurrentPoint() const;
    void AddArc(wxDouble x, wxDouble y, wxDouble r,
                         wxDouble startAngle, wxDouble endAngle, bool clockwise=true);
    void AddArc(const wxPoint2DDouble& c, wxDouble r, wxDouble startAngle, wxDouble endAngle, bool clockwise=true);

    void AddQuadCurveToPoint(wxDouble cx, wxDouble cy, wxDouble x, wxDouble y);
    void AddRectangle(wxDouble x, wxDouble y, wxDouble w, wxDouble h);
    void AddCircle(wxDouble x, wxDouble y, wxDouble r);
    void AddArcToPoint(wxDouble x1, wxDouble y1, wxDouble x2, wxDouble y2, wxDouble r) ;
    void AddEllipse(wxDouble x, wxDouble y, wxDouble w, wxDouble h);
    void AddRoundedRectangle(wxDouble x, wxDouble y, wxDouble w, wxDouble h, wxDouble radius);

    void * GetNativePath() const;
    void UnGetNativePath(void *p) const;
    void Transform(const wxGraphicsMatrix& matrix);
    //wxRect2D GetBox() const;
    bool Contains(wxDouble x, wxDouble y, int fillStyle = wxODDEVEN_RULE) const;
    bool Contains(const wxPoint2DDouble& c, int fillStyle = wxODDEVEN_RULE) const;
};

class wxGraphicsContext : wxGraphicsObject
{
public:
    //wxGraphicsContext();         This is an ABC, use Create to make an instance...
    virtual ~wxGraphicsContext();

    static wxGraphicsContext* Create(const wxWindowDC& dc);
    static wxGraphicsContext* Create(wxWindow* window);
    static wxGraphicsContext* Create();
    static wxGraphicsContext* CreateFromNative(void * context);
    static wxGraphicsContext* CreateFromNativeWindow(void * window);

    wxGraphicsPath CreatePath();
    wxGraphicsPen CreatePen(const wxPen& pen);
    wxGraphicsBrush CreateBrush(const wxBrush& brush);
    wxGraphicsBrush CreateLinearGradientBrush(wxDouble x1, wxDouble y1, wxDouble x2, wxDouble y2, const wxColour& c1, const wxColour& c2);
    wxGraphicsBrush CreateRadialGradientBrush(wxDouble xo, wxDouble yo, wxDouble xc, wxDouble yc, wxDouble radius, const wxColour &oColor, const wxColour &cColor);
    wxGraphicsFont CreateFont(const wxFont &font, const wxColour &col);
    wxGraphicsMatrix CreateMatrix(wxDouble a=1.0, wxDouble b=0.0,
                                  wxDouble c=0.0, wxDouble d=1.0,
                                  wxDouble tx=0.0, wxDouble ty=0.0);

    void PushState();
    void PopState();
    void Clip(const wxRegion &region);
    void Clip(wxDouble x, wxDouble y, wxDouble w, wxDouble h);
    void ResetClip();
    void * GetNativeContext();
    int GetLogicalFunction() const;
    bool SetLogicalFunction(int function) ;
    void Translate(wxDouble dx, wxDouble dy);
    void Scale(wxDouble xScale, wxDouble yScale);
    void Rotate(wxDouble angle);
    void ConcatTransform(const wxGraphicsMatrix& matrix);
    void SetTransform(const wxGraphicsMatrix& matrix);
    wxGraphicsMatrix GetTransform() const;
    void SetPen(const wxGraphicsPen& pen);
    void SetPen(const wxPen& pen);

    void SetBrush(const wxGraphicsBrush& brush);
    void SetBrush(const wxBrush& brush);

    void SetFont(const wxGraphicsFont& font);
    void SetFont(const wxFont& font, const wxColour& colour);
    void StrokePath(const wxGraphicsPath& path);
    void FillPath(const wxGraphicsPath& path, int fillStyle = wxODDEVEN_RULE);
    void DrawPath(const wxGraphicsPath& path, int fillStyle = wxODDEVEN_RULE);

    void DrawText(const wxString &str, wxDouble x, wxDouble y,
    const wxGraphicsBrush& backgroundBrush = wxNullGraphicsBrush);
    void DrawText(const wxString &str, wxDouble x, wxDouble y, wxDouble angle) /PyName=DrawRotatedText/;

    void GetTextExtent(const wxString &text,
                       wxDouble *width /*width*/,
                       wxDouble *height /*height*/,
                       wxDouble *descent /*descent*/,
                       wxDouble *externalLeading /*externalLeading*/) const /PyName=GetFullTextExtent/;


SIP_PYOBJECT GetTextExtent(const wxString &text);
%MethodCode
            wxDouble width = 0.0,
                     height = 0.0;
            sipCpp->GetTextExtent(*a0, &width, &height, NULL, NULL);

            PyObject* rv = PyTuple_New(2);
            PyTuple_SET_ITEM(rv, 0, PyFloat_FromDouble(width));
            PyTuple_SET_ITEM(rv, 1, PyFloat_FromDouble(height));
            sipRes = rv;
%End
/*
    %extend {
        DocAStr(GetPartialTextExtents,
                "GetPartialTextExtents(self, text) -> [widths]";
                "Returns a list of widths from the beginning of ``text`` to the
coresponding character in ``text``.", "");
        wxArrayDouble GetPartialTextExtents(const wxString& text) {
            wxArrayDouble widths;
            self->GetPartialTextExtents(text, widths);
            return widths;
        }
    }

*/
         void DrawBitmap(const wxBitmap &bmp, wxDouble x, wxDouble y, wxDouble w, wxDouble h);
         void DrawIcon(const wxIcon &icon, wxDouble x, wxDouble y, wxDouble w, wxDouble h);
         void StrokeLine(wxDouble x1, wxDouble y1, wxDouble x2, wxDouble y2);
//         void StrokeLines(size_t points, const wxPoint2DDouble *points_array);
         void DrawRectangle(wxDouble x, wxDouble y, wxDouble w, wxDouble h);
         void DrawEllipse(wxDouble x, wxDouble y, wxDouble w, wxDouble h);
         void DrawRoundedRectangle(wxDouble x, wxDouble y, wxDouble w, wxDouble h, wxDouble radius);
         bool ShouldOffset() const;
    private:
        wxGraphicsContext();
};

class wxGraphicsRenderer : wxObject
{
public :
    // wxGraphicsRenderer();  This is an ABC, use GetDefaultRenderer

     ~wxGraphicsRenderer();

    // %newobject GetDefaultRenderer;  ???
    static wxGraphicsRenderer* GetDefaultRenderer();

     wxGraphicsContext * CreateContext(const wxWindowDC& dc) ;
     wxGraphicsContext * CreateContext(wxWindow* window);

    // create a context that can be used for measuring texts only, no drawing allowed
     wxGraphicsContext * CreateMeasuringContext();


     wxGraphicsContext* CreateContextFromNativeContext(void * context) /Factory/;
     wxGraphicsContext * CreateContextFromNativeWindow(void * window) /Factory/;

     wxGraphicsPath CreatePath();

     wxGraphicsMatrix CreateMatrix(wxDouble a=1.0, wxDouble b=0.0, wxDouble c=0.0, wxDouble d=1.0,
                                           wxDouble tx=0.0, wxDouble ty=0.0);

     wxGraphicsPen CreatePen(const wxPen& pen) ;

     wxGraphicsBrush CreateBrush(const wxBrush& brush) ;

     wxGraphicsBrush CreateLinearGradientBrush(wxDouble x1, wxDouble y1, wxDouble x2, wxDouble y2,
                                                        const wxColour&c1, const wxColour&c2);

     wxGraphicsBrush CreateRadialGradientBrush(wxDouble xo, wxDouble yo, wxDouble xc, wxDouble yc, wxDouble radius,
                                                        const wxColour &oColor, const wxColour &cColor);

     wxGraphicsFont CreateFont(const wxFont &font, const wxColour &col);
private:
    wxGraphicsRenderer();
};


class wxGCDC :  wxDC
{
%TypeHeaderCode
#ifndef WXPY_PREC
#include "wx/dcgraph.h"
#endif
%End
public:
    wxGCDC(const wxWindowDC& dc);
    wxGCDC(wxWindow* window);
    //wxGCDC();
    virtual ~wxGCDC();

    wxGraphicsContext* GetGraphicsContext();
     void SetGraphicsContext(wxGraphicsContext* ctx);

    // flushing the content of this dc immediately onto screen
    void Flush();

};

