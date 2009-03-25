%Module _wxcombo
%Import wx.sip

%UnitCode
#include "stdwxpy.h"
%End

%ModuleHeaderCode
#include <wx/combo.h>
#include <wx/odcombo.h>
%End

enum {
    wxCC_BUTTON_OUTSIDE_BORDER      = 0x0001,
    wxCC_POPUP_ON_MOUSE_UP          = 0x0002,
    wxCC_NO_TEXT_AUTO_SELECT        = 0x0004,
};

enum
{
    wxCC_MF_ON_BUTTON               =   0x0001,
    wxCC_MF_ON_CLICK_AREA           =   0x0002
};

struct wxComboCtrlFeatures
{
    enum
    {
        MovableButton       = 0x0001,
        BitmapButton        = 0x0002,
        ButtonSpacing       = 0x0004,

        TextIndent          = 0x0008,
        PaintControl        = 0x0010,
        PaintWritable       = 0x0020,


        Borderless          = 0x0040,
        All                 = 0xFFFF,
    };
};


class wxComboCtrl : wxControl
{
private:
    wxComboCtrl(const wxComboCtrl&);
public:
    wxComboCtrl(wxWindow *parent,
                wxWindowID id = wxID_ANY,
                const wxString& value = wxEmptyString,
                const wxPoint& pos = wxDefaultPosition,
                const wxSize& size = wxDefaultSize,
                long style = 0,
                const wxValidator& validator = wxDefaultValidator,
                const wxString& name = wxComboBoxNameStr);

    virtual ~wxComboCtrl();

    virtual void ShowPopup();
    virtual void HidePopup();
    virtual void OnButtonClick();
    bool IsPopupShown() const;

    void SetPopupControl(wxComboPopup* popup /Transfer/);
    wxComboPopup* GetPopupControl() /Transfer/;
    wxWindow * GetPopupWindow() const /Transfer/;
    wxTextCtrl * GetTextCtrl() const /Transfer/;
    wxWindow * GetButton() const /Transfer/;

    virtual wxString GetValue() const;
    virtual void SetValue(const wxString& value);

    virtual void Copy();
    virtual void Cut();
    virtual void Paste();
    virtual void SetInsertionPoint(long pos);
    virtual void SetInsertionPointEnd();
    virtual long GetInsertionPoint() const;
    virtual long GetLastPosition() const;
    virtual void Replace(long from, long to, const wxString& value);
    virtual void Remove(long from, long to);
    virtual void Undo();

    void SetSelection(long from, long to) /PyName=SetMark/;

    void SetText(const wxString& value);
    void SetValueWithEvent(const wxString& value, bool withEvent = true);

    void SetPopupMinWidth( int width );
    void SetPopupMaxHeight( int height );
    void SetPopupExtents( int extLeft, int extRight );
    void SetCustomPaintWidth( int width );

    int GetCustomPaintWidth() const;
    void SetPopupAnchor( int anchorSide );
    void SetButtonPosition(int width = -1,
                             int height = -1,
                             int side = wxRIGHT,
                             int spacingX = 0 );

    wxSize GetButtonSize();

    void SetButtonBitmaps(const wxBitmap& bmpNormal,
                          bool pushButtonBg = false,
                          const wxBitmap& bmpPressed = wxNullBitmap,
                          const wxBitmap& bmpHover = wxNullBitmap,
                          const wxBitmap& bmpDisabled = wxNullBitmap);

    void SetTextIndent( int indent );
    wxCoord GetTextIndent() const;
    const wxRect& GetTextRect() const;

    void UseAltPopupWindow( bool enable = true );
    void EnablePopupAnimation(bool enable = true);

    virtual bool IsKeyPopupToggle(const wxKeyEvent& event) const = 0;
    virtual void PrepareBackground( wxDC& dc, const wxRect& rect, int flags ) const;

    bool ShouldDrawFocus() const;

    const wxBitmap& GetBitmapNormal() const;
    const wxBitmap& GetBitmapPressed() const;
    const wxBitmap& GetBitmapHover() const;
    const wxBitmap& GetBitmapDisabled() const;

    wxUint32 GetInternalFlags() const;
    bool IsCreated() const;
    void OnPopupDismiss();

    enum
    {
        Hidden       = 0,
        //Closing      = 1,
        Animating    = 2,
        Visible      = 3
    };

protected:

    virtual void DoSetPopupControl(wxComboPopup* popup);
    bool IsPopupWindowState( int state ) const;
    int GetPopupWindowState() const;
    void SetCtrlMainWnd(wxWindow* wnd);
    virtual wxWindow *GetMainWindowOfCompositeControl();
    static int GetFeatures();

    enum
    {
        ShowBelow       = 0x0000,  // Showing popup below the control
        ShowAbove       = 0x0001,  // Showing popup above the control
        CanDeferShow    = 0x0002  // Can only return true from AnimateShow if this is set
    };


    virtual void DoShowPopup( const wxRect& rect, int flags );
    virtual bool AnimateShow( const wxRect& rect, int flags );
};

class wxComboPopup /Supertype=sip.wrapper/
{
public:
    wxComboPopup();
    virtual ~wxComboPopup();

    virtual bool Create(wxWindow* parent) = 0;

    virtual wxWindow * GetControl() = 0;
    virtual void OnPopup();
    virtual void OnDismiss();
    virtual void SetStringValue( const wxString& value );
    virtual wxString GetStringValue() const = 0;
    virtual void PaintComboControl( wxDC& dc, const wxRect& rect );
    virtual void OnComboKeyEvent( wxKeyEvent& event );
    virtual void OnComboDoubleClick();
    virtual wxSize GetAdjustedSize( int minWidth, int prefHeight, int maxHeight );
    virtual bool LazyCreate();
    void Dismiss();
    bool IsCreated() const;
    static void DefaultPaintComboControl(wxComboCtrl* combo,
                                         wxDC& dc,
                                         const wxRect& rect);
};


class wxOwnerDrawnComboBox : wxComboCtrl, wxItemContainer
{
public:

    wxOwnerDrawnComboBox(wxWindow *parent /TransferThis/,
                           wxWindowID id = -1,
                           const wxString& value = wxEmptyString,
                           const wxPoint& pos = wxDefaultPosition,
                           const wxSize& size = wxDefaultSize,
                           const wxArrayString& choices = NULL,
                           long style = 0,
                           const wxValidator& validator = wxDefaultValidator,
                           const wxString& name = wxComboBoxNameStr);
    virtual ~wxOwnerDrawnComboBox();

    virtual int GetWidestItemWidth();
    virtual int GetWidestItem();
    void SetSelection(int n);
    void SetSelection(long from, long to)/PyName=SetMark/;

protected:
    virtual void OnDrawItem(wxDC& dc, const wxRect& rect, int item, int flags) const;
    virtual wxCoord OnMeasureItem(size_t item) const;
    virtual wxCoord OnMeasureItemWidth(size_t item) const;
    virtual void OnDrawBackground(wxDC& dc, const wxRect& rect, int item, int flags) const;


};

%ModuleHeaderCode
#include <wx/bmpcbox.h>
%End

class wxBitmapComboBox : wxOwnerDrawnComboBox
{
public:
    wxBitmapComboBox(wxWindow *parent /TransferThis/,
                     wxWindowID id = -1,
                     const wxString& value = wxEmptyString,
                     const wxPoint& pos = wxDefaultPosition,
                     const wxSize& size = wxDefaultSize,
                     const wxArrayString& choices = NULL,
                     long style = 0,
                     const wxValidator& validator = wxDefaultValidator,
                     const wxString& name = wxBitmapComboBoxNameStr);
    virtual ~wxBitmapComboBox();

    wxBitmap GetItemBitmap(/*unsigned*/ int n) const;

    void SetItemBitmap(/*unsigned*/ int n, const wxBitmap& bitmap);
    wxSize GetBitmapSize() const;
};
