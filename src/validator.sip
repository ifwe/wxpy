//
// wxValidator
//

class wxValidator : wxEvtHandler
{

%TypeHeaderCode
#include <wx/validate.h>
%End

public:
    wxValidator();
    virtual ~wxValidator();


    static bool IsSilent();
    static void SetBellOnError(bool doIt = true);

    wxWindow *GetWindow() const;
    void SetWindow(wxWindow *win);

    /*
    virtual wxObject *Clone() const;
    virtual bool Validate(wxWindow *parent);
    virtual bool TransferToWindow();
    virtual bool TransferFromWindow();
    */

};
