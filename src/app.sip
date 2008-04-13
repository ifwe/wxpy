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


void wxpyEntry();
