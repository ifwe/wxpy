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
};
