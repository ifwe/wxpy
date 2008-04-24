
class wxPopupWindow : wxWindow {
%TypeHeaderCode
    #include <wx/popupwin.h>
%End
public:
    wxPopupWindow(wxWindow *parent /TransferThis/, int flags = wxBORDER_NONE) /Transfer/;
//    void Position(const wxPoint& ptOrigin,
//                  const wxSize& size);
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
