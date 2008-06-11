%ModuleHeaderCode
void add_event(PyObject* module_dict, const char* name, ...);
#ifndef WXPY_PREC
#include <wx/tglbtn.h>
#endif
%End

enum { wxEVT_COMMAND_TOGGLEBUTTON_CLICKED };

%PostInitialisationCode
add_event(sipModuleDict, "EVT_TOGGLEBUTTON", wxEVT_COMMAND_TOGGLEBUTTON_CLICKED, 0);
%End

class wxToggleButton : wxControl
{
public:
    wxToggleButton(wxWindow *parent /TransferThis/,
                   wxWindowID id=-1,
                   const wxString& label = wxEmptyString,
                   const wxPoint& pos = wxDefaultPosition,
                   const wxSize& size = wxDefaultSize,
                   long style = 0,
                   const wxValidator& validator = wxDefaultValidator,
                   const wxString& name = wxT("ToggleButton"));
    virtual ~wxToggleButton();

    void SetValue(bool value);
    bool GetValue() const ;
    void SetLabel(const wxString& label);
};
