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
#include <wx/toplevel.h>
%End
public:

    wxString GetTitle() const;
    void SetTitle(const wxString& title);

private:
    wxTopLevelWindow();
    wxTopLevelWindow(const wxTopLevelWindow&);
};

enum {
    wxDEFAULT_FRAME_STYLE
};

wxWindowList wxGetTopLevelWindows();
%MethodCode
    wxWindowList* list = new wxWindowList();
    wxWindowList::iterator iter;
    for(iter = wxTopLevelWindows.begin(); iter != wxTopLevelWindows.end(); ++iter)
        list->Append(*iter);

    sipRes = list;
%End

class wxFrame : wxTopLevelWindow
{

%TypeHeaderCode
#include <wx/frame.h>
%End

public:
    wxFrame(wxWindow* parent,
            const wxWindowID id = wxID_ANY,
            const wxString& title = wxEmptyString,
            const wxPoint& pos = wxDefaultPosition,
            const wxSize& size = wxDefaultSize,
            long style = wxDEFAULT_FRAME_STYLE,
            const wxString& name = wxFrameNameStr) /Transfer/;
    ~wxFrame();

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
    void SetReturnCode(int returnCode);
    int GetReturnCode() const;

     void SetAffirmativeId(int affirmativeId);
     int GetAffirmativeId() const;

     void SetEscapeId(int escapeId);
     int GetEscapeId() const;

     wxSizer* CreateTextSizer(const wxString &message);
     wxSizer* CreateButtonSizer(long flags);
     wxSizer *CreateSeparatedButtonSizer(long flags);
     //wxStdDialogButtonSizer* CreateStdDialogButtonSizer( long flags );

     bool IsModal() const;
     int ShowModal();
     void EndModal(int retCode);
private:
    wxDialog(const wxDialog&);
};