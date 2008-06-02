class wxPopupWindow : wxWindow
{
%TypeHeaderCode
#ifndef WXPY_PREC
#include <wx/popupwin.h>
#endif
%End
public:
    wxPopupWindow(wxWindow *parent, int flags = wxBORDER_NONE) /Transfer/;

    void SetRect(const wxRect& rect);
%MethodCode
    sipCpp->SetSize(a0->GetSize());
    sipCpp->Move(a0->GetPosition());
%End

    wxRect GetRect() const;
%MethodCode
    sipRes = new wxRect(sipCpp->GetPosition(), sipCpp->GetSize());
%End

};

class wxPopupTransientWindow : wxPopupWindow
{
%TypeHeaderCode
#ifndef WXPY_PREC
#include <wx/popupwin.h>
#endif
%End
public:
    wxPopupTransientWindow(wxWindow *parent, int style = wxBORDER_NONE) /Transfer/;

    void Popup(wxWindow *focus = NULL);
    void Dismiss();
};
