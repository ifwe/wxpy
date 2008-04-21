//
// wxControl
//

class wxControl : wxWindow
{

%TypeHeaderCode
#include <wx/control.h>
%End

public:
    //void Command(wxCommandEvent&);
    //const wxString& GetLabel() const;
    //const wxString& GetLabelText() const;
    void SetLabel(const wxString&);
    
private:
    wxControl(const wxControl&);
};

class wxItemContainer /Abstract/
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
    
    virtual unsigned int GetCount() const = 0;
    virtual wxString GetString(unsigned int n) const = 0;
    virtual void SetSelection(int n) = 0;
    
};


class wxControlWithItems : wxControl, wxItemContainer /Abstract/
{
public:
};
