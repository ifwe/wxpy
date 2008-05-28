class wxPopupWindow : wxWindow
{
%TypeHeaderCode
    #include <wx/popupwin.h>
%End
public:
    wxPopupWindow(wxWindow *parent, int flags = wxBORDER_NONE) /Transfer/;

    void SetRect(const wxRect& rect);
%MethodCode
    sipCpp->Move(a0->GetPosition());
    sipCpp->SetSize(a0->GetSize());
%End

    wxRect GetRect() const;
%MethodCode
#if defined(__WXMSW__)
    RECT rect;
    GetWindowRect(static_cast<HWND>(sipCpp->GetHWND()), &rect);
    sipRes = new wxRect(rect.left, rect.top, rect.right - rect.left, rect.bottom - rect.top);
#else
    sipRes = new wxRect(sipCpp->GetPosition(), sipCpp->GetSize());
#endif
%End

};

class wxPopupTransientWindow : wxPopupWindow
{
%TypeHeaderCode
    #include <wx/popupwin.h>
%End
public:
    wxPopupTransientWindow(wxWindow *parent, int style = wxBORDER_NONE) /Transfer/;

    void Popup(wxWindow *focus = NULL);
    void Dismiss();
};
