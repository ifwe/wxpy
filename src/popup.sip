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
    sipRes = new wxRect(sipCpp->GetPosition(), sipCpp->GetSize());
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
