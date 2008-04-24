class wxStaticText : wxControl
{
%TypeHeaderCode
#include <wx/stattext.h>
%End

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

class wxStaticBox : wxControl
{
%TypeHeaderCode
#include <wx/statbox.h>
%End

public:
    wxStaticBox(wxWindow* parent /TransferThis/, wxWindowID id=-1,
                const wxString& label = wxEmptyString,
                const wxPoint& pos = wxDefaultPosition,
                const wxSize& size = wxDefaultSize,
                long style = 0,
                const wxString& name = wxStaticBoxNameStr);
};

class wxStaticLine : wxControl
{
%TypeHeaderCode
#include <wx/statline.h>
%End

public:
    wxStaticLine( wxWindow *parent /TransferThis/, wxWindowID id=-1,
                  const wxPoint &pos = wxDefaultPosition,
                  const wxSize &size = wxDefaultSize,
                  long style = wxLI_HORIZONTAL,
                  const wxString& name = wxStaticLineNameStr);
    bool IsVertical() const;
    static int GetDefaultSize();
};


class wxStaticBitmap : wxControl
{
%TypeHeaderCode
#include <wx/statbmp.h>
%End

public:
    wxStaticBitmap(wxWindow* parent /TransferThis/, wxWindowID id=-1,
                   const wxBitmap& bitmap = wxNullBitmap,
                   const wxPoint& pos = wxDefaultPosition,
                   const wxSize& size = wxDefaultSize,
                   long style = 0,
                   const wxString& name = wxStaticBitmapNameStr);
    wxBitmap GetBitmap();
    void SetBitmap(const wxBitmap& bitmap);
    void SetIcon(const wxIcon& icon);
};
