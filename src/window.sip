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
#ifndef WXPY_PREC
#include <wx/window.h>
#include <wx/dynlib.h>
#endif
%End

public:
    wxWindow(wxWindow* parent /TransferThis/,
             const wxWindowID id = wxID_ANY,
             const wxPoint& pos = wxDefaultPosition,
             const wxSize& size = wxDefaultSize,
             long style = 0,
             const wxString& name = wxPanelNameStr);
    virtual ~wxWindow();

    void Raise();
    void Lower();



    void Destroy();

    wxSize GetSize() const;

    void InvalidateBestSize();
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
    void SetVirtualSizeHints(int minW, int minH, int maxW=-1, int maxH=-1);
    wxSize GetBestSize() const;

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

    void SetFocus();
    void SetFocusFromKbd();
    static wxWindow *FindFocus();

    bool AcceptsFocus() const;
    bool AcceptsFocusFromKeyboard() const;

    bool Navigate(int flags = wxNavigationKeyEvent::IsForward);

    void MoveBeforeInTabOrder(wxWindow *win);
    void MoveAfterInTabOrder(wxWindow *win);

    const wxWindowList& GetChildren() const;
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
/*
%If (WXMSW)
    static wxWindow *FindWindowByHandle(long hwnd);
%MethodCode
    sipRes = wxFindWinFromHandle((WXHWND)a0);
%End
%End
*/

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
    void SetAcceleratorTable(const wxAcceleratorTable& accel);
    wxAcceleratorTable *GetAcceleratorTable();
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
    bool SetCursor(const wxCursor &cursor);
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

    void SetSizer(wxSizer *sizer /Transfer/, bool deleteOld = true);
%MethodCode
        const bool deleteOld = a1;

        printf("wxWindow::SetSizer(%p, deleteOld = %d)\n", a0, deleteOld);
        sipCpp->SetSizer(a0, deleteOld);
/*
        wxSizer* oldSizerCpp = sipCpp->GetSizer();
        if (oldSizerCpp) {
            printf("oldSizer was not NULL: %p\n", oldSizerCpp);
            PyObject* oldSizerPy = sipGetWrapper(oldSizerCpp, sipClass_wxSizer);
            if (oldSizerPy) {
                printf("oldSizer had a Python object: %p", oldSizerPy);
                if (deleteOld && sipWrapper_Check(oldSizerPy)) {
                    sipWrapper* w = (sipWrapper*)oldSizerPy;
                    printf("UNHOOKING SIP OBJECT\n");
                    removeFromParent(w);
                    sipResetPyOwned(w);
                    w->u.cppPtr = NULL;
                }
            }
        }
        sipCpp->SetSizer(a0, deleteOld);
*/
%End

    void SetSizerAndFit(wxSizer *sizer /Transfer/, bool deleteOld = true);

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

    void SetName(const wxString& name);
    wxString GetName() const;
    void SetLabel(const wxString& label);
    wxString GetLabel() const;


    wxWindowID GetId() const;
    static int NewControlId();
    void SetSize(const wxSize& size);
    void SetSize(const wxRect& rect, int sizeFlags = wxSIZE_AUTO) /PyName=SetRect/;
    void SetInitialSize(const wxSize& size = wxDefaultSize);

    void SetId(int id);

    void Move(const wxPoint& pt, int flags = wxSIZE_USE_EXISTING);

    wxPoint GetPosition() const;
    void SetPosition(const wxPoint& pos);
%MethodCode
    sipCpp->Move(*a0);
%End


    wxPoint GetScreenPosition() const;
    wxRect  GetScreenRect() const;
    wxRect  GetRect() const;
    wxSize  GetClientSize() const;
    wxRect  GetClientRect() const;

    void SetClientSize(const wxSize& size);
    void SetClientSize(int width, int height) /PyName=SetClientSizeWH/;
    void SetClientSize(const wxRect& rect) /PyName=SetClientRect/;

    void Close(bool force = false);

%If (WXMSW)
    int GetHandle();
%MethodCode
    sipRes = (int)sipCpp->GetHWND();
%End
%End

%If (WXMSW)
    static int GetUserIdleTime();
%MethodCode
    typedef BOOL (WINAPI *_GetLastInputInfo_t)(PLASTINPUTINFO);

    static _GetLastInputInfo_t s_pfn_GetLastInputInfo = 0;

    wxDynamicLibrary dllUser32(_T("user32.dll"), wxDL_VERBATIM);
    if (dllUser32.IsLoaded()) {
        s_pfn_GetLastInputInfo = (_GetLastInputInfo_t)
            dllUser32.GetSymbol(_T("GetLastInputInfo"));

        if (s_pfn_GetLastInputInfo == 0) {
            printf("ERROR: got 0 from GetSymbol\n");
        } else {
            printf("Got function pointer: %p\n", s_pfn_GetLastInputInfo);

            LASTINPUTINFO info = {sizeof(LASTINPUTINFO), 0};
            if (0 == (*s_pfn_GetLastInputInfo)(&info)) {
                PyErr_SetString(PyExc_Exception, "GetLastInputInfo returned error");
                sipIsErr = 1;
            } else
                sipRes = (int)info.dwTime;
        }
    } else
        printf("could not load user32.dll\n");
%End
%End


private:
    wxWindow(const wxWindow&);
};
