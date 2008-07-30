/*
    wxTreeCtrl
*/

%ModuleHeaderCode
#ifndef WXPY_PREC
#include <wx/treectrl.h>
#endif
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

class wxTreeItemId
{
public:
    wxTreeItemId();
    ~wxTreeItemId();

    // is this a valid tree item?
    bool IsOk() const;

    bool Ok() const;
%MethodCode
    sipRes = sipCpp->IsOk();
%End

    int __nonzero__();
%MethodCode
    sipRes = (int)sipCpp->IsOk();
%End

    bool operator ==(const wxTreeItemId* other) const;
%MethodCode
    sipRes = a0 ? (*sipCpp == *a0) : false;
%End

};

%ModuleHeaderCode

static wxTreeItemId wxNullTreeItemId;

#include <sip.h>

class wxPyTreeItemData : public wxTreeItemData
{
public:
    wxPyTreeItemData(PyObject* obj = NULL)
    {
        SIP_BLOCK_THREADS
        Py_XINCREF(obj);
        m_obj = obj;
        SIP_UNBLOCK_THREADS
    }

    virtual ~wxPyTreeItemData()
    {
        SIP_BLOCK_THREADS
        Py_XDECREF(m_obj);
        m_obj = NULL;
        SIP_UNBLOCK_THREADS
    }


    PyObject* GetData() const
    {
        Py_XINCREF(m_obj);
        return m_obj;
    }

    void SetData(PyObject* obj)
    {
        Py_XDECREF(m_obj);
        m_obj = obj;
        Py_XINCREF(m_obj);
    }

    bool operator==(const wxPyTreeItemData& other) const
    {
        return m_obj == other.m_obj;
    }

protected:
    PyObject* m_obj;
};
%End

class wxPyTreeItemData
{
private:
    wxPyTreeItemData(const wxPyTreeItemData&);

public:
    wxPyTreeItemData(SIP_PYOBJECT obj = NULL) /HoldGIL/;
    virtual ~wxPyTreeItemData();

    /*
%GCTraverseCode
    fprintf(stderr, "wxPyTreeItemData::GCTraverseCode\n");
    PyObject *obj = reinterpret_cast<PyObject *>(sipCpp->GetData());
    sipRes = obj ? sipVisit(obj, sipArg) : 0;
%End

%GCClearCode
    fprintf(stderr, "wxPyTreeItemData::GCClearCode\n");
    sipCpp->SetData(0); // derefs for us
    sipRes = 0;
%End
*/

    bool operator==(const wxPyTreeItemData& other) const;

    SIP_PYOBJECT GetData() /HoldGIL/;
    void SetData(SIP_PYOBJECT) /HoldGIL/;

    void Destroy();
%MethodCode
    delete sipCpp;
%End

};

%PostInitialisationCode

#define TREE_EVT(name) add_event(sipModuleDict, "EVT_TREE_" #name, wxEVT_COMMAND_TREE_##name, 0);

TREE_EVT(BEGIN_DRAG)
TREE_EVT(BEGIN_RDRAG)
TREE_EVT(BEGIN_LABEL_EDIT)
TREE_EVT(END_LABEL_EDIT)
TREE_EVT(DELETE_ITEM)
TREE_EVT(GET_INFO)
TREE_EVT(SET_INFO)
TREE_EVT(ITEM_EXPANDED)
TREE_EVT(ITEM_EXPANDING)
TREE_EVT(ITEM_COLLAPSED)
TREE_EVT(ITEM_COLLAPSING)
TREE_EVT(SEL_CHANGED)
TREE_EVT(SEL_CHANGING)
TREE_EVT(KEY_DOWN)
TREE_EVT(ITEM_ACTIVATED)
TREE_EVT(ITEM_RIGHT_CLICK)
TREE_EVT(ITEM_MIDDLE_CLICK)
TREE_EVT(END_DRAG)
TREE_EVT(STATE_IMAGE_CLICK)
TREE_EVT(ITEM_GETTOOLTIP)
TREE_EVT(ITEM_MENU)

%End // PostInitialisationCode

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

long PyAddress(SIP_PYOBJECT);
%MethodCode
    sipRes = (long)a0;
%End

class wxTreeCtrl : wxControl
{
public:
    wxTreeCtrl(wxWindow *parent /TransferThis/, wxWindowID id = wxID_ANY,
                 const wxPoint& pos = wxDefaultPosition,
                 const wxSize& size = wxDefaultSize,
                 long style = wxTR_DEFAULT_STYLE,
                 const wxValidator& validator = wxDefaultValidator,
                 const wxString& name = wxTreeCtrlNameStr);

    unsigned int GetCount() const;

    unsigned int GetIndent() const;
    void SetIndent(unsigned int indent);

    unsigned int GetSpacing() const;
    void SetSpacing(unsigned int spacing);

    wxImageList *GetImageList() const;
    wxImageList *GetStateImageList() const;

    void SetImageList(wxImageList *imageList);
    void SetStateImageList(wxImageList *imageList);

    void AssignImageList(wxImageList *imageList /Transfer/);
    void AssignStateImageList(wxImageList *imageList /Transfer/);

    wxString GetItemText(const wxTreeItemId& item) const;
    int GetItemImage(const wxTreeItemId& item, wxTreeItemIcon which = wxTreeItemIcon_Normal) const;

    wxColour GetItemTextColour(const wxTreeItemId& item) const;
    wxColour GetItemBackgroundColour(const wxTreeItemId& item) const;
    wxFont GetItemFont(const wxTreeItemId& item) const;

    void SetItemText(const wxTreeItemId& item, const wxString& text);
    void SetItemImage(const wxTreeItemId& item, int image,
                      wxTreeItemIcon which = wxTreeItemIcon_Normal);


    SIP_PYOBJECT GetPyData(const wxTreeItemId& item);
%MethodCode
        wxPyTreeItemData* data = (wxPyTreeItemData*)sipCpp->GetItemData(*a0);
        if (data == NULL)
        {
            data = new wxPyTreeItemData(NULL);
            data->SetId(*a0);
            sipCpp->SetItemData(*a0, data);
        }

        sipRes = data->GetData();
        if (!sipRes)
        {
            Py_INCREF(Py_None);
            sipRes = Py_None; // needs incref?
        }

%End

    void SetPyData(const wxTreeItemId& item, SIP_PYOBJECT);
%MethodCode
        wxPyTreeItemData* data = (wxPyTreeItemData*)sipCpp->GetItemData(*a0);
        if (data == NULL)
        {
            data = new wxPyTreeItemData(a1);
            data->SetId(*a0);
            sipCpp->SetItemData(*a0, data);
        }
        else
            data->SetData(a1);
%End

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
    void EndEditLabel(const wxTreeItemId& item, bool discardChanges = false);
%End

    void SortChildren(const wxTreeItemId& item);

    wxTreeItemId HitTest(const wxPoint& point, int& where /Out/);

%If (WXMSW)
    void SetState(const wxTreeItemId& node, int state);
    int GetState(const wxTreeItemId& node);
%End

    void SetQuickBestSize(bool q);
    bool GetQuickBestSize() const;
};

