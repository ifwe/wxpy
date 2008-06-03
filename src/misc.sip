%ModuleHeaderCode
#ifndef WXPY_PREC
#include <wx/tooltip.h>
#include <wx/caret.h>
#endif
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

%If (!WXMAC)
%Include power.sip
%End


class wxToolTip : wxObject {
public:
    wxToolTip(const wxString &tip);
    virtual ~wxToolTip();

    void SetTip(const wxString& tip);
    wxString GetTip();

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
