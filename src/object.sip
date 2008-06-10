//
// object.sip
//

class wxObject
{
    virtual ~wxObject();

%TypeHeaderCode
#ifndef WXPY_PREC
#include <wx/object.h>
#include <wx/gbsizer.h>
#endif
%End

%ConvertToSubClassCode
    wxClassInfo* c = sipCpp -> GetClassInfo();

    /* TODO: automate this by grepping for wxXXXEvent and putting
     * entries here before build :( */
    if(0) ;
#define C(clz) else if (c == CLASSINFO(clz)) sipClass = sipClass_ ## clz;
        C(wxSizerItem)
        C(wxGBSizerItem)
    else
        sipClass = NULL;
#undef C
%End


public:
    bool IsSameAs(const wxObject& p) const;
};
