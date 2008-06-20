//
// wxTopLevelWindow
//


enum
{
    wxSTAY_ON_TOP,
    wxICONIZE,
    wxMINIMIZE,
    wxMAXIMIZE,
    wxCLOSE_BOX,
    wxTHICK_FRAME,
    wxSYSTEM_MENU,
    wxMINIMIZE_BOX,
    wxMAXIMIZE_BOX,
    wxTINY_CAPTION_HORIZ,
    wxTINY_CAPTION_VERT,
    wxRESIZE_BOX,
    wxRESIZE_BORDER,

    wxDIALOG_NO_PARENT,

    wxDEFAULT_FRAME_STYLE,
    wxDEFAULT_DIALOG_STYLE,

    wxFRAME_TOOL_WINDOW,
    wxFRAME_FLOAT_ON_PARENT,
    wxFRAME_NO_WINDOW_MENU,
    wxFRAME_NO_TASKBAR,
    wxFRAME_SHAPED,
    wxFRAME_DRAWER,

    wxFRAME_EX_METAL,
    wxDIALOG_EX_METAL,
    wxWS_EX_CONTEXTHELP,

    // Obsolete
    wxDIALOG_MODAL,
    wxDIALOG_MODELESS,
    wxUSER_COLOURS,
    wxNO_3D,

    wxFRAME_EX_CONTEXTHELP,
    wxDIALOG_EX_CONTEXTHELP,
};


enum
{
    wxFULLSCREEN_NOMENUBAR,
    wxFULLSCREEN_NOTOOLBAR,
    wxFULLSCREEN_NOSTATUSBAR,
    wxFULLSCREEN_NOBORDER,
    wxFULLSCREEN_NOCAPTION,
    wxFULLSCREEN_ALL,

    wxTOPLEVEL_EX_DIALOG,
};

// Styles for RequestUserAttention
enum
{
    wxUSER_ATTENTION_INFO = 1,
    wxUSER_ATTENTION_ERROR = 2
};


class wxTopLevelWindow : wxWindow
{

%TypeHeaderCode
#ifndef WXPY_PREC
#include <wx/toplevel.h>
#endif
%End
public:
    virtual ~wxTopLevelWindow();

    void Maximize(bool maximize = true);
    void Restore();
    void Iconize(bool iconize = true);
    bool IsMaximized() const;
    bool IsAlwaysMaximized() const;
    bool IsIconized() const;

    wxIcon GetIcon() const;
    void SetIcon(const wxIcon& icon);

    void SetIcons(const wxIconBundle& icons);

    bool ShowFullScreen(bool show, long style = wxFULLSCREEN_ALL);
    bool IsFullScreen() const;

    void SetTitle(const wxString& title);
    wxString GetTitle() const;

    bool EnableCloseButton(bool enable );

    bool SetShape(const wxRegion& region);
    void RequestUserAttention(int flags = wxUSER_ATTENTION_INFO);

    bool IsActive();

    void CenterOnScreen(int dir = wxBOTH);
    wxWindow* GetDefaultItem() const;
    wxWindow* SetDefaultItem(wxWindow * child);

private:
    wxTopLevelWindow();
    wxTopLevelWindow(const wxTopLevelWindow&);
};

enum {
    wxDEFAULT_FRAME_STYLE
};

wxWindowList wxGetTopLevelWindows();
%MethodCode
    sipRes = new wxWindowList(wxTopLevelWindows);
%End

class wxFrame : wxTopLevelWindow
{

%TypeHeaderCode
#ifndef WXPY_PREC
#include <wx/frame.h>
#endif
%End

public:
    wxFrame(wxWindow* parent,
            const wxWindowID id = wxID_ANY,
            const wxString& title = wxEmptyString,
            const wxPoint& pos = wxDefaultPosition,
            const wxSize& size = wxDefaultSize,
            long style = wxDEFAULT_FRAME_STYLE,
            const wxString& name = wxFrameNameStr) /Transfer/;
    virtual ~wxFrame();

    void SetMenuBar(wxMenuBar* menuBar /Transfer/);
    wxMenuBar* GetMenuBar();

    wxToolBar* CreateToolBar(long style = wxNO_BORDER | wxTB_HORIZONTAL, wxWindowID id = -1, const wxString& name = wxToolBarNameStr) /Transfer/;
    wxToolBar* GetToolBar();

    void SetToolBar(wxToolBar* toolbar /Transfer/);
%MethodCode
    // any old wxToolBar becomes owned by Python
    wxToolBar* oldToolBar = sipCpp->GetToolBar();
    sipCpp->SetToolBar(a0);
    transferBack(oldToolBar, sipClass_wxToolBar);
%End

private:
    wxFrame(const wxFrame&);
};

enum {
   wxDEFAULT_DIALOG_STYLE
};

class wxDialog : wxTopLevelWindow
{
public:
    wxDialog(wxWindow* parent,
             const wxWindowID id = -1,
             const wxString& title = wxEmptyString,
             const wxPoint& pos = wxDefaultPosition,
             const wxSize& size = wxDefaultSize,
             long style = wxDEFAULT_DIALOG_STYLE,
             const wxString& name = wxDialogNameStr) /Transfer/;
    virtual ~wxDialog();

    void SetReturnCode(int returnCode);
    int GetReturnCode() const;

     void SetAffirmativeId(int affirmativeId);
     int GetAffirmativeId() const;

     void SetEscapeId(int escapeId);
     int GetEscapeId() const;

     wxSizer* CreateTextSizer(const wxString &message) /Transfer/;
     wxSizer* CreateButtonSizer(long flags) /Transfer/;
     wxSizer *CreateSeparatedButtonSizer(long flags) /Transfer/;
     //wxStdDialogButtonSizer* CreateStdDialogButtonSizer( long flags );

     bool IsModal() const;
     int ShowModal() /ReleaseGIL/;
     void EndModal(int retCode) /ReleaseGIL/;
private:
    wxDialog(const wxDialog&);
};
