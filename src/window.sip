enum wxWindowVariant
{
    wxWINDOW_VARIANT_NORMAL,        // Normal size
    wxWINDOW_VARIANT_SMALL,         // Smaller size (about 25 % smaller than normal )
    wxWINDOW_VARIANT_MINI,          // Mini size (about 33 % smaller than normal )
    wxWINDOW_VARIANT_LARGE,         // Large size (about 25 % larger than normal )
    wxWINDOW_VARIANT_MAX
};


class wxWindowBase : wxEvtHandler
{
private:
    wxWindowBase();
    virtual ~wxWindowBase();
    wxWindowBase(const wxWindowBase&);
};

wxWindow* WindowBaseDowncast(wxWindowBase* window);
%MethodCode
    sipRes = dynamic_cast<wxWindow*>(a0);
%End

class wxWindow : wxWindowBase
{
%TypeHeaderCode
#include <wx/window.h>
#include <wx/dynlib.h>
%End

%ConvertToSubClassCode
wxClassInfo* c = sipCpp->GetClassInfo();

if(0) ;
#define C(clz) else if (c == CLASSINFO(clz)) { sipClass = sipClass_ ## clz; }
    C(wxWindow)
    C(wxFrame)
    C(wxDialog)
    C(wxTopLevelWindow)
    C(wxPopupWindow)
    C(wxTextCtrl)
    C(wxButton)
    C(wxListCtrl)
    C(wxRadioButton)
    C(wxCheckBox)
else
    sipClass = NULL;
#undef C
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
    void DestroyChildren();

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
    bool Shown;
%GetCode
    sipPy = PyBool_FromLong(sipCpp->IsShown());
%End
%SetCode
    sipCpp->Show(0 != PyObject_IsTrue(sipPy));
%End

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
    bool Reparent(wxWindow *newParent /Transfer/);

    wxWindow *FindWindow(long winid) const;
    wxWindow *FindWindow(const wxString& name) const;


    static wxWindow *FindWindowById( long winid, const wxWindow *parent = NULL );
    static wxWindow *FindWindowByName( const wxString& name,
                                       const wxWindow *parent = NULL );
    static wxWindow *FindWindowByLabel( const wxString& label,
                                        const wxWindow *parent = NULL );

    wxEvtHandler *GetEventHandler() const;
    void SetEventHandler(wxEvtHandler *handler /Transfer/);

    void PushEventHandler(wxEvtHandler *handler /Transfer/);
    wxEvtHandler *PopEventHandler( bool deleteHandler = false ) /Factory/;
    bool RemoveEventHandler(wxEvtHandler *handler);

%If (wxUSE_VALIDATORS)
    //void SetValidator( const wxValidator &validator );
    //wxValidator *GetValidator();
%End
    bool Validate();

    bool TransferDataToWindow();
    bool TransferDataFromWindow();

    void InitDialog();

%If (wxUSE_ACCEL)
    void SetAcceleratorTable(const wxAcceleratorTable& accel);
    //wxAcceleratorTable *GetAcceleratorTable();
%End

%If (wxUSE_HOTKEY)
    bool RegisterHotKey(int hotkeyId, int modifiers, int keycode);
    bool UnregisterHotKey(int hotkeyId);
%End

    wxPoint ConvertPixelsToDialog(const wxPoint& pt);
    wxPoint ConvertDialogToPixels(const wxPoint& pt) /PyName=ConvertDialogPointToPixels/;
    wxSize ConvertPixelsToDialog(const wxSize& sz);
    wxSize ConvertDialogToPixels(const wxSize& sz);

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

    void SetOwnFont(const wxFont& font);

    wxFont GetFont() const;
    void SetFont(const wxFont& font);

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
    //void SetToolTip(const wxString &tip) /PyName=SetToolTipString/;
    void SetToolTip(wxToolTip *tip /Transfer/);
    wxToolTip* GetToolTip() const;
    //wxString GetToolTipText() const;
%End
%If (!wxUSE_TOOLTIPS)
    //void SetToolTip(const wxString & tip);
%End

%If (wxUSE_DRAG_AND_DROP)
    void SetDropTarget(wxDropTarget *dropTarget /Transfer/);
    wxDropTarget *GetDropTarget() const;
%End

%If (wxUSE_CONSTRAINTS)
    void SetConstraints(wxLayoutConstraints *constraints);
    wxLayoutConstraints *GetConstraints() const;

    void UnsetConstraints(wxLayoutConstraints *c);
    wxWindowList *GetConstraintsInvolvedIn() const;
    void AddConstraintReference(wxWindowBase *otherWin);
    void RemoveConstraintReference(wxWindowBase *otherWin);
    void DeleteRelatedConstraints();
    void ResetConstraints();

    void RemoveChild(wxWindow* child);

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

    void SetAutoLayout(bool autoLayout);
    bool GetAutoLayout() const;

    bool Layout();

    void SetSizer(wxSizer *sizer /Transfer/, bool deleteOld = true);
    wxSizer *GetSizer() const;

    void SetSizerAndFit(wxSizer *sizer /Transfer/, bool deleteOld = true);

    //void SetContainingSizer(wxSizer* sizer /Transfer/);
    wxSizer *GetContainingSizer() const /Transfer/;

%If (wxUSE_ACCESSIBILITY)
    wxAccessible* CreateAccessible();
    void SetAccessible(wxAccessible* accessible);
    wxAccessible* GetAccessible();
    wxAccessible* GetOrCreateAccessible();
%End
    bool SetTransparent(wxByte alpha);
    bool CanSetTransparent();

    void OnSysColourChanged(wxSysColourChangedEvent& event);
    void OnInitDialog(wxInitDialogEvent &event);
    void OnMiddleClick(wxMouseEvent& event);


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

    bool Close(bool force = false);

%If (WXMSW)
    // TODO: on 64bit compiles this is definitely not a 32bit int!
    int GetHandle();
%MethodCode
    sipRes = (int)sipCpp->GetHWND();
%End
%End

    long Handle;
%GetCode
    sipPy = PyLong_FromLong((long)(sipCpp->GetHWND()));
%End
%SetCode
    (void)sipPy;
    (void)sipCpp;
    PyErr_SetString(PyExc_AssertionError, "Handle is read only");
    sipErr = 1;
%End

    virtual wxLayoutDirection GetLayoutDirection() const;
    virtual void SetLayoutDirection(wxLayoutDirection dir);

private:
    wxWindow(const wxWindow&);
};
