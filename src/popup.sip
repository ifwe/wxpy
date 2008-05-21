
class wxPopupWindow : wxWindow {
%TypeHeaderCode
    #include <wx/popupwin.h>
%End
public:
    wxPopupWindow(wxWindow *parent, int flags = wxBORDER_NONE) /Transfer/;
//    void Position(const wxPoint& ptOrigin,
//                  const wxSize& size);

    void SetRect(const wxRect& rect);
%MethodCode
    sipCpp->Position(a0->GetPosition(), a0->GetSize());
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
