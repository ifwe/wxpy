%ModuleHeaderCode
#ifndef WXPY_PREC
#include <wx/slider.h>
#endif
%End

enum {
    wxSL_HORIZONTAL,
    wxSL_VERTICAL,
    wxSL_TICKS,
    wxSL_AUTOTICKS,
    wxSL_LABELS,
    wxSL_LEFT,
    wxSL_TOP,
    wxSL_RIGHT,
    wxSL_BOTTOM,
    wxSL_BOTH,
    wxSL_SELRANGE,
    wxSL_INVERSE
};


class wxSlider : wxControl
{
public:
    wxSlider(wxWindow* parent /TransferThis/,
             wxWindowID id = -1,
             int value = 0, int minValue = 0, int maxValue = 100,
             const wxPoint& pos = wxDefaultPosition,
             const wxSize& size = wxDefaultSize,
             long style = wxSL_HORIZONTAL,
             const wxValidator& validator = wxDefaultValidator,
             const wxString& name = wxSliderNameStr);
    virtual ~wxSlider();

    int GetValue() const;
    void SetValue(int value);

    // retrieve/change the range
    int GetMin() const;
    int GetMax() const;
    void SetMin( int minValue );
    void SetMax( int maxValue );

    void SetRange(int minValue, int maxValue);

    SIP_PYTUPLE GetRange();
%MethodCode
    sipRes = Py_BuildValue("(ii)", sipCpp->GetMin(), sipCpp->GetMax());
%End

    void SetLineSize(int lineSize);
    void SetPageSize(int pageSize);
    int GetLineSize() const;
    int GetPageSize() const;

    void SetThumbLength(int lenPixels);
    int GetThumbLength() const;

    void SetTickFreq(int n, int pos=1);
    int GetTickFreq() const;
    void ClearTicks();
    void SetTick(int tickPos);

    void ClearSel();
    int GetSelEnd() const;
    int GetSelStart() const;
    void SetSelection(int min, int max);

};
