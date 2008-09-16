//
// wxControl
//

class wxControl : wxWindow
{

%TypeHeaderCode
#include <wx/control.h>
%End

public:
    wxControl(wxWindow *parent /TransferThis/,
              wxWindowID id = -1,
              const wxPoint& pos = wxDefaultPosition,
              const wxSize& size = wxDefaultSize,
              long style=0,
              const wxValidator& validator = wxDefaultValidator,
              const wxString& name=wxControlNameStr);
    virtual ~wxControl();

    void Command(wxCommandEvent&);
    const wxString& GetLabel() const;
    const wxString& GetLabelText() const;
    void SetLabel(const wxString&);

private:
    wxControl(const wxControl&);
};

class wxItemContainer
{
private:
    wxItemContainer();

public:
    void Clear();
    void Delete(/*unsigned*/ int n);
    bool IsEmpty() const;
    //        wxArrayString GetStrings() const,
    void SetString(/*unsigned*/ int n, const wxString& s);
    int FindString(const wxString& s) const;
    int GetSelection() const;
    bool SetStringSelection(const wxString& s);
    wxString GetStringSelection() const;
    void Select(int n);

    unsigned int GetCount() const = 0;
    wxString GetString(unsigned int n) const = 0;
    void SetSelection(int n) = 0;

    void Append(const wxArrayString& strings) /PyName=AppendItems/;
};


class wxControlWithItems : wxControl, wxItemContainer
{
public:
    int Append(const wxString& item);
private:
    wxControlWithItems();
};
