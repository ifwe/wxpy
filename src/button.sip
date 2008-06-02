//
// wxButton
//

enum {
    wxBU_LEFT,
    wxBU_TOP,
    wxBU_RIGHT,
    wxBU_BOTTOM,

    wxBU_ALIGN_MASK,

    wxBU_EXACTFIT,
    wxBU_AUTODRAW,
};


class wxButton : wxControl
{

%TypeHeaderCode
#ifndef WXPY_PREC
#include <wx/button.h>
#endif
%End

public:
    wxButton(wxWindow* parent /TransferThis/,
             const wxWindowID id = wxID_ANY,
             const wxString& label = wxEmptyString,
             const wxPoint& pos = wxDefaultPosition,
             const wxSize& size = wxDefaultSize,
             long style = 0,
             const wxValidator& validator = wxDefaultValidator,
             const wxString& name = wxButtonNameStr);

    void SetDefault();
    static wxSize GetDefaultSize();


private:
    wxButton(const wxButton&);
};
