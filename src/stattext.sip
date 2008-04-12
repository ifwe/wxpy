class wxStaticText : wxControl
{
public:
    wxStaticText(wxWindow *parent /TransferThis/,
                 wxWindowID id,
                 const wxString& label,
                 const wxPoint& pos = wxDefaultPosition,
                 const wxSize& size = wxDefaultSize,
                 long style = 0,
                 const wxString& name = wxStaticTextNameStr);

    void Wrap(int width);
};