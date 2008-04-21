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
    wxChar** argv = 0;
    
    printf("calling wxEntryStart...wxTheApp is %p\n", wxTheApp);
    wxEntryStart(argc, argv);
}
%End

class wxApp : wxEvtHandler
{
public:
    wxApp() /Transfer/;
    virtual ~wxApp();
    virtual int MainLoop();
    virtual bool OnInit();    
    void ExitMainLoop();
    
    void SetTopWindow(wxTopLevelWindow* f);

private:
    wxApp(const wxApp &);
};

wxApp* GetApp();
%MethodCode
    // wrap the global wxApp pointer
    sipRes = wxTheApp;//sipConvertFromInstance(wxTheApp, sipResipClass_wxApp, NULL);
%End


void wxpyEntry();
%MethodCode
    static bool hasbeencalled = false;
    if (hasbeencalled)
    {
        PyErr_SetString(PyExc_AssertionError, "call wxpyEntry only once");
        sipIsErr = 1;
    }
    else if (wxTheApp == NULL)
    {
        PyErr_SetString(PyExc_AssertionError, "wxApp was not created yet");
        sipIsErr = 1;        
    }
    else
    {
        hasbeencalled = true;
        wxpyEntry();
    }
%End