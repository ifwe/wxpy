//
// wxButton
//

class wxButton : wxControl
{

%TypeHeaderCode
#include <wx/button.h>
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
