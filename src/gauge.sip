%ModuleHeaderCode
#ifndef WXPY_PREC
#include <wx/gauge.h>
#endif
%End

enum {
    wxGA_HORIZONTAL,
    wxGA_VERTICAL,
    wxGA_SMOOTH,
};

class wxGauge : wxControl
{
public:
    wxGauge(wxWindow* parent, wxWindowID id=-1, int range=100,
            const wxPoint& pos = wxDefaultPosition,
            const wxSize& size = wxDefaultSize,
            long style = wxGA_HORIZONTAL,
            const wxValidator& validator = wxDefaultValidator,
            const wxString& name = wxGaugeNameStr);
    virtual ~wxGauge();

    void SetRange(int range);
    int GetRange() const;
    void SetValue(int pos);
    int GetValue() const;
    void Pulse();
    bool IsVertical() const;

    void SetShadowWidth(int w);
    int GetShadowWidth() const;
    void SetBezelFace(int w);
    int GetBezelFace() const;

};
