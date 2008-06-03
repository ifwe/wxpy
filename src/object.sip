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
        C(wxKeyEvent)
        C(wxCommandEvent)
        C(wxMouseEvent)
        C(wxTimerEvent)
        C(wxShowEvent)
        C(wxMenuEvent)
        C(wxShowEvent)
        C(wxActivateEvent)
        C(wxMaximizeEvent)
        C(wxIconizeEvent)
        C(wxHyperlinkEvent)
        C(wxInitDialogEvent)
        C(wxNotifyEvent)
        C(wxListEvent)
        C(wxDropFilesEvent)
        C(wxTreeEvent)
        C(wxUpdateUIEvent)

        C(wxSizerItem)
        C(wxGBSizerItem)

    else
        sipClass = NULL;
%End


public:
    bool IsSameAs(const wxObject& p) const;
};
