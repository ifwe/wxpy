%ModuleHeaderCode
#include <wx/tooltip.h>
#include <wx/caret.h>
%End

%Include sound.sip
%Include settings.sip
%Include taskbar.sip
%Include config.sip
%Include popup.sip
%Include stock.sip
%Include log.sip
%Include clipboard.sip
%Include renderer.sip
%Include datetime.sip
%Include picker.sip
%Include imagelist.sip
%Include intl.sip
%Include artprov.sip
%Include process.sip
%Include crash.sip

%If (!WXMAC)
%Include power.sip
%End


class wxToolTip : wxObject
{
public:
    wxToolTip(const wxString &tip);
    virtual ~wxToolTip();

    void SetTip(const wxString& tip);
    wxString GetTip() const;

    wxWindow *GetWindow();

    static void Enable(bool flag);
    static void SetDelay(long milliseconds);
private:
    wxToolTip(const wxToolTip&);
};

class wxCaret {
public:
    wxCaret(wxWindow* window, const wxSize& size);
    virtual ~wxCaret();

    bool IsOk();
    bool IsVisible();

    wxPoint GetPosition();
    wxSize GetSize();

    wxWindow *GetWindow();
    void Move(const wxPoint& pt);
    void SetSize(const wxSize& size);
    void Show(int show = true);
    void Hide();

    static int GetBlinkTime();
    static void SetBlinkTime(int milliseconds);
private:
    wxCaret(const wxCaret&);
};

%If (wxUSE_SNGLINST_CHECKER)
class wxSingleInstanceChecker
{
%TypeCode
#include <wx/snglinst.h>
%End

private:
    wxSingleInstanceChecker();
    wxSingleInstanceChecker(const wxSingleInstanceChecker&);

public:
    wxSingleInstanceChecker(const wxString& name,
                            const wxString& path = wxEmptyString);
    virtual ~wxSingleInstanceChecker();
    bool Create(const wxString& name, const wxString& path = wxEmptyString);
    bool IsAnotherRunning() const;
};
%End
