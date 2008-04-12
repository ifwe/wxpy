//
// wxTopLevelWindow
//

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