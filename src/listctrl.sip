%ModuleHeaderCode
#include <wx/listctrl.h>
%End

enum {
    // style flags
    wxLC_VRULES,
    wxLC_HRULES,

    wxLC_ICON,
    wxLC_SMALL_ICON,
    wxLC_LIST,
    wxLC_REPORT,

    wxLC_ALIGN_TOP,
    wxLC_ALIGN_LEFT,
    wxLC_AUTOARRANGE,
    wxLC_VIRTUAL,
    wxLC_EDIT_LABELS,
    wxLC_NO_HEADER,
    wxLC_NO_SORT_HEADER,
    wxLC_SINGLE_SEL,
    wxLC_SORT_ASCENDING,
    wxLC_SORT_DESCENDING,

    wxLC_MASK_TYPE,
    wxLC_MASK_ALIGN,
    wxLC_MASK_SORT
};


enum {
    // Mask flags to tell app/GUI what fields of wxListItem are valid
    wxLIST_MASK_STATE,
    wxLIST_MASK_TEXT,
    wxLIST_MASK_IMAGE,
    wxLIST_MASK_DATA,
    wxLIST_SET_ITEM,
    wxLIST_MASK_WIDTH,
    wxLIST_MASK_FORMAT,

// State flags for indicating the state of an item
    wxLIST_STATE_DONTCARE,
    wxLIST_STATE_DROPHILITED,
    wxLIST_STATE_FOCUSED,
    wxLIST_STATE_SELECTED,
    wxLIST_STATE_CUT,
    wxLIST_STATE_DISABLED,
    wxLIST_STATE_FILTERED,
    wxLIST_STATE_INUSE,
    wxLIST_STATE_PICKED,
    wxLIST_STATE_SOURCE,

// Hit test flags, used in HitTest
    wxLIST_HITTEST_ABOVE,
    wxLIST_HITTEST_BELOW,
    wxLIST_HITTEST_NOWHERE,
    wxLIST_HITTEST_ONITEMICON,
    wxLIST_HITTEST_ONITEMLABEL,
    wxLIST_HITTEST_ONITEMRIGHT,
    wxLIST_HITTEST_ONITEMSTATEICON,
    wxLIST_HITTEST_TOLEFT,
    wxLIST_HITTEST_TORIGHT,
    wxLIST_HITTEST_ONITEM,

// GetSubItemRect constants
    wxLIST_GETSUBITEMRECT_WHOLEITEM,
};


// Flags for GetNextItem (MSW only except wxLIST_NEXT_ALL)
enum
{
    wxLIST_NEXT_ABOVE,          // Searches for an item above the specified item
    wxLIST_NEXT_ALL,            // Searches for subsequent item by index
    wxLIST_NEXT_BELOW,          // Searches for an item below the specified item
    wxLIST_NEXT_LEFT,           // Searches for an item to the left of the specified item
    wxLIST_NEXT_RIGHT           // Searches for an item to the right of the specified item
};

// Alignment flags for Arrange (MSW only except wxLIST_ALIGN_LEFT)
enum
{
    wxLIST_ALIGN_DEFAULT,
    wxLIST_ALIGN_LEFT,
    wxLIST_ALIGN_TOP,
    wxLIST_ALIGN_SNAP_TO_GRID
};

// Column format (MSW only except wxLIST_FORMAT_LEFT)
enum wxListColumnFormat
{
    wxLIST_FORMAT_LEFT,
    wxLIST_FORMAT_RIGHT,
    wxLIST_FORMAT_CENTRE,
    wxLIST_FORMAT_CENTER = wxLIST_FORMAT_CENTRE
};

// Autosize values for SetColumnWidth
enum
{
    wxLIST_AUTOSIZE = -1,
    wxLIST_AUTOSIZE_USEHEADER = -2      // partly supported by generic version
};

// Flag values for GetItemRect
enum
{
    wxLIST_RECT_BOUNDS,
    wxLIST_RECT_ICON,
    wxLIST_RECT_LABEL
};

// Flag values for FindItem (MSW only)
enum
{
    wxLIST_FIND_UP,
    wxLIST_FIND_DOWN,
    wxLIST_FIND_LEFT,
    wxLIST_FIND_RIGHT
};


class wxListItemAttr
{
public:
    // ctors
    //wxListItemAttr();
    wxListItemAttr(const wxColour& colText = wxNullColour,
                   const wxColour& colBack = wxNullColour,
                   const wxFont& font = wxNullFont);
    ~wxListItemAttr();

    // setters
    void SetTextColour(const wxColour& colText);
    void SetBackgroundColour(const wxColour& colBack);
    void SetFont(const wxFont& font);

    // accessors
    bool HasTextColour();
    bool HasBackgroundColour();
    bool HasFont();

    wxColour GetTextColour();
    wxColour GetBackgroundColour();
    wxFont GetFont();

    void AssignFrom(const wxListItemAttr& source);
};

class wxListItem : wxObject {
public:
    wxListItem();
    ~wxListItem();

    // resetting
    void Clear();
    void ClearAttributes();

    // setters
    void SetMask(long mask);
    void SetId(long id);
    void SetColumn(int col);
    void SetState(long state);
    void SetStateMask(long stateMask);
    void SetText(const wxString& text);
    void SetImage(int image);
    void SetData(long data);

    void SetWidth(int width);
    void SetAlign(wxListColumnFormat align);

    void SetTextColour(const wxColour& colText);
    void SetBackgroundColour(const wxColour& colBack);
    void SetFont(const wxFont& font);

    // accessors
    long GetMask();
    long GetId();
    int GetColumn();
    long GetState();
    //const wxString& GetText();
    int GetImage();
    long GetData();

    int GetWidth();
    wxListColumnFormat GetAlign();

    wxListItemAttr *GetAttributes();
    bool HasAttributes();

    wxColour GetTextColour() const;
    wxColour GetBackgroundColour() const;
    wxFont GetFont() const;
};

class wxListEvent: wxNotifyEvent {
public:
    wxListEvent(wxEventType commandType = wxEVT_NULL, int id = 0);

    int GetKeyCode();
    long GetIndex();
    int GetColumn();
    wxPoint GetPoint();
    // TODO: resolve const property issues
    // const wxString& GetLabel();
    // const wxString& GetText();
    int GetImage();
    long GetData();
    long GetMask();
    const wxListItem& GetItem();

    long GetCacheFrom();
    long GetCacheTo();

    bool IsEditCancelled() const;
    void SetEditCanceled(bool editCancelled);
};
class wxListCtrl: wxControl {
public:
    wxListCtrl(wxWindow* parent /TransferThis/,
               wxWindowID id = -1,
               const wxPoint& pos = wxDefaultPosition,
               const wxSize& size = wxDefaultSize,
               long style = wxLC_ICON,
               const wxValidator& validator = wxDefaultValidator,
               const wxString& name = wxListCtrlNameStr);
    bool SetForegroundColour(const wxColour& col);
    bool SetBackgroundColour(const wxColour& col);
    bool SetColumn(int col, wxListItem& item) ;
    int GetColumnWidth(int col) const;
    bool SetColumnWidth(int col, int width) ;
    int GetCountPerPage() const;
    wxRect GetViewRect() const;
    wxTextCtrl* GetEditControl() const;

    bool SetItem(wxListItem& info);
    long SetItem(long index, int col, const wxString& label, int imageId = -1) /PyName=SetStringItem/;

    int  GetItemState(long item, long stateMask) const ;
    bool SetItemState(long item, long state, long stateMask) ;

    bool SetItemImage(long item, int image, int selImage=-1) ;
    bool SetItemColumnImage( long item, long column, int image );

    wxString GetItemText(long item) const ;

    void SetItemText(long item, const wxString& str) ;
    long GetItemData(long item) const ;
    bool SetItemData(long item, long data) ;

    //bool GetItemRect(long item, wxRect& rect, int code = wxLIST_RECT_BOUNDS) const ;
    //bool GetItemPosition(long item, wxPoint& pos) const ;


// MSW only so far...
//         wxRect GetSubItemRect(long item, long subItem, int code = wxLIST_RECT_BOUNDS) {
//             wxRect rect;
//             self->GetSubItemRect(item, subItem, rect, code);
//             return rect;
//         }
//    }

    // Gets information about the item
    wxListItem* GetItem(long itemId, int col=0) /Factory/;
%MethodCode
        wxListItem* info = new wxListItem;
        info->m_itemId = a0;
        info->m_col = a1;
        info->m_mask = 0xFFFF;
        sipCpp->GetItem(*info);
        sipRes = info;
%End

%TypeCode

static int wxCALLBACK wxPyListCtrl_SortItems(long item1, long item2, long funcPtr) {
    int retval = 0;

    SIP_BLOCK_THREADS
    PyObject* result = PyObject_CallFunction((PyObject*)funcPtr, "ii", item1, item2);
    if (!result)
        PyErr_Print();
    else
    {
        retval = PyInt_AsLong(result);
        Py_DECREF(result);
    }

    SIP_UNBLOCK_THREADS

    return retval;
}

%End // TypeCode

    bool SortItems(SIP_PYCALLABLE func);
%MethodCode
        sipRes = sipCpp->SortItems((wxListCtrlCompare)wxPyListCtrl_SortItems, (long)a0);
%End

    bool SetItemPosition(long item, const wxPoint& pos) ;
    int GetItemCount() const;
    int GetColumnCount() const;
    wxSize GetItemSpacing() const;

%If (!WXMSW)
    void SetItemSpacing( int spacing, bool isSmall = false );
%End
    int GetSelectedItemCount() const;
    wxColour GetTextColour() const;
    void SetTextColour(const wxColour& col);
    long GetTopItem() const ;
    void SetSingleStyle(long style, bool add = true) ;
    void SetWindowStyleFlag(long style) ;
    long GetNextItem(long item, int geometry = wxLIST_NEXT_ALL, int state = wxLIST_STATE_DONTCARE) const ;

    //wxImageList *GetImageList(int which) const ;
    //void SetImageList(wxImageList *imageList, int which);
    //void AssignImageList(wxImageList *imageList, int which);
    bool InReportView() const;
    bool IsVirtual() const;
    void RefreshItem(long item);
    void RefreshItems(long itemFrom, long itemTo);
    bool Arrange(int flag = wxLIST_ALIGN_DEFAULT);
    bool DeleteItem(long item);
    bool DeleteAllItems() ;
    bool DeleteColumn(int col);
    bool DeleteAllColumns();
    void ClearAll();

%If (WXMSW)
    // Edit the label
    wxTextCtrl* EditLabel(long item /*, wxClassInfo* textControlClass = CLASSINFO(wxTextCtrl)*/);
    bool EndEditLabel(bool cancel);
%End
%If (!WXMSW)
    void EditLabel(long item);
%End
    bool EnsureVisible(long item) ;

    long FindItem(long start, const wxString& str, bool partial = false);

    //%Rename(FindItemData,  long, FindItem(long start, long data));
    long FindItem(long start, long data);


    //%Rename(FindItemAtPoslong, FindItem(long start, const wxPoint& pt, int direction));
    long FindItem(long start, const wxPoint& pt, int direction);

    // TODO: HitTest methods

    long InsertItem(wxListItem& info);
    long InsertItem(long index, const wxString& label, int imageIndex = -1) /PyName=InsertStringItem/;
    long InsertItem(long index, int imageIndex) /PyName=InsertImageItem/;

    long InsertColumn(long col, wxListItem& info);


    long InsertColumn(long col,
                      const wxString& heading,
                      int format = wxLIST_FORMAT_LEFT,
                      int width = -1);

    void SetItemCount(long count);

    bool ScrollList(int dx, int dy);

    void SetItemTextColour( long item, const wxColour& col);
    wxColour GetItemTextColour( long item ) const;
    void SetItemBackgroundColour( long item, const wxColour &col);
    wxColour GetItemBackgroundColour( long item ) const;

    void SetItemFont(long item, const wxFont &f);
    wxFont GetItemFont(long item ) const;

/*
    // bool SortItems(wxListCtrlCompare fn, long data);
    %extend {
        // Sort items.
        // func is a function which takes 2 long arguments: item1, item2.
        // item1 is the long data associated with a first item (NOT the index).
        // item2 is the long data associated with a second item (NOT the index).
        // The return value is a negative number if the first item should precede the second
        // item, a positive number of the second item should precede the first,
        // or zero if the two items are equivalent.
        bool SortItems(PyObject* func) {
            if (!PyCallable_Check(func))
                return false;
            return self->SortItems((wxListCtrlCompare)wxPyListCtrl_SortItems, (long)func);
        }
    }
*/
    //static wxVisualAttributes
    //GetClassDefaultAttributes(wxWindowVariant variant = wxWINDOW_VARIANT_NORMAL);

};

enum
{
wxEVT_COMMAND_LIST_BEGIN_DRAG,
wxEVT_COMMAND_LIST_BEGIN_RDRAG,
wxEVT_COMMAND_LIST_BEGIN_LABEL_EDIT,
wxEVT_COMMAND_LIST_END_LABEL_EDIT,
wxEVT_COMMAND_LIST_DELETE_ITEM,
wxEVT_COMMAND_LIST_DELETE_ALL_ITEMS,
wxEVT_COMMAND_LIST_ITEM_SELECTED,
wxEVT_COMMAND_LIST_ITEM_DESELECTED,
wxEVT_COMMAND_LIST_KEY_DOWN,
wxEVT_COMMAND_LIST_INSERT_ITEM,
wxEVT_COMMAND_LIST_COL_CLICK,
wxEVT_COMMAND_LIST_ITEM_RIGHT_CLICK,
wxEVT_COMMAND_LIST_ITEM_MIDDLE_CLICK,
wxEVT_COMMAND_LIST_ITEM_ACTIVATED,
wxEVT_COMMAND_LIST_CACHE_HINT,
wxEVT_COMMAND_LIST_COL_RIGHT_CLICK,
wxEVT_COMMAND_LIST_COL_BEGIN_DRAG,
wxEVT_COMMAND_LIST_COL_DRAGGING,
wxEVT_COMMAND_LIST_COL_END_DRAG,
wxEVT_COMMAND_LIST_ITEM_FOCUSED
};

%PostInitialisationCode

#ifdef LIST_EVT
#error "macro LIST_EVT is already defined, better pick a better one here"
#else
#define LIST_EVT(name) add_event(sipModuleDict, "EVT_LIST_" #name, wxEVT_COMMAND_LIST_##name, 0);
#endif

LIST_EVT(BEGIN_DRAG)
LIST_EVT(BEGIN_RDRAG)
LIST_EVT(BEGIN_LABEL_EDIT)
LIST_EVT(END_LABEL_EDIT)
LIST_EVT(DELETE_ITEM)
LIST_EVT(DELETE_ALL_ITEMS)
LIST_EVT(ITEM_SELECTED)
LIST_EVT(ITEM_DESELECTED)
LIST_EVT(KEY_DOWN)
LIST_EVT(INSERT_ITEM)
LIST_EVT(COL_CLICK)
LIST_EVT(ITEM_RIGHT_CLICK)
LIST_EVT(ITEM_MIDDLE_CLICK)
LIST_EVT(ITEM_ACTIVATED)
LIST_EVT(CACHE_HINT)
LIST_EVT(COL_RIGHT_CLICK)
LIST_EVT(COL_BEGIN_DRAG)
LIST_EVT(COL_DRAGGING)
LIST_EVT(COL_END_DRAG)
LIST_EVT(ITEM_FOCUSED)

#undef LIST_EVT
%End // PostInitialisationCode

