class wxDC : wxObject /Abstract/
{
public:
    wxDC();
    virtual ~wxDC();

//     void DrawObject(wxDrawObject* drawobject)
    bool FloodFill(wxCoord x, wxCoord y, const wxColour& col, int style = wxFLOOD_SURFACE);
    bool FloodFill(const wxPoint& pt, const wxColour& col, int style = wxFLOOD_SURFACE);
    void GradientFillConcentric(const wxRect& rect,
                                const wxColour& initialColour,
                                const wxColour& destColour);
    void GradientFillConcentric(const wxRect& rect,
                                const wxColour& initialColour,
                                const wxColour& destColour,
                                const wxPoint& circleCenter);
    void GradientFillLinear(const wxRect& rect,
                            const wxColour& initialColour,
                            const wxColour& destColour,
                            wxDirection nDirection = wxEAST);
    bool GetPixel(wxCoord x, wxCoord y, wxColour *col) const;
    bool GetPixel(const wxPoint& pt, wxColour *col) const;
    void DrawLine(wxCoord x1, wxCoord y1, wxCoord x2, wxCoord y2);
    void DrawLine(const wxPoint& pt1, const wxPoint& pt2) /PyName=DrawLinePoint/;
    void CrossHair(wxCoord x, wxCoord y);
    void CrossHair(const wxPoint& pt);
    void DrawArc(const wxPoint& pt1, const wxPoint& pt2, const wxPoint& centre);
    void DrawCheckMark(wxCoord x, wxCoord y,
        wxCoord width, wxCoord height);
    void DrawCheckMark(const wxRect& rect);
    void DrawEllipticArc(wxCoord x, wxCoord y, wxCoord w, wxCoord h,
        double sa, double ea);
    void DrawEllipticArc(const wxPoint& pt, const wxSize& sz,
        double sa, double ea);
    void DrawPoint(wxCoord x, wxCoord y);
    void DrawPoint(const wxPoint& pt);

    /*
    void DrawLines(int n, wxPoint points[],
                   wxCoord xoffset = 0, wxCoord yoffset = 0)
    void DrawLines(const wxList *list,
                   wxCoord xoffset = 0, wxCoord yoffset = 0);
    void DrawPolygon(int n, wxPoint points[],
                     wxCoord xoffset = 0, wxCoord yoffset = 0,
                     int fillStyle = wxODDEVEN_RULE)
    void DrawPolygon(const wxList *list,
                     wxCoord xoffset = 0, wxCoord yoffset = 0,
                     int fillStyle = wxODDEVEN_RULE);

    void DrawPolyPolygon(int n, int count[], wxPoint points[],
                         wxCoord xoffset = 0, wxCoord yoffset = 0,
                         int fillStyle = wxODDEVEN_RULE)
        { DoDrawPolyPolygon(n, count, points, xoffset, yoffset, fillStyle); }
*/
    void DrawRectangle(wxCoord x, wxCoord y, wxCoord width, wxCoord height);
//        void DrawRectangle(const wxPoint& pt, const wxSize& sz);
    void DrawRectangle(const wxRect& rect) /PyName=DrawRectangleRect/;
    void DrawRoundedRectangle(wxCoord x, wxCoord y, wxCoord width, wxCoord height, double radius);
    void DrawRoundedRectangle(const wxPoint& pt, const wxSize& sz, double radius) /PyName=DrawRoundedRectanglePS/;
    void DrawRoundedRectangle(const wxRect& r, double radius) /PyName=DrawRoundedRectangleRect/;
    void DrawCircle(wxCoord x, wxCoord y, wxCoord radius);
    void DrawCircle(const wxPoint& pt, wxCoord radius);
    void DrawEllipse(wxCoord x, wxCoord y, wxCoord width, wxCoord height);
    void DrawEllipse(const wxPoint& pt, const wxSize& sz);
    void DrawEllipse(const wxRect& rect);
    void DrawIcon(const wxIcon& icon, wxCoord x, wxCoord y);
    void DrawIcon(const wxIcon& icon, const wxPoint& pt);
    void DrawBitmap(const wxBitmap &bmp, wxCoord x, wxCoord y, bool useMask = false);
    void DrawBitmap(const wxBitmap &bmp, const wxPoint& pt, bool useMask = false) /PyName=DrawBitmapPoint/;

    void DrawText(const wxString& text, wxCoord x, wxCoord y);
    void DrawText(const wxString& text, const wxPoint& pt);
    void DrawRotatedText(const wxString& text, wxCoord x, wxCoord y, double angle);
void DrawRotatedText(const wxString& text, const wxPoint& pt, double angle);
/*
    void DrawLabel(const wxString& text,
                           const wxBitmap& image,
                           const wxRect& rect,
                           int alignment = wxALIGN_LEFT | wxALIGN_TOP,
                           int indexAccel = -1,
                           wxRect *rectBounding = NULL);
*/
    void DrawLabel(const wxString& text, const wxRect& rect,
                   int alignment = wxALIGN_LEFT | wxALIGN_TOP,
                   int indexAccel = -1);

    bool Blit(wxCoord xdest, wxCoord ydest, wxCoord width, wxCoord height,
              wxDC *source, wxCoord xsrc, wxCoord ysrc,
              int rop = wxCOPY, bool useMask = false, wxCoord xsrcMask = wxDefaultCoord, wxCoord ysrcMask = wxDefaultCoord);

    bool Blit(const wxPoint& destPt, const wxSize& sz,
              wxDC *source, const wxPoint& srcPt,
              int rop = wxCOPY, bool useMask = false, const wxPoint& srcPtMask = wxDefaultPosition);

    wxBitmap GetAsBitmap(const wxRect *subrect = NULL) const;
/*
%If (wxUSE_SPLINES)
    // TODO: this API needs fixing (wxPointList, why (!const) "wxList *"?)
    void DrawSpline(wxCoord x1, wxCoord y1,
                    wxCoord x2, wxCoord y2,
                    wxCoord x3, wxCoord y3);
    void DrawSpline(int n, wxPoint points[]);

    void DrawSpline(wxList *points) { DoDrawSpline(points); }
#endif // wxUSE_SPLINES
*/


    // Eventually we will have wxUSE_GENERIC_DRAWELLIPSE
//#ifdef __WXWINCE__
    //! Generic method to draw ellipses, circles and arcs with current pen and brush.
    /*! \param x Upper left corner of bounding box.
     *  \param y Upper left corner of bounding box.
     *  \param w Width of bounding box.
     *  \param h Height of bounding box.
     *  \param sa Starting angle of arc
     *            (counterclockwise, start at 3 o'clock, 360 is full circle).
     *  \param ea Ending angle of arc.
     *  \param angle Rotation angle, the Arc will be rotated after
     *               calculating begin and end.
     */
/*
    void DrawEllipticArcRot( wxCoord x, wxCoord y,
                             wxCoord width, wxCoord height,
                             double sa = 0, double ea = 0, double angle = 0 )
    { DoDrawEllipticArcRot( x, y, width, height, sa, ea, angle ); }

    void DrawEllipticArcRot( const wxPoint& pt,
                             const wxSize& sz,
                             double sa = 0, double ea = 0, double angle = 0 )
    { DoDrawEllipticArcRot( pt.x, pt.y, sz.x, sz.y, sa, ea, angle ); }

    void DrawEllipticArcRot( const wxRect& rect,
                             double sa = 0, double ea = 0, double angle = 0 )
    { DoDrawEllipticArcRot( rect.x, rect.y, rect.width, rect.height, sa, ea, angle ); }

     void DoDrawEllipticArcRot( wxCoord x, wxCoord y,
                                       wxCoord w, wxCoord h,
                                       double sa = 0, double ea = 0, double angle = 0 );
*/
    //! Rotates points around center.
    /*! This is a quite straight method, it calculates in pixels
     *  and so it produces rounding errors.
     *  \param points The points inside will be rotated.
     *  \param angle Rotating angle (counterclockwise, start at 3 o'clock, 360 is full circle).
     *  \param center Center of rotation.
     */
//    void Rotate( wxList* points, double angle, wxPoint center = wxPoint(0,0) );

    // used by DrawEllipticArcRot
    // Careful: wxList gets filled with points you have to delete later.
//    void CalculateEllipticPoints( wxList* points,
//                                  wxCoord xStart, wxCoord yStart,
//                                  wxCoord w, wxCoord h,
 //                                 double sa, double ea );
//#endif


     void Clear();

     bool StartDoc(const wxString& message);
     void EndDoc();

     void StartPage();
     void EndPage();

     void SetFont(const wxFont& font);
     void SetPen(const wxPen& pen);
     void SetBrush(const wxBrush& brush);
     void SetBackground(const wxBrush& brush);
     void SetBackgroundMode(int mode);
%If (wxUSE_PALETTE)
     void SetPalette(const wxPalette& palette);
%End // wxUSE_PALETTE

    void SetClippingRegion(wxCoord x, wxCoord y, wxCoord width, wxCoord height);
    void SetClippingRegion(const wxPoint& pt, const wxSize& sz) /PyName=SetClippingRegionPointSize/;
    void SetClippingRegion(const wxRect& rect) /PyName=SetClippingRect/;
    void SetClippingRegion(const wxRegion& region) /PyName=SetClippingRegionAsRegion/;

     void DestroyClippingRegion();

    //void GetClippingBox(wxCoord *x, wxCoord *y, wxCoord *w, wxCoord *h) const;
    void GetClippingBox(wxRect& rect) const;

     wxCoord GetCharHeight();
     wxCoord GetCharWidth();

    void GetTextExtent(const wxString& string,
                       wxCoord *x, wxCoord *y,
                       wxCoord *descent = NULL,
                       wxCoord *externalLeading = NULL,
                       wxFont *theFont = NULL) const /PyName=GetFullTextExtent/;

    SIP_PYTUPLE GetTextExtent(const wxString& string);
%MethodCode
        int x = 0;
        int y = 0;
        sipCpp->GetTextExtent(*a0, &x, &y);
        sipRes = Py_BuildValue("(ii)", x, y);
%End

     void GetMultiLineTextExtent(const wxString& string,
                                        wxCoord *width,
                                        wxCoord *height,
                                        wxCoord *heightLine = NULL,
                                        wxFont *font = NULL) const;

    //wxSize GetMultiLineTextExtent(const wxString& string) const;

    //bool GetPartialTextExtents(const wxString& text, wxArrayInt& widths) const;
    wxSize GetSize() const;
    wxSize GetSizeMM() const;

    wxCoord DeviceToLogicalX(wxCoord x) const;
    wxCoord DeviceToLogicalY(wxCoord y) const;
    wxCoord DeviceToLogicalXRel(wxCoord x) const;
    wxCoord DeviceToLogicalYRel(wxCoord y) const;
    wxCoord LogicalToDeviceX(wxCoord x) const;
    wxCoord LogicalToDeviceY(wxCoord y) const;
    wxCoord LogicalToDeviceXRel(wxCoord x) const;
    wxCoord LogicalToDeviceYRel(wxCoord y) const;

     bool CanDrawBitmap() const;
     bool CanGetTextExtent() const;

    // colour depth
     int GetDepth() const;

    // Resolution in Pixels per inch
     wxSize GetPPI() const;

     bool Ok() const;
     bool IsOk() const;

     int GetBackgroundMode() const;
     const wxBrush&  GetBackground() const;
     const wxBrush&  GetBrush() const;
     const wxFont&   GetFont() const;
     const wxPen&    GetPen() const;

     const wxColour& GetTextForeground() const;
     const wxColour& GetTextBackground() const;
     void SetTextForeground(const wxColour& colour);
     void SetTextBackground(const wxColour& colour);
     int GetMapMode() const;
     void SetMapMode(int mode);

     void GetUserScale(double *x, double *y) const;

     void SetUserScale(double x, double y);
     void GetLogicalScale(double *x /Out/, double *y /Out/);
     void SetLogicalScale(double x, double y);
    wxPoint GetLogicalOrigin() const;
     void SetLogicalOrigin(wxCoord x, wxCoord y);
    wxPoint GetDeviceOrigin() const;
     void SetDeviceOrigin(wxCoord x, wxCoord y);

     void ComputeScaleAndOrigin();

     void SetAxisOrientation(bool xLeftRight, bool yBottomUp);

     int GetLogicalFunction() const;
     void SetLogicalFunction(int function);

     void CalcBoundingBox(wxCoord x, wxCoord y);

    void ResetBoundingBox();

    // Get the final bounding box of the PostScript or Metafile picture.
    wxCoord MinX() const;
    wxCoord MaxX() const;
    wxCoord MinY() const;
    wxCoord MaxY() const;

    void GetClippingBox(long *x /Out/, long *y /Out/, long *w /Out/, long *h /Out/) const;
    wxLayoutDirection GetLayoutDirection() const;
    void SetLayoutDirection(wxLayoutDirection dir);

%If (WXMSW)
    long GetHDC();
%MethodCode
        sipRes = (long)sipCpp->GetHDC();
%End
%End


private:
    wxDC(const wxDC&);
};

class wxWindowDC: wxDC
{
public:
    wxWindowDC(wxWindow* win);
    virtual ~wxWindowDC();
private:
    wxWindowDC(const wxWindowDC&);
};

class wxClientDC: wxWindowDC
{
public:
    wxClientDC(wxWindow* win);
    virtual ~wxClientDC();
private:
    wxClientDC(const wxClientDC&);
};


class wxPaintDC: wxWindowDC
{
public:
    wxPaintDC(wxWindow* win);
    virtual ~wxPaintDC();
private:
    wxPaintDC(const wxPaintDC&);
};

class wxMemoryDC: wxWindowDC
{
private:
    wxMemoryDC(const wxMemoryDC&);
public:
    wxMemoryDC(wxBitmap& bitmap = wxNullBitmap);
    virtual ~wxMemoryDC();

    void SelectObject(wxBitmap& bitmap);
    void SelectObjectAsSource(const wxBitmap& bmp);

};


class wxBufferedDC : wxMemoryDC
{
%TypeHeaderCode
#ifndef WXPY_PREC
#include <wx/dcbuffer.h>
#endif
%End

private:
    wxBufferedDC(const wxBufferedDC&);

public:
    wxBufferedDC(wxDC* dc,
                 wxBitmap& buffer=wxNullBitmap,
                 int style = wxBUFFER_CLIENT_AREA );
    wxBufferedDC(wxDC* dc,
                 const wxSize& area,
                 int style = wxBUFFER_CLIENT_AREA );

    virtual ~wxBufferedDC();
    void UnMask();

    void SetStyle(int style);
    int GetStyle() const;
};

class wxBufferedPaintDC : wxBufferedDC
{
%TypeHeaderCode
#ifndef WXPY_PREC
#include <wx/dcbuffer.h>
#endif
%End

private:
    wxBufferedPaintDC(const wxBufferedPaintDC&);

public:
    // TODO: ownership of wxBitmap argument?
    wxBufferedPaintDC( wxWindow *window,
                       wxBitmap &buffer = wxNullBitmap,
                       int style = wxBUFFER_CLIENT_AREA);

    virtual ~wxBufferedPaintDC();

};


class wxAutoBufferedPaintDC : wxDC
{
%TypeHeaderCode
#ifndef WXPY_PREC
#include <wx/dcbuffer.h>
#endif
%End
public:
    wxAutoBufferedPaintDC(wxWindow* win);
    virtual ~wxAutoBufferedPaintDC();
};

class wxDCClipper
{
public:
    wxDCClipper(wxDC& dc, const wxRegion& r);
    wxDCClipper(wxDC& dc, const wxRect& r);
    wxDCClipper(wxDC& dc, wxCoord x, wxCoord y, wxCoord w, wxCoord h);
    virtual ~wxDCClipper();
private:
    wxDCClipper(const wxDCClipper&);
};
