//
// wxControl
//

class wxControl : wxWindow
{

%TypeHeaderCode
#include <wx/control.h>
%End

public:
    //void Command(wxCommandEvent&);
    //const wxString& GetLabel() const;
    //const wxString& GetLabelText() const;
    void SetLabel(const wxString&);
    
private:
    wxControl(const wxControl&);
};
