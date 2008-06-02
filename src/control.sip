//
// wxControl
//

class wxControl : wxWindow
{

%TypeHeaderCode
#ifndef WXPY_PREC
#include <wx/control.h>
#endif
%End

public:
    wxControl(wxWindow *parent,
              wxWindowID id = -1,
              const wxPoint& pos = wxDefaultPosition,
              const wxSize& size = wxDefaultSize,
              long style=0,
              const wxValidator& validator = wxDefaultValidator,
              const wxString& name=wxControlNameStr);
    virtual ~wxControl();

    //void Command(wxCommandEvent&);
    //const wxString& GetLabel() const;
    //const wxString& GetLabelText() const;
    void SetLabel(const wxString&);

private:
    wxControl(const wxControl&);
};

class wxItemContainer
{
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

private:
    wxItemContainer();
};


class wxControlWithItems : wxControl, wxItemContainer
{
public:
    int Append(const wxString& item);
private:
    wxControlWithItems();
};
