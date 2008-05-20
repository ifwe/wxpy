/*
    wxTreeCtrl
*/

%ModuleHeaderCode
#include <wx/treectrl.h>
%End

enum
{
    wxTR_NO_BUTTONS,
    wxTR_HAS_BUTTONS,
    wxTR_NO_LINES,
    wxTR_LINES_AT_ROOT,

    wxTR_SINGLE,
    wxTR_MULTIPLE,
    wxTR_EXTENDED,
    wxTR_HAS_VARIABLE_ROW_HEIGHT,

    wxTR_EDIT_LABELS,
    wxTR_HIDE_ROOT,
    wxTR_ROW_LINES,

    wxTR_FULL_ROW_HIGHLIGHT,
    wxTR_DEFAULT_STYLE,

    wxTR_TWIST_BUTTONS,
};

enum wxTreeItemIcon
{
    wxTreeItemIcon_Normal,
    wxTreeItemIcon_Selected,
    wxTreeItemIcon_Expanded,
    wxTreeItemIcon_SelectedExpanded,
    wxTreeItemIcon_Max
};

enum
{
    wxTREE_HITTEST_ABOVE,
    wxTREE_HITTEST_BELOW,
    wxTREE_HITTEST_NOWHERE,
    wxTREE_HITTEST_ONITEMBUTTON,
    wxTREE_HITTEST_ONITEMICON,
    wxTREE_HITTEST_ONITEMINDENT,
    wxTREE_HITTEST_ONITEMLABEL,
    wxTREE_HITTEST_ONITEMRIGHT,
    wxTREE_HITTEST_ONITEMSTATEICON,
    wxTREE_HITTEST_TOLEFT,
    wxTREE_HITTEST_TORIGHT,
    wxTREE_HITTEST_ONITEMUPPERPART,
    wxTREE_HITTEST_ONITEMLOWERPART,
    wxTREE_HITTEST_ONITEM
};

class wxTreeItemId {
public:
    wxTreeItemId();
    ~wxTreeItemId(); 

    // is this a valid tree item?
    bool IsOk() const;

    bool Ok() const;
%MethodCode
    return sipCpp->IsOk();
%End

    int __nonzero__();
%MethodCode
        return (int)sipCpp->IsOk();
%End

    // __eq__
    bool operator ==(const wxTreeItemId& item) const;
};

%ModuleHeaderCode
class wxPyTreeItemData : public wxTreeItemData
{
public:
    wxPyTreeItemData(PyObject* obj = NULL)
    {
        Py_XINCREF(obj);
        m_obj = obj;
    }

    virtual ~wxPyTreeItemData();

    PyObject* GetData() const
    {
        return m_obj;
    }

    void SetData(PyObject* obj)
    {
        Py_XDECREF(m_obj);
        m_obj = obj;
        Py_INCREF(m_obj);
    }

protected:
    PyObject* m_obj;
};
%End

class wxPyTreeItemData
{
public:
    wxPyTreeItemData(SIP_PYOBJECT obj = NULL) /HoldGIL/;
    virtual ~wxPyTreeItemData();

    SIP_PYOBJECT GetData() /HoldGIL/;
    void SetData(SIP_PYOBJECT) /HoldGIL/;

    void Destroy();
%MethodCode
    delete self;
%End

private:
    wxPyTreeItemData(const wxPyTreeItemData&);
};

/*
class wxTreeItemData {
public:
    wxTreeItemData(SIP_PYOBJECT* obj = NULL);


    ~wxTreeItemData();
    
    PyObject* GetData();
    void      SetData(SIP_PYOBJECT* obj);

    const wxTreeItemId& GetId();
    void                SetId(const wxTreeItemId& id);
};
*/

/* TODO XXX

%pythoncode {
EVT_TREE_BEGIN_DRAG        = wx.PyEventBinder(wxEVT_COMMAND_TREE_BEGIN_DRAG       , 1)
EVT_TREE_BEGIN_RDRAG       = wx.PyEventBinder(wxEVT_COMMAND_TREE_BEGIN_RDRAG      , 1)
EVT_TREE_BEGIN_LABEL_EDIT  = wx.PyEventBinder(wxEVT_COMMAND_TREE_BEGIN_LABEL_EDIT , 1)
EVT_TREE_END_LABEL_EDIT    = wx.PyEventBinder(wxEVT_COMMAND_TREE_END_LABEL_EDIT   , 1)
EVT_TREE_DELETE_ITEM       = wx.PyEventBinder(wxEVT_COMMAND_TREE_DELETE_ITEM      , 1)
EVT_TREE_GET_INFO          = wx.PyEventBinder(wxEVT_COMMAND_TREE_GET_INFO         , 1)
EVT_TREE_SET_INFO          = wx.PyEventBinder(wxEVT_COMMAND_TREE_SET_INFO         , 1)
EVT_TREE_ITEM_EXPANDED     = wx.PyEventBinder(wxEVT_COMMAND_TREE_ITEM_EXPANDED    , 1)
EVT_TREE_ITEM_EXPANDING    = wx.PyEventBinder(wxEVT_COMMAND_TREE_ITEM_EXPANDING   , 1)
EVT_TREE_ITEM_COLLAPSED    = wx.PyEventBinder(wxEVT_COMMAND_TREE_ITEM_COLLAPSED   , 1)
EVT_TREE_ITEM_COLLAPSING   = wx.PyEventBinder(wxEVT_COMMAND_TREE_ITEM_COLLAPSING  , 1)
EVT_TREE_SEL_CHANGED       = wx.PyEventBinder(wxEVT_COMMAND_TREE_SEL_CHANGED      , 1)
EVT_TREE_SEL_CHANGING      = wx.PyEventBinder(wxEVT_COMMAND_TREE_SEL_CHANGING     , 1)
EVT_TREE_KEY_DOWN          = wx.PyEventBinder(wxEVT_COMMAND_TREE_KEY_DOWN         , 1)
EVT_TREE_ITEM_ACTIVATED    = wx.PyEventBinder(wxEVT_COMMAND_TREE_ITEM_ACTIVATED   , 1)
EVT_TREE_ITEM_RIGHT_CLICK  = wx.PyEventBinder(wxEVT_COMMAND_TREE_ITEM_RIGHT_CLICK , 1)
EVT_TREE_ITEM_MIDDLE_CLICK = wx.PyEventBinder(wxEVT_COMMAND_TREE_ITEM_MIDDLE_CLICK, 1)
EVT_TREE_END_DRAG          = wx.PyEventBinder(wxEVT_COMMAND_TREE_END_DRAG         , 1)
EVT_TREE_STATE_IMAGE_CLICK = wx.PyEventBinder(wxEVT_COMMAND_TREE_STATE_IMAGE_CLICK, 1)
EVT_TREE_ITEM_GETTOOLTIP   = wx.PyEventBinder(wxEVT_COMMAND_TREE_ITEM_GETTOOLTIP,   1)
EVT_TREE_ITEM_MENU         = wx.PyEventBinder(wxEVT_COMMAND_TREE_ITEM_MENU,         1)
}

static wxTreeItemId wxNullTreeItemId;
*/

class wxTreeEvent : wxNotifyEvent
{
public:
    wxTreeEvent(wxEventType commandType = wxEVT_NULL, int id = 0);
    wxTreeEvent(wxEventType commandType, wxTreeCtrl* tree, wxTreeItemId& item = wxNullTreeItemId);

    wxTreeItemId GetItem() const;
    void SetItem(const wxTreeItemId& item);

    wxTreeItemId GetOldItem() const;
    void SetOldItem(const wxTreeItemId& item);

    wxPoint GetPoint() const;
    void SetPoint(const wxPoint& pt);

    const wxKeyEvent& GetKeyEvent() const;
    int GetKeyCode() const;
    void SetKeyEvent(const wxKeyEvent& evt);

    const wxString& GetLabel() const;
    void SetLabel(const wxString& label);

    bool IsEditCancelled() const;
    void SetEditCanceled(bool editCancelled);

    void SetToolTip(const wxString& toolTip);
    wxString GetToolTip();
};

class wxTreeCtrl : wxControl {
public:
    wxTreeCtrl(wxWindow *parent, wxWindowID id,
                 const wxPoint& pos,
                 const wxSize& size,
                 long style,
                 const wxValidator& validator,
                 const wxString& name);

    unsigned int GetCount() const;

    unsigned int GetIndent() const;
    void SetIndent(unsigned int indent);

    unsigned int GetSpacing() const;
    void SetSpacing(unsigned int spacing);

//    wxImageList *GetImageList() const;
//    wxImageList *GetStateImageList() const;
//
//    void SetImageList(wxImageList *imageList);
//    void SetStateImageList(wxImageList *imageList);

/*
    %disownarg( wxImageList *imageList );
    void AssignImageList(wxImageList *imageList);
    void AssignStateImageList(wxImageList *imageList);
    %cleardisown( wxImageList *imageList );
 */   
    wxString GetItemText(const wxTreeItemId& item) const;
    
    int GetItemImage(const wxTreeItemId& item, wxTreeItemIcon which = wxTreeItemIcon_Normal) const;
/*
    %extend {
        // get the wxPyTreeItemData associated with the tree item
        wxPyTreeItemData* GetItemData(const wxTreeItemId& item) {
            wxPyTreeItemData* data = (wxPyTreeItemData*)self->GetItemData(item);
            if (data == NULL) {
                data = new wxPyTreeItemData();
                data->SetId(item); // set the id
                self->SetItemData(item, data);
            }
            return data;
        }
        // Get the Python object associated with the tree item
        PyObject* GetItemPyData(const wxTreeItemId& item) {
            wxPyTreeItemData* data = (wxPyTreeItemData*)self->GetItemData(item);
            if (data == NULL) {
                data = new wxPyTreeItemData();
                data->SetId(item); // set the id
                self->SetItemData(item, data);
            }
            return data->GetData();
        }
    }
    %pythoncode { GetPyData = GetItemPyData }
 */       
    wxColour GetItemTextColour(const wxTreeItemId& item) const;
    wxColour GetItemBackgroundColour(const wxTreeItemId& item) const;
    wxFont GetItemFont(const wxTreeItemId& item) const;

    void SetItemText(const wxTreeItemId& item, const wxString& text);
    void SetItemImage(const wxTreeItemId& item, int image,
                      wxTreeItemIcon which = wxTreeItemIcon_Normal);
/*
    %extend {
        // associate a wxPyTreeItemData with the tree item
        %disownarg( wxPyTreeItemData* data );
        void SetItemData(const wxTreeItemId& item, wxPyTreeItemData* data) {
            data->SetId(item); // set the id
            self->SetItemData(item, data);
        }
        %cleardisown( wxPyTreeItemData* data );

        // associate a Python object with the tree item
        void SetItemPyData(const wxTreeItemId& item, PyObject* obj) {
            wxPyTreeItemData* data = (wxPyTreeItemData*)self->GetItemData(item);
            if (data == NULL) {
                data = new wxPyTreeItemData(obj);
                data->SetId(item); // set the id
                self->SetItemData(item, data);
            } else
                data->SetData(obj);
        }
    }
    %pythoncode { SetPyData = SetItemPyData }

*/
    void SetItemHasChildren(const wxTreeItemId& item, bool has = true);
    void SetItemBold(const wxTreeItemId& item, bool bold = true);
    void SetItemDropHighlight(const wxTreeItemId& item, bool highlight = true);
    void SetItemTextColour(const wxTreeItemId& item, const wxColour& col);
    void SetItemBackgroundColour(const wxTreeItemId& item, const wxColour& col);
    void SetItemFont(const wxTreeItemId& item, const wxFont& font);

    bool IsVisible(const wxTreeItemId& item) const;
    bool ItemHasChildren(const wxTreeItemId& item) const;
    bool IsExpanded(const wxTreeItemId& item) const;
    bool IsSelected(const wxTreeItemId& item) const;
    bool IsBold(const wxTreeItemId& item) const;
    bool IsEmpty() const;

    size_t GetChildrenCount(const wxTreeItemId& item,
                            bool recursively = true) const;

    wxTreeItemId GetRootItem() const;
    wxTreeItemId GetSelection() const;
/*
    %extend {
        // get the items currently selected, return the number of such item
        //
        // NB: this operation is expensive and can take a long time for a
        //     control with a lot of items (~ O(number of items)).
        PyObject* GetSelections() {
            wxPyBlock_t blocked = wxPyBeginBlockThreads();
            PyObject*           rval = PyList_New(0);
            wxArrayTreeItemIds  array;
            size_t              num, x;
            num = self->GetSelections(array);
            for (x=0; x < num; x++) {
                wxTreeItemId *tii = new wxTreeItemId(array.Item(x));
                PyObject* item = wxPyConstructObject((void*)tii, wxT("wxTreeItemId"), true);
                PyList_Append(rval, item);
                Py_DECREF(item);
            }
            wxPyEndBlockThreads(blocked);
            return rval;
        }
    }
*/
    wxTreeItemId GetItemParent(const wxTreeItemId& item) const;
/*
    // NOTE: These are a copy of the same methods in gizmos.i, be sure to
    // update both at the same time.  (Or find a good way to refactor!)
    %extend {
        // Get the first child of this item.  Returns a wxTreeItemId and an
        // opaque "cookie" value that should be passed to GetNextChild in
        // order to continue the search.
        PyObject* GetFirstChild(const wxTreeItemId& item) {
            void* cookie = 0;
            wxTreeItemId* ritem = new wxTreeItemId(self->GetFirstChild(item, cookie));
            wxPyBlock_t blocked = wxPyBeginBlockThreads();
            PyObject* tup = PyTuple_New(2);
            PyTuple_SET_ITEM(tup, 0, wxPyConstructObject(ritem, wxT("wxTreeItemId"), true));
            PyTuple_SET_ITEM(tup, 1, wxPyMakeSwigPtr(cookie, wxT("void")));
            wxPyEndBlockThreads(blocked);
            return tup;
        }


        // Get the next child of this item.  The cookie parameter is the 2nd
        // value returned from GetFirstChild or the previous GetNextChild.
        // Returns a wxTreeItemId and an opaque "cookie" value that should be
        // passed to GetNextChild in order to continue the search.
        PyObject* GetNextChild(const wxTreeItemId& item, void* cookie) {
            wxTreeItemId* ritem = new wxTreeItemId(self->GetNextChild(item, cookie));
            wxPyBlock_t blocked = wxPyBeginBlockThreads();
            PyObject* tup = PyTuple_New(2);
            PyTuple_SET_ITEM(tup, 0, wxPyConstructObject(ritem, wxT("wxTreeItemId"), true));
            PyTuple_SET_ITEM(tup, 1, wxPyMakeSwigPtr(cookie, wxT("void")));
            wxPyEndBlockThreads(blocked);
            return tup;
        }            
    }
 */   
    wxTreeItemId GetLastChild(const wxTreeItemId& item) const;
    wxTreeItemId GetNextSibling(const wxTreeItemId& item) const;
    wxTreeItemId GetPrevSibling(const wxTreeItemId& item) const;
    wxTreeItemId GetFirstVisibleItem() const;
    wxTreeItemId GetNextVisible(const wxTreeItemId& item) const;
    wxTreeItemId GetPrevVisible(const wxTreeItemId& item) const;
    
    // %disownarg( wxPyTreeItemData* data );
    
    wxTreeItemId AddRoot(const wxString& text,
                         int image = -1, int selectedImage = -1,
                         wxPyTreeItemData *data /Transfer/ = NULL);

    wxTreeItemId PrependItem(const wxTreeItemId& parent,
                             const wxString& text,
                             int image = -1, int selectedImage = -1,
                             wxPyTreeItemData *data /Transfer/ = NULL);

    wxTreeItemId InsertItem(const wxTreeItemId& parent,
                            const wxTreeItemId& idPrevious,
                            const wxString& text,
                            int image = -1, int selectedImage = -1,
                            wxPyTreeItemData *data /Transfer/ = NULL);

    wxTreeItemId InsertItem(const wxTreeItemId& parent,
                            size_t index,
                            const wxString& text,
                            int image = -1, int selectedImage = -1,
                            wxPyTreeItemData *data /Transfer/ = NULL) /PyName=InsertItemBefore/;

    wxTreeItemId AppendItem(const wxTreeItemId& parent,
                            const wxString& text,
                            int image = -1, int selectedImage = -1,
                            wxPyTreeItemData *data /Transfer/ = NULL);

    // %cleardisown( wxPyTreeItemData* data );
    
    void Delete(const wxTreeItemId& item);
    void DeleteChildren(const wxTreeItemId& item);
    void DeleteAllItems();

    void Expand(const wxTreeItemId& item);
    void ExpandAllChildren(const wxTreeItemId& item);
    void ExpandAll();

    void Collapse(const wxTreeItemId& item);
    void CollapseAllChildren(const wxTreeItemId& item);
    void CollapseAll();
    void CollapseAndReset(const wxTreeItemId& item);

    void Toggle(const wxTreeItemId& item);

    void Unselect();
    void UnselectItem(const wxTreeItemId& item);
    void UnselectAll();
    void SelectItem(const wxTreeItemId& item, bool select = true);
    void ToggleItemSelection(const wxTreeItemId& item);
    
    void EnsureVisible(const wxTreeItemId& item);
    void ScrollTo(const wxTreeItemId& item);

    /**wxTextCtrl* */ void  EditLabel(const wxTreeItemId& item);
    wxTextCtrl* GetEditControl() const;

%If (WXMSW)
    // end editing and accept or discard the changes to item label
    void EndEditLabel(const wxTreeItemId& item, bool discardChanges = false);
%End

    void SortChildren(const wxTreeItemId& item);

    wxTreeItemId HitTest(const wxPoint& point, int& where /Out/);
/*

    %extend {
        // get the bounding rectangle of the item (or of its label only)
        PyObject* GetBoundingRect(const wxTreeItemId& item,  bool textOnly = false) {
             wxRect rect;
            if (self->GetBoundingRect(item, rect, textOnly)) {
                wxPyBlock_t blocked = wxPyBeginBlockThreads();
                wxRect* r = new wxRect(rect);
                PyObject* val = wxPyConstructObject((void*)r, wxT("wxRect"), true);
                wxPyEndBlockThreads(blocked);
                return val;
            }
            else
                RETURN_NONE();
        }
    }
*/
%If (WXMSW)
    // set/get the item state.image (state == -1 means cycle to the next one)
    void SetState(const wxTreeItemId& node, int state);
    int GetState(const wxTreeItemId& node);
%End

    void SetQuickBestSize(bool q);
    bool GetQuickBestSize() const;
};

