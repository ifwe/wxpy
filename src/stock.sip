class wxStockGDI
{
public:
    enum Item {
        BRUSH_BLACK,
        BRUSH_BLUE,
        BRUSH_CYAN,
        BRUSH_GREEN,
        BRUSH_GREY,
        BRUSH_LIGHTGREY,
        BRUSH_MEDIUMGREY,
        BRUSH_RED,
        BRUSH_TRANSPARENT,
        BRUSH_WHITE,
        COLOUR_BLACK,
        COLOUR_BLUE,
        COLOUR_CYAN,
        COLOUR_GREEN,
        COLOUR_LIGHTGREY,
        COLOUR_RED,
        COLOUR_WHITE,
        CURSOR_CROSS,
        CURSOR_HOURGLASS,
        CURSOR_STANDARD,
        FONT_ITALIC,
        FONT_NORMAL,
        FONT_SMALL,
        FONT_SWISS,
        PEN_BLACK,
        PEN_BLACKDASHED,
        PEN_CYAN,
        PEN_GREEN,
        PEN_GREY,
        PEN_LIGHTGREY,
        PEN_MEDIUMGREY,
        PEN_RED,
        PEN_TRANSPARENT,
        PEN_WHITE,
        ITEMCOUNT
    };

//    wxStockGDI();
//    virtual ~wxStockGDI();
    static void DeleteAll();

    static wxStockGDI& instance();

    static const wxBrush*  GetBrush(Item item);
    static const wxColour* GetColour(Item item);
    static const wxCursor* GetCursor(Item item);
    static const wxPen*    GetPen(Item item);

    virtual const wxFont* GetFont(Item item);
/*
    %pythoncode {
    def _initStockObjects():
        import wx
        wx.ITALIC_FONT.this  = StockGDI.instance().GetFont(StockGDI.FONT_ITALIC).this
        wx.NORMAL_FONT.this  = StockGDI.instance().GetFont(StockGDI.FONT_NORMAL).this
        wx.SMALL_FONT.this   = StockGDI.instance().GetFont(StockGDI.FONT_SMALL).this
        wx.SWISS_FONT.this   = StockGDI.instance().GetFont(StockGDI.FONT_SWISS).this
                                              
        wx.BLACK_DASHED_PEN.this  = StockGDI.GetPen(StockGDI.PEN_BLACKDASHED).this
        wx.BLACK_PEN.this         = StockGDI.GetPen(StockGDI.PEN_BLACK).this
        wx.CYAN_PEN.this          = StockGDI.GetPen(StockGDI.PEN_CYAN).this
        wx.GREEN_PEN.this         = StockGDI.GetPen(StockGDI.PEN_GREEN).this
        wx.GREY_PEN.this          = StockGDI.GetPen(StockGDI.PEN_GREY).this
        wx.LIGHT_GREY_PEN.this    = StockGDI.GetPen(StockGDI.PEN_LIGHTGREY).this
        wx.MEDIUM_GREY_PEN.this   = StockGDI.GetPen(StockGDI.PEN_MEDIUMGREY).this
        wx.RED_PEN.this           = StockGDI.GetPen(StockGDI.PEN_RED).this
        wx.TRANSPARENT_PEN.this   = StockGDI.GetPen(StockGDI.PEN_TRANSPARENT).this
        wx.WHITE_PEN.this         = StockGDI.GetPen(StockGDI.PEN_WHITE).this

        wx.BLACK_BRUSH.this        = StockGDI.GetBrush(StockGDI.BRUSH_BLACK).this
        wx.BLUE_BRUSH.this         = StockGDI.GetBrush(StockGDI.BRUSH_BLUE).this
        wx.CYAN_BRUSH.this         = StockGDI.GetBrush(StockGDI.BRUSH_CYAN).this
        wx.GREEN_BRUSH.this        = StockGDI.GetBrush(StockGDI.BRUSH_GREEN).this
        wx.GREY_BRUSH.this         = StockGDI.GetBrush(StockGDI.BRUSH_GREY).this
        wx.LIGHT_GREY_BRUSH.this   = StockGDI.GetBrush(StockGDI.BRUSH_LIGHTGREY).this
        wx.MEDIUM_GREY_BRUSH.this  = StockGDI.GetBrush(StockGDI.BRUSH_MEDIUMGREY).this
        wx.RED_BRUSH.this          = StockGDI.GetBrush(StockGDI.BRUSH_RED).this
        wx.TRANSPARENT_BRUSH.this  = StockGDI.GetBrush(StockGDI.BRUSH_TRANSPARENT).this
        wx.WHITE_BRUSH.this        = StockGDI.GetBrush(StockGDI.BRUSH_WHITE).this

        wx.BLACK.this       = StockGDI.GetColour(StockGDI.COLOUR_BLACK).this
        wx.BLUE.this        = StockGDI.GetColour(StockGDI.COLOUR_BLUE).this
        wx.CYAN.this        = StockGDI.GetColour(StockGDI.COLOUR_CYAN).this
        wx.GREEN.this       = StockGDI.GetColour(StockGDI.COLOUR_GREEN).this
        wx.LIGHT_GREY.this  = StockGDI.GetColour(StockGDI.COLOUR_LIGHTGREY).this
        wx.RED.this         = StockGDI.GetColour(StockGDI.COLOUR_RED).this
        wx.WHITE.this       = StockGDI.GetColour(StockGDI.COLOUR_WHITE).this
    
        wx.CROSS_CURSOR.this      = StockGDI.GetCursor(StockGDI.CURSOR_CROSS).this
        wx.HOURGLASS_CURSOR.this  = StockGDI.GetCursor(StockGDI.CURSOR_HOURGLASS).this
        wx.STANDARD_CURSOR.this   = StockGDI.GetCursor(StockGDI.CURSOR_STANDARD).this

        wx.TheFontList.this       = _wxPyInitTheFontList().this
        wx.ThePenList.this        = _wxPyInitThePenList().this
        wx.TheBrushList.this      = _wxPyInitTheBrushList().this
        wx.TheColourDatabase.this = _wxPyInitTheColourDatabase().this

        
    _initStockObjects = staticmethod(_initStockObjects)
    }
    */
private:
    wxStockGDI();
    ~wxStockGDI();
    wxStockGDI(const wxStockGDI&);
};
