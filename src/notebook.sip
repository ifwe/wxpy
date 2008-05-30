enum {
    wxBK_DEFAULT,
    wxBK_TOP,
    wxBK_BOTTOM,
    wxBK_LEFT,
    wxBK_RIGHT,
    wxBK_ALIGN_MASK,
    //wxBK_BUTTONBAR,

    // hittest flags
    wxBK_HITTEST_NOWHERE = 1,   // not on tab
    wxBK_HITTEST_ONICON  = 2,   // on icon
    wxBK_HITTEST_ONLABEL = 4,   // on label
    wxBK_HITTEST_ONITEM  = 6,
    wxBK_HITTEST_ONPAGE  = 8,   // not on tab control, but over the selected page
};

class wxBookCtrlBase : wxControl
{
public:
    size_t GetPageCount() const;
    wxWindow *GetPage(size_t n);
    wxWindow* GetCurrentPage() const;

    int GetSelection() const = 0;

    bool SetPageText(size_t n, const wxString& strText) = 0;
    wxString GetPageText(size_t n) const = 0;
/*
    virtual void SetImageList(wxImageList *imageList);
    // as SetImageList() but we will delete the image list ourselves
    %disownarg( wxImageList *imageList );
    void AssignImageList(wxImageList *imageList);
    %cleardisown( wxImageList *imageList );
    // get pointer (may be NULL) to the associated image list
    wxImageList* GetImageList() const;

*/
    int GetPageImage(size_t n) const = 0;
    bool SetPageImage(size_t n, int imageId) = 0;
    virtual void SetPageSize(const wxSize& size);
    virtual wxSize CalcSizeFromPage(const wxSize& sizePage) const = 0;
    unsigned int GetInternalBorder() const;
    void SetInternalBorder(unsigned int internalBorder);
    bool IsVertical() const;
    void SetControlMargin(int margin);
    int GetControlMargin() const;

    void SetFitToCurrentPage(bool fit);
    bool GetFitToCurrentPage() const;
    wxSizer* GetControlSizer() const;
    bool DeletePage(size_t n);
    bool RemovePage(size_t n);
    bool DeleteAllPages();
    bool AddPage(wxWindow *page,
                 const wxString& text,
                 bool select = false,
                 int imageId = -1);
    bool InsertPage(size_t n,
                            wxWindow *page,
                            const wxString& text,
                            bool select = false,
                            int imageId = -1);

    virtual int SetSelection(size_t n) = 0;
    virtual int ChangeSelection(size_t n) = 0;

    void AdvanceSelection(bool forward = true);

    int HitTest(const wxPoint& pt, long* where /Out/) const;
private:
   wxBookCtrlBase(const wxBookCtrlBase&);
};

class wxBookCtrlBaseEvent : wxNotifyEvent
{
public:
    wxBookCtrlBaseEvent(wxEventType commandType = wxEVT_NULL, int id = 0,
                    int nSel = -1, int nOldSel = -1);

    int GetSelection() const;
    void SetSelection(int nSel);

    int GetOldSelection() const;
    void SetOldSelection(int nOldSel);
};

enum {
    wxNB_FIXEDWIDTH,
    wxNB_TOP,
    wxNB_LEFT,
    wxNB_RIGHT,
    wxNB_BOTTOM,
    wxNB_MULTILINE,
    wxNB_NOPAGETHEME,

    wxNB_HITTEST_NOWHERE,
    wxNB_HITTEST_ONICON,
    wxNB_HITTEST_ONLABEL,
    wxNB_HITTEST_ONITEM,
    wxNB_HITTEST_ONPAGE,
};

class wxNotebook : wxBookCtrlBase
{
public:
    wxNotebook(wxWindow *parent /TransferThis/,
               wxWindowID id = -1,
               const wxPoint& pos = wxDefaultPosition,
               const wxSize& size = wxDefaultSize,
               long style = 0,
               const wxString& name = wxNotebookNameStr);
    virtual ~wxNotebook();

    int GetRowCount() const;
    void SetPadding(const wxSize& padding);
    void SetTabSize(const wxSize& sz);
    wxColour GetThemeBackgroundColour() const;
    bool SendPageChangingEvent(int nPage);
    void SendPageChangedEvent(int nPageOld, int nPageNew = -1);

    // overridden virtuals
    wxString GetPageText(size_t n) const;
    bool SetPageText(size_t n, const wxString& strText);

    wxSize CalcSizeFromPage(const wxSize& sizePage) const;

    int GetPageImage(size_t n) const;
    bool SetPageImage(size_t n, int imageId);

    int SetSelection(size_t n);
    int ChangeSelection(size_t n);
    int GetSelection() const;


};

class wxNotebookEvent : wxBookCtrlBaseEvent
{
public:
    wxNotebookEvent(wxEventType commandType = wxEVT_NULL, int id = 0,
                    int nSel = -1, int nOldSel = -1);
};

%PostInitialisationCode
add_event(sipModuleDict, "EVT_NOTEBOOK_PAGE_CHANGED", wxEVT_COMMAND_NOTEBOOK_PAGE_CHANGED, 0);
add_event(sipModuleDict, "EVT_NOTEBOOK_PAGE_CHANGING", wxEVT_COMMAND_NOTEBOOK_PAGE_CHANGING, 0);
%End


/*
enum
{
    // default alignment: left everywhere except Mac where it is top
    wxLB_DEFAULT = 0,

    // put the list control to the left/right/top/bottom of the page area
    wxLB_TOP    = 0x1,
    wxLB_BOTTOM = 0x2,
    wxLB_LEFT   = 0x4,
    wxLB_RIGHT  = 0x8,

    // the mask which can be used to extract the alignment from the style
    wxLB_ALIGN_MASK = 0xf,
};



MustHaveApp(wxListbook);

//  wxListCtrl and wxNotebook combination
class wxListbook : wxBookCtrlBase
{
public:
    %pythonAppend wxListbook         "self._setOORInfo(self)"
    %pythonAppend wxListbook()       ""

    wxListbook(wxWindow *parent,
               wxWindowID id=-1,
               const wxPoint& pos = wxDefaultPosition,
               const wxSize& size = wxDefaultSize,
               long style = 0,
               const wxString& name = wxPyEmptyString);
    %RenameCtor(PreListbook, wxListbook());

    bool Create(wxWindow *parent,
                wxWindowID id=-1,
                const wxPoint& pos = wxDefaultPosition,
                const wxSize& size = wxDefaultSize,
                long style = 0,
                const wxString& name = wxPyEmptyString);

    wxListView* GetListView();
    %property(ListView, GetListView, doc="See `GetListView`");
};



class wxListbookEvent : wxBookCtrlBaseEvent
{
public:
    wxListbookEvent(wxEventType commandType = wxEVT_NULL, int id = 0,
                    int nSel = -1, int nOldSel = -1);
};


%constant wxEventType wxEVT_COMMAND_LISTBOOK_PAGE_CHANGED;
%constant wxEventType wxEVT_COMMAND_LISTBOOK_PAGE_CHANGING;

%pythoncode {
    EVT_LISTBOOK_PAGE_CHANGED  = wx.PyEventBinder( wxEVT_COMMAND_LISTBOOK_PAGE_CHANGED, 1 )
    EVT_LISTBOOK_PAGE_CHANGING = wx.PyEventBinder( wxEVT_COMMAND_LISTBOOK_PAGE_CHANGING, 1 )
}


*/

/*
// wxChoiceBook

enum {
    wxCHB_DEFAULT,
    wxCHB_TOP,
    wxCHB_BOTTOM,
    wxCHB_LEFT,
    wxCHB_RIGHT,
    wxCHB_ALIGN_MASK
};


MustHaveApp(wxChoicebook);

class wxChoicebook : wxBookCtrlBase
{
public:
    %pythonAppend wxChoicebook         "self._setOORInfo(self)"
    %pythonAppend wxChoicebook()       ""

    wxChoicebook(wxWindow *parent,
                 wxWindowID id,
                 const wxPoint& pos = wxDefaultPosition,
                 const wxSize& size = wxDefaultSize,
                 long style = 0,
                 const wxString& name = wxPyEmptyString);
    %RenameCtor(PreChoicebook, wxChoicebook());

    // quasi ctor
    bool Create(wxWindow *parent,
                wxWindowID id,
                const wxPoint& pos = wxDefaultPosition,
                const wxSize& size = wxDefaultSize,
                long style = 0,
                const wxString& name = wxPyEmptyString);


    // returns the choice control
    wxChoice* GetChoiceCtrl() const;

    virtual bool DeleteAllPages();

    %property(ChoiceCtrl, GetChoiceCtrl, doc="See `GetChoiceCtrl`");

};


class wxChoicebookEvent : wxBookCtrlBaseEvent
{
public:
    wxChoicebookEvent(wxEventType commandType = wxEVT_NULL, int id = 0,
                      int nSel = -1, int nOldSel = -1);
};

%constant wxEventType wxEVT_COMMAND_CHOICEBOOK_PAGE_CHANGED;
%constant wxEventType wxEVT_COMMAND_CHOICEBOOK_PAGE_CHANGING;

%pythoncode {
    EVT_CHOICEBOOK_PAGE_CHANGED  = wx.PyEventBinder( wxEVT_COMMAND_CHOICEBOOK_PAGE_CHANGED, 1 )
    EVT_CHOICEBOOK_PAGE_CHANGING = wx.PyEventBinder( wxEVT_COMMAND_CHOICEBOOK_PAGE_CHANGING, 1 )
}

*/
/*
// wxTreeBook

class wxTreebook : wxBookCtrlBase
{
public:
    %pythonAppend wxTreebook         "self._setOORInfo(self)"
    %pythonAppend wxTreebook()       ""


    // This ctor creates the tree book control
    wxTreebook(wxWindow *parent,
               wxWindowID id,
               const wxPoint& pos = wxDefaultPosition,
               const wxSize& size = wxDefaultSize,
               long style = wxBK_DEFAULT,
               const wxString& name = wxPyEmptyString);

    %RenameCtor(PreTreebook, wxTreebook());


    // Really creates the control
    bool Create(wxWindow *parent,
                wxWindowID id,
                const wxPoint& pos = wxDefaultPosition,
                const wxSize& size = wxDefaultSize,
                long style = wxBK_DEFAULT,
                const wxString& name = wxPyEmptyString);


    // Notice that page pointer may be NULL in which case the next non NULL
    // page (usually the first child page of a node) is shown when this page is
    // selected

    // Inserts a new page just before the page indicated by page.
    // The new page is placed on the same level as page.
    virtual bool InsertPage(size_t pos,
                            wxWindow *page,
                            const wxString& text,
                            bool select = false,
                            int imageId = wxNOT_FOUND);

    // Inserts a new sub-page to the end of children of the page at given pos.
    virtual bool InsertSubPage(size_t pos,
                               wxWindow *page,
                               const wxString& text,
                               bool select = false,
                               int imageId = wxNOT_FOUND);

    // Adds a new page at top level after all other pages.
    virtual bool AddPage(wxWindow *page,
                         const wxString& text,
                         bool select = false,
                         int imageId = wxNOT_FOUND);

    // Adds a new child-page to the last top-level page inserted.
    // Useful when constructing 1 level tree structure.
    virtual bool AddSubPage(wxWindow *page,
                            const wxString& text,
                            bool select = false,
                            int imageId = wxNOT_FOUND);

    // Deletes the page and ALL its children. Could trigger page selection
    // change in a case when selected page is removed. In that case its parent
    // is selected (or the next page if no parent).
    virtual bool DeletePage(size_t pos);


    // Tree operations
    // ---------------

    // Gets the page node state -- node is expanded or collapsed
    virtual bool IsNodeExpanded(size_t pos) const;

    // Expands or collapses the page node. Returns the previous state.
    // May generate page changing events (if selected page
    // is under the collapsed branch, then parent is autoselected).
    virtual bool ExpandNode(size_t pos, bool expand = true);

    // shortcut for ExpandNode(pos, false)
    bool CollapseNode(size_t pos);

    // get the parent page or wxNOT_FOUND if this is a top level page
    int GetPageParent(size_t pos) const;

    // the tree control we use for showing the pages index tree
    wxPyTreeCtrl* GetTreeCtrl() const;

    %property(TreeCtrl, GetTreeCtrl, doc="See `GetTreeCtrl`");
};


class wxTreebookEvent : wxBookCtrlBaseEvent
{
public:
    wxTreebookEvent(wxEventType commandType = wxEVT_NULL, int id = 0,
                    int nSel = wxNOT_FOUND, int nOldSel = wxNOT_FOUND);
};

%constant wxEventType wxEVT_COMMAND_TREEBOOK_PAGE_CHANGED;
%constant wxEventType wxEVT_COMMAND_TREEBOOK_PAGE_CHANGING;
%constant wxEventType wxEVT_COMMAND_TREEBOOK_NODE_COLLAPSED;
%constant wxEventType wxEVT_COMMAND_TREEBOOK_NODE_EXPANDED;


%pythoncode {
    EVT_TREEBOOK_PAGE_CHANGED= wx.PyEventBinder( wxEVT_COMMAND_TREEBOOK_PAGE_CHANGED, 1 )
    EVT_TREEBOOK_PAGE_CHANGING= wx.PyEventBinder( wxEVT_COMMAND_TREEBOOK_PAGE_CHANGING, 1)
    EVT_TREEBOOK_NODE_COLLAPSED= wx.PyEventBinder( wxEVT_COMMAND_TREEBOOK_NODE_COLLAPSED, 1 )
    EVT_TREEBOOK_NODE_EXPANDED= wx.PyEventBinder( wxEVT_COMMAND_TREEBOOK_NODE_EXPANDED, 1 )
}

*/
/*
// TODO: wxToolbook

class wxToolbook : wxBookCtrlBase
{
public:
    %pythonAppend wxToolbook         "self._setOORInfo(self)"
    %pythonAppend wxToolbook()       ""


    // This ctor creates the tree book control
    wxToolbook(wxWindow *parent,
               wxWindowID id,
               const wxPoint& pos = wxDefaultPosition,
               const wxSize& size = wxDefaultSize,
               long style = wxBK_DEFAULT,
               const wxString& name = wxPyEmptyString);

    %RenameCtor(PreToolbook, wxToolbook());

    // quasi ctor
    bool Create(wxWindow *parent,
                wxWindowID id,
                const wxPoint& pos = wxDefaultPosition,
                const wxSize& size = wxDefaultSize,
                long style = 0,
                const wxString& name = wxEmptyString);


    wxToolBarBase* GetToolBar() const;

    // Not part of the wxBookctrl API, but must be called in OnIdle or
    // by application to realize the toolbar and select the initial page.
    void Realize();

    %property(ToolBar, GetToolBar, doc="See `GetToolBar`");
};


class wxToolbookEvent : wxBookCtrlBaseEvent
{
public:
    wxToolbookEvent(wxEventType commandType = wxEVT_NULL, int id = 0,
                    int nSel = wxNOT_FOUND, int nOldSel = wxNOT_FOUND);
};


%constant wxEventType wxEVT_COMMAND_TOOLBOOK_PAGE_CHANGED;
%constant wxEventType wxEVT_COMMAND_TOOLBOOK_PAGE_CHANGING;


%pythoncode {
    EVT_TOOLBOOK_PAGE_CHANGED = wx.PyEventBinder( wxEVT_COMMAND_TOOLBOOK_PAGE_CHANGED, 1)
    EVT_TOOLBOOK_PAGE_CHANGING = wx.PyEventBinder( wxEVT_COMMAND_TOOLBOOK_PAGE_CHANGING, 1)
}
*/
