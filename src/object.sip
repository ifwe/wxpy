//
// object.sip
//

class wxObject
{

%TypeHeaderCode
#include <wx/object.h>
%End

public:
    bool IsSameAs(const wxObject& p) const;
};
