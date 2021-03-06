/*
Reading up on SIP's /Transfer/ and its related annotations is probably a good
idea for understanding this file.
*/

enum
{
    wxEVT_MENU_CLOSE
};

class wxMenu : wxEvtHandler
{
public:
    wxMenu(const wxString& title = wxEmptyString, long style = 0) /Transfer/;
    virtual ~wxMenu();

    wxMenuItem* Append(int id, const wxString& text = wxEmptyString, const wxString& help = wxEmptyString, wxItemKind kind = wxITEM_NORMAL) /Transfer/;
    wxMenuItem* AppendSeparator() /Transfer/;
    wxMenuItem* AppendCheckItem(int id,
                                const wxString& text,
                                const wxString& help = wxEmptyString) /Transfer/;
    wxMenuItem* AppendRadioItem(int id,
                                const wxString& text,
                                const wxString& help = wxEmptyString) /Transfer/;

    wxMenuItem* Append(int id,
                       const wxString& text,
                       wxMenu *submenu /Transfer/,
                       const wxString& help = wxEmptyString) /PyName=AppendMenu, Transfer/;

    wxMenuItem* AppendSubMenu(wxMenu *submenu /Transfer/,
                              const wxString& text,
                              const wxString& help = wxEmptyString);

    wxMenuItem* Append(wxMenuItem *item /Transfer/) /PyName=AppendItem, Transfer/;
    wxMenuItem* Insert(size_t pos, wxMenuItem *item /Transfer/) /PyName=InsertItem, Transfer/;
    wxMenuItem* Prepend(wxMenuItem *item /Transfer/) /PyName=PrependItem, Transfer/;

    void Break();
    wxMenuItem* Insert(size_t pos,
                       int id,
                       const wxString& text = wxEmptyString,
                       const wxString& help = wxEmptyString,
                       wxItemKind kind = wxITEM_NORMAL) /Transfer/;
    wxMenuItem* InsertSeparator(size_t pos) /Transfer/;
    wxMenuItem* InsertCheckItem(size_t pos,
                                int id,
                                const wxString& text,
                                const wxString& help = wxEmptyString) /Transfer/;
    wxMenuItem* InsertRadioItem(size_t pos,
                                int id,
                                const wxString& text,
                                const wxString& help = wxEmptyString) /Transfer/;
    wxMenuItem* Insert(size_t pos,
                       int id,
                       const wxString& text,
                       wxMenu *submenu /Transfer/,
                       const wxString& help = wxEmptyString) /PyName=InsertMenu, Transfer/;

    wxMenuItem* Prepend(int id,
                        const wxString& text = wxEmptyString,
                        const wxString& help = wxEmptyString,
                        wxItemKind kind = wxITEM_NORMAL) /Transfer/;

    wxMenuItem*  PrependSeparator() /Transfer/;
    wxMenuItem* PrependCheckItem(int id,
                                 const wxString& text,
                                 const wxString& help = wxEmptyString) /Transfer/;

    wxMenuItem*  PrependRadioItem(int id,
                                  const wxString& text,
                                  const wxString& help = wxEmptyString) /Transfer/;

    wxMenuItem* Prepend(int id,
                        const wxString& text,
                        wxMenu *submenu /Transfer/,
                        const wxString& help = wxEmptyString) /PyName=PrependMenu, Transfer/;

    wxMenuItem *Remove(int id) /Factory/;
    wxMenuItem* Remove(wxMenuItem *item) /PyName=RemoveItem, Factory/;

    bool Delete(int id);
    bool Delete(wxMenuItem* item) /PyName=DeleteItem/;

    size_t GetMenuItemCount() const;
    wxMenuItemList& GetMenuItems();
    int FindItem(const wxString& item) const;
    wxMenuItem* FindItem(int id /*, wxMenu **menu = NULL*/) const /PyName=FindItemById/;
    wxMenuItem* FindItemByPosition(size_t position) const;

    void Enable(int id, bool enable);
    bool IsEnabled(int id) const;

    void Check(int id, bool check);
    bool IsChecked(int id) const;

    void SetLabel(int id, const wxString& label);
    wxString GetLabel(int id) const;

    void SetHelpString(int id, const wxString& helpString);
    wxString GetHelpString(int id) const;

    void SetTitle(const wxString& title);
    const wxString GetTitle() const;

    void SetEventHandler(wxEvtHandler *handler /Transfer/);
    wxEvtHandler *GetEventHandler() const /Transfer/;

    void SetInvokingWindow(wxWindow *win);
    wxWindow *GetInvokingWindow() const;

    long GetStyle() const;

    void UpdateUI(wxEvtHandler* source = NULL);
    wxMenuBar *GetMenuBar() const;

//    void Attach(wxMenuBarBase *menubar);
//    void Detach();

    bool IsAttached() const;
    void SetParent(wxMenu *parent);
    wxMenu *GetParent() const;

    wxString GetLabelText(int itemid) const;

%If (WXMSW)
    long GetHMenu() const;
%MethodCode
        sipRes = (long)sipCpp->GetHMenu();
%End




%End
};

class wxMenuBar : wxWindow
{
public:
    wxMenuBar(long style = 0);
    virtual ~wxMenuBar();

    bool Append(wxMenu *menu, const wxString& title);
    bool Insert(size_t pos, wxMenu *menu, const wxString& title);
    size_t GetMenuCount() const;

    wxMenu *GetMenu(size_t pos) const;
    wxMenu *Replace(size_t pos, wxMenu *menu, const wxString& title) /Factory/;
    wxMenu *Remove(size_t pos) /Factory/;

    void EnableTop(size_t pos, bool enable);
    bool IsEnabledTop(size_t pos) const;

    void SetLabelTop(size_t pos, const wxString& label);
    wxString GetLabelTop(size_t pos) const;

    int FindMenuItem(const wxString& menu, const wxString& item) const;

    wxMenuItem* FindItem(int id /*, wxMenu **menu = NULL*/) const /PyName=FindItemById/;
    int FindMenu(const wxString& title);

    void Enable(int id, bool enable);
    void Check(int id, bool check);
    bool IsChecked(int id) const;
    bool IsEnabled(int id) const;

    void SetLabel(int id, const wxString &label);
    wxString GetLabel(int id) const;

    void SetHelpString(int id, const wxString& helpString);
    wxString GetHelpString(int id) const;

    wxFrame *GetFrame() const;
    bool IsAttached() const;
    void Attach(wxFrame *frame);
    void Detach();
    void UpdateMenus();

%If (WXMAC)
    static void SetAutoWindowMenu( bool enable );
    static bool GetAutoWindowMenu();
%End

    wxString GetMenuLabel(size_t pos) const;
    void SetMenuLabel(size_t pos, const wxString& label);

    wxString GetMenuLabelText(size_t pos) const;

};

class wxMenuItem : wxObject /NoDefaultCtors/
{
private:
    wxMenuItem(const wxMenuItem&);
    virtual ~wxMenuItem();

public:
    wxMenuItem(wxMenu* parentMenu /TransferThis/ = NULL,
               int id = wxID_SEPARATOR,
               const wxString& text = wxEmptyString,
               const wxString& help = wxEmptyString,
               wxItemKind kind = wxITEM_NORMAL,
               wxMenu* subMenu = NULL);

    wxMenu *GetMenu() const;
    void SetMenu(wxMenu* menu);

    // get/set id
    void SetId(int id);
    int  GetId() const;
    bool IsSeparator() const;

    // the item's text (or name)
    //
    // NB: the item's text includes the accelerators and mnemonics info (if
    //     any), i.e. it may contain '&' or '_' or "\t..." and thus is
    //     different from the item's label which only contains the text shown
    //     in the menu
    void SetText(const wxString& str);
    wxString GetLabel() const;
    const wxString& GetText() const;

    // get the label from text
    static wxString GetLabelFromText(const wxString& text);

    // what kind of menu item we are
    wxItemKind GetKind() const;
    void SetKind(wxItemKind kind);

    void SetCheckable(bool checkable);
    bool IsCheckable() const;

    bool IsSubMenu() const;
    void SetSubMenu(wxMenu *menu);
    wxMenu *GetSubMenu() const;

    // state
    void Enable(bool enable = true);
    bool IsEnabled() const;

    void Check(bool check = true);
    bool IsChecked() const;
    void Toggle();

    // help string (displayed in the status bar by default)
    void SetHelp(const wxString& str);
    const wxString& GetHelp() const;

    // get our accelerator or NULL (caller must delete the pointer)
    wxAcceleratorEntry *GetAccel() const;

    // set the accel for this item - this may also be done indirectly with
    // SetText()
    void SetAccel(wxAcceleratorEntry *accel);

    void SetBitmap(const wxBitmap& bitmap);
    const wxBitmap& GetBitmap();
/*
%If (WXMSW)
    void SetFont(const wxFont& font);
    wxFont GetFont();
    void SetTextColour(const wxColour& colText);
    wxColour GetTextColour();
    void SetBackgroundColour(const wxColour& colBack);
    wxColour GetBackgroundColour();
    void SetBitmaps(const wxBitmap& bmpChecked,
                    const wxBitmap& bmpUnchecked = wxNullBitmap);

    void SetDisabledBitmap( const wxBitmap& bmpDisabled );
    const wxBitmap& GetDisabledBitmap() const;

    void SetMarginWidth(int nWidth);
    int GetMarginWidth();
    static int GetDefaultMarginWidth();
    bool IsOwnerDrawn();

    void SetOwnerDrawn(bool ownerDrawn = true);
    void ResetOwnerDrawn();
*/
    wxString GetItemLabel() const;
    void SetItemLabel(const wxString& str);

    wxString GetItemLabelText() const;
    static wxString GetLabelText(const wxString& label);


};
