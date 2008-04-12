//
// wxValidator
//

class wxValidator : wxEvtHandler /PyName=Validator/
{

%TypeHeaderCode
#include <wx/validate.h>
%End

public:
    wxValidator();
    
    static bool IsSilent();
    static void SetBellOnError(bool doIt = true);
};
