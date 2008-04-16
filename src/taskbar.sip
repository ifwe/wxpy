class wxTaskBarIcon : wxEvtHandler
{
%TypeHeaderCode
#include <wx/taskbar.h>
%End
    
public:
    wxTaskBarIcon();
    ~wxTaskBarIcon();

//    void Destroy() {
//        self->RemoveIcon();
//        delete self;
//    }

    bool IsOk() const;
    bool IsIconInstalled() const;
    bool SetIcon(const wxIcon& icon, const wxString& tooltip = wxEmptyString);
    bool RemoveIcon();
    bool PopupMenu(wxMenu *menu);
};



class wxTaskBarIconEvent : wxEvent
{
public:
    wxTaskBarIconEvent(wxEventType evtType, wxTaskBarIcon *tbIcon);
};
