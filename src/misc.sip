%ModuleHeaderCode
#include <wx/tooltip.h>
#include <wx/caret.h>
%End

%Include sound.sip
%Include settings.sip
%Include taskbar.sip
%Include config.sip
%Include log.sip

class wxToolTip : wxObject {
public:
    wxToolTip(const wxString &tip);
    ~wxToolTip();
    
    void SetTip(const wxString& tip);
    wxString GetTip();

    wxWindow *GetWindow();

    static void Enable(bool flag);
    static void SetDelay(long milliseconds);
};

class wxCaret {
public:
    wxCaret(wxWindow* window, const wxSize& size);
    ~wxCaret(); 

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