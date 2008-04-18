enum wxWindowVariant 
{
    wxWINDOW_VARIANT_NORMAL,        // Normal size
    wxWINDOW_VARIANT_SMALL,         // Smaller size (about 25 % smaller than normal )
    wxWINDOW_VARIANT_MINI,          // Mini size (about 33 % smaller than normal )
    wxWINDOW_VARIANT_LARGE,         // Large size (about 25 % larger than normal )
    wxWINDOW_VARIANT_MAX
};

class wxWindow : wxEvtHandler
{

%TypeHeaderCode
#include <wx/window.h>
%End

public:
    wxWindow(wxWindow* parent /TransferThis/,
             const wxWindowID id = wxID_ANY,
             const wxPoint& pos = wxDefaultPosition,
             const wxSize& size = wxDefaultSize,
             long style = 0,
             const wxString& name = wxPanelNameStr);
             
    void Raise();

    void Destroy();
    void GetSize( int *w, int *h ) const;
             
    void CacheBestSize(const wxSize& size) const;
    
    void Centre(int dir = wxBOTH);
    void Center(int dir = wxBOTH);
    void CentreOnParent(int dir = wxBOTH);
    void CenterOnParent(int dir = wxBOTH);
    
    void Fit();
    void FitInside();
    
    void SetSizeHints( int minW, int minH,
                       int maxW = wxDefaultCoord, int maxH = wxDefaultCoord,
                       int incW = wxDefaultCoord, int incH = wxDefaultCoord );
    void SetSizeHints( const wxSize& minSize,
                       const wxSize& maxSize = wxDefaultSize,
                       const wxSize& incSize = wxDefaultSize);
                       
    void SetMinSize(const wxSize& minSize);
    void SetMaxSize(const wxSize& maxSize);
    wxSize GetMinSize() const;
    wxSize GetMaxSize() const;

    int GetMinWidth() const;
    int GetMinHeight() const;
    int GetMaxWidth() const;
    int GetMaxHeight() const;

    void SetVirtualSize( const wxSize &size );
    void SetVirtualSize( int x, int y );
    
    wxSize GetVirtualSize() const;
    wxSize GetBestVirtualSize() const;
    wxSize GetWindowBorderSize() const;

    bool Show(bool show = true);
    bool Hide();
    
    bool Enable(bool enable = true);
    bool Disable();
        
    bool IsShown() const;
    bool IsEnabled() const;

    bool IsShownOnScreen() const;

    void SetWindowStyleFlag( long style );
    long GetWindowStyleFlag() const;

    void SetWindowStyle( long style );
    long GetWindowStyle() const;

    bool HasFlag(int flag) const;
    bool IsRetained() const;

    bool ToggleWindowStyle(int flag);

    void SetExtraStyle(long exStyle);
    long GetExtraStyle() const;

    void MakeModal(bool modal = true);

    void SetThemeEnabled(bool enableTheme);
    bool GetThemeEnabled() const;

    void SetFocusFromKbd();
    static wxWindow *FindFocus();

    bool AcceptsFocus() const;
    bool AcceptsFocusFromKeyboard() const;

    bool Navigate(int flags = wxNavigationKeyEvent::IsForward);

    void MoveBeforeInTabOrder(wxWindow *win);
    void MoveAfterInTabOrder(wxWindow *win);

    //const wxWindowList& GetChildren() const;
    //const wxWindowList& GetWindowChildren() const;

    wxWindow *GetPrevSibling() const;
    wxWindow *GetNextSibling() const;

    wxWindow *GetParent() const;
    wxWindow *GetGrandParent() const;

    bool IsTopLevel() const;

    bool Reparent(wxWindow *newParent);

    wxWindow *FindWindow(long winid) const;
    wxWindow *FindWindow(const wxString& name) const;

        
    static wxWindow *FindWindowById( long winid, const wxWindow *parent = NULL );
    static wxWindow *FindWindowByName( const wxString& name,
                                       const wxWindow *parent = NULL );
    static wxWindow *FindWindowByLabel( const wxString& label,
                                        const wxWindow *parent = NULL );
        
    wxEvtHandler *GetEventHandler() const;
    void SetEventHandler( wxEvtHandler *handler );
        
    void PushEventHandler( wxEvtHandler *handler );
    wxEvtHandler *PopEventHandler( bool deleteHandler = false );
        
    bool RemoveEventHandler(wxEvtHandler *handler);

%If (wxUSE_VALIDATORS)
    void SetValidator( const wxValidator &validator );
    wxValidator *GetValidator();
%End 
    bool Validate();

    bool TransferDataToWindow();
    bool TransferDataFromWindow();

    void InitDialog();

%If (wxUSE_ACCEL)
//    void SetAcceleratorTable( const wxAcceleratorTable& accel );
//    wxAcceleratorTable *GetAcceleratorTable();
%End 

%If (wxUSE_HOTKEY)
    bool RegisterHotKey(int hotkeyId, int modifiers, int keycode);
    bool UnregisterHotKey(int hotkeyId);
%End 

    wxPoint ConvertPixelsToDialog( const wxPoint& pt );
    wxPoint ConvertDialogToPixels( const wxPoint& pt );
    wxSize ConvertPixelsToDialog( const wxSize& sz );

    wxSize ConvertDialogToPixels( const wxSize& sz );

    void WarpPointer(int x, int y);
        
    void CaptureMouse();
    void ReleaseMouse();
        
    static wxWindow *GetCapture();
        
    bool HasCapture() const;
        
    void Refresh(bool eraseBackground = true, const wxRect *rect = NULL );

    void RefreshRect(const wxRect& rect, bool eraseBackground = true);
    void Update();
    void ClearBackground();

    void Freeze();
    void Thaw();
    bool IsFrozen() const;

    void PrepareDC( wxDC & dc );

    bool IsDoubleBuffered() const;
    const wxRegion& GetUpdateRegion() const;

    wxRect GetUpdateClientRect() const;

    bool DoIsExposed( int x, int y ) const;
    bool DoIsExposed( int x, int y, int w, int h ) const;

    bool IsExposed( int x, int y ) const;
    bool IsExposed( int x, int y, int w, int h ) const;
    bool IsExposed( const wxPoint& pt ) const;
    bool IsExposed( const wxRect& rect ) const;
        
    /*
    wxVisualAttributes GetDefaultAttributes() const;
    static wxVisualAttributes
    GetClassDefaultAttributes(wxWindowVariant variant = wxWINDOW_VARIANT_NORMAL);
    */
        
    bool SetBackgroundColour(const wxColour& colour);
    void SetOwnBackgroundColour(const wxColour& colour);
    wxColour GetBackgroundColour() const;
    bool InheritsBackgroundColour() const;
    bool UseBgCol() const;

    bool SetForegroundColour(const wxColour& colour);
    void SetOwnForegroundColour(const wxColour& colour);
    wxColour GetForegroundColour() const;
        
    bool SetBackgroundStyle(wxBackgroundStyle style);
    wxBackgroundStyle GetBackgroundStyle() const;

    bool HasTransparentBackground();

    bool SetFont(const wxFont& font);
    void SetOwnFont(const wxFont& font);

    wxFont GetFont() const;
    bool SetCursor( const wxCursor &cursor );
    const wxCursor& GetCursor() const;

%If (wxUSE_CARET)
    void SetCaret(wxCaret *caret);
    wxCaret *GetCaret() const;
%End 
    int GetCharHeight() const;
    int GetCharWidth() const;

    void GetTextExtent(const wxString& string,
                               int *x, int *y,
                               int *descent = NULL,
                               int *externalLeading = NULL,
                               const wxFont *theFont = NULL) const;

    void ClientToScreen( int *x, int *y ) const;
    void ScreenToClient( int *x, int *y ) const;

    wxPoint ClientToScreen(const wxPoint& pt) const;
    wxPoint ScreenToClient(const wxPoint& pt) const;
        
    wxHitTest HitTest(wxCoord x, wxCoord y) const;
    wxHitTest HitTest(const wxPoint& pt) const;
    
    wxBorder GetBorder(long flags) const;
    wxBorder GetBorder() const;

    void UpdateWindowUI(long flags = wxUPDATE_UI_NONE);

%If (wxUSE_MENUS)
    bool PopupMenu(wxMenu *menu, const wxPoint& pos = wxDefaultPosition);
    bool PopupMenu(wxMenu *menu, int x, int y);
%End 
    
    bool HasMultiplePages() const;
    bool HasScrollbar(int orient) const;

    void SetScrollbar( int orient,
                               int pos,
                               int thumbvisible,
                               int range,
                               bool refresh = true );
    void SetScrollPos( int orient, int pos, bool refresh = true );
    int GetScrollPos( int orient ) const;
    int GetScrollThumb( int orient ) const;
    int GetScrollRange( int orient ) const;

    void ScrollWindow(int dx, int dy,
                      const wxRect* rect = NULL);

    bool ScrollLines(int lines);
    bool ScrollPages(int pages);

    bool LineUp();
    bool LineDown();
    bool PageUp();
    bool PageDown();

%If (wxUSE_HELP)
    void SetHelpText(const wxString& text);
    void SetHelpTextForId(const wxString& text);
/*    wxString GetHelpTextAtPoint(const wxPoint& pt,
                                        wxHelpEvent::Origin origin) const;
*/
//    wxString GetHelpText() const;
%End
%If (!wxUSE_HELP)
    void SetHelpText(const wxString& text);
    void SetHelpTextForId(const wxString& text);
%End 

%If (wxUSE_TOOLTIPS)
    void SetToolTip( const wxString &tip ) /PyName=SetToolTipString/;
    //void SetToolTip( wxToolTip *tip );
    //wxToolTip* GetToolTip() const;
    //wxString GetToolTipText() const;
%End
%If (!wxUSE_TOOLTIPS)
    void SetToolTip(const wxString & tip );
%End 

%If (wxUSE_DRAG_AND_DROP)
    void SetDropTarget( wxDropTarget *dropTarget );
    wxDropTarget *GetDropTarget() const;
%End 
/*
%If (wxUSE_CONSTRAINTS)

    void SetConstraints( wxLayoutConstraints *constraints );
    wxLayoutConstraints *GetConstraints() const;

    void UnsetConstraints(wxLayoutConstraints *c);
    wxWindowList *GetConstraintsInvolvedIn() const;
    void AddConstraintReference(wxWindowBase *otherWin);
    void RemoveConstraintReference(wxWindowBase *otherWin);
    void DeleteRelatedConstraints();
    void ResetConstraints();

    void SetConstraintSizes(bool recurse = true);
    bool LayoutPhase1(int *noChanges);
    bool LayoutPhase2(int *noChanges);
    bool DoPhase(int phase);

    void SetSizeConstraint(int x, int y, int w, int h);
    void MoveConstraint(int x, int y);
    void GetSizeConstraint(int *w, int *h) const;
    void GetClientSizeConstraint(int *w, int *h) const;
    void GetPositionConstraint(int *x, int *y) const;

%End 
*/
    void SetAutoLayout( bool autoLayout );
    bool GetAutoLayout() const;

    bool Layout();

    void SetSizer(wxSizer *sizer, bool deleteOld = true );
    void SetSizerAndFit( wxSizer *sizer, bool deleteOld = true );

    wxSizer *GetSizer() const;

    void SetContainingSizer(wxSizer* sizer);
    wxSizer *GetContainingSizer() const;

%If (wxUSE_ACCESSIBILITY)
    wxAccessible* CreateAccessible();
    void SetAccessible(wxAccessible* accessible);
    wxAccessible* GetAccessible();
    wxAccessible* GetOrCreateAccessible();
%End
    bool SetTransparent(wxByte alpha);
    bool CanSetTransparent();

    void OnSysColourChanged( wxSysColourChangedEvent& event );
    void OnInitDialog( wxInitDialogEvent &event );
    void OnMiddleClick( wxMouseEvent& event );


%If (wxUSE_PALETTE)
    wxPalette GetPalette() const;
    void SetPalette(const wxPalette& pal);

    bool HasCustomPalette() const;

    wxWindow *GetAncestorWithCustomPalette() const;
%End 
    void InheritAttributes();
    bool ShouldInheritColours() const;

private:
    wxWindow(const wxWindow&);
};
