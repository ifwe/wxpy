//
// wxValidator
//

class wxValidator : wxEvtHandler
{

%TypeHeaderCode
#ifndef WXPY_PREC
#include <wx/validate.h>
#endif
%End

public:
    wxValidator();
    virtual ~wxValidator();

    static bool IsSilent();
    static void SetBellOnError(bool doIt = true);
};
