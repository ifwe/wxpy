//
// wxEvtHandler
//
%ModuleHeaderCode
#include <wx/app.h>
void wxpyEntry();
%End

%ModuleCode
void wxpyEntry() {
    int argc = 0;
    wxChar *argv = 0;

    wxEntryStart(argc, &argv);
}
%End

class wxApp : wxEvtHandler
{

public:
    wxApp() /TransferThis/;
    virtual ~wxApp();
    virtual int MainLoop();
    virtual bool OnInit();    
    void ExitMainLoop();

private:
    wxApp(const wxApp &);
};

wxApp* GetApp();
%MethodCode
    // wrap the global wxApp pointer
    sipRes = wxTheApp;//sipConvertFromInstance(wxTheApp, sipClass_wxApp, NULL);
%End


void wxpyEntry();
