//
// wxNotebook
//


enum {
    wxBK_DEFAULT,
    wxBK_TOP,
    wxBK_BOTTOM,
    wxBK_LEFT,
    wxBK_RIGHT,
    wxBK_ALIGN_MASK,
%If (wxUSE_TOOLBOOK)
    wxBK_BUTTONBAR,
%End

    // hittest flags
    wxBK_HITTEST_NOWHERE = 1,   // not on tab
    wxBK_HITTEST_ONICON  = 2,   // on icon
    wxBK_HITTEST_ONLABEL = 4,   // on label
    wxBK_HITTEST_ONITEM  = 6,
    wxBK_HITTEST_ONPAGE  = 8,   // not on tab control, but over the selected page
};

class wxBookCtrlBase : wxControl
{
};


