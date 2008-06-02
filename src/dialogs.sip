%ModuleHeaderCode
// TODO: use wxUSE flags for these includes
#ifndef WXPY_PREC
#include <wx/fontdlg.h>
#include <wx/colordlg.h>
#include <wx/fdrepdlg.h>
#include <wx/progdlg.h>
#endif
#ifndef wxHIDE_READONLY
#define wxHIDE_READONLY 0
#endif
%End

class wxColourData : wxObject
{
public:
    wxColourData();
    ~wxColourData();
    bool GetChooseFull();
    wxColour GetColour();
    wxColour GetCustomColour(int i);
    void SetChooseFull(int flag);
    void SetColour(const wxColour& colour);
    void SetCustomColour(int i, const wxColour& colour);
};


class wxColourDialog : wxDialog
{
public:
    wxColourDialog(wxWindow* parent, wxColourData* data = NULL);
    wxColourData& GetColourData();
};

wxColour wxGetColourFromUser(wxWindow *parent = NULL,
                             const wxColour& colInit = wxNullColour,
                             const wxString& caption = wxEmptyString);
enum
{
    wxDD_CHANGE_DIR,
    wxDD_DIR_MUST_EXIST,
    wxDD_NEW_DIR_BUTTON,
    wxDD_DEFAULT_STYLE,
};

class wxDirDialog : wxDialog
{
public:
    wxDirDialog(wxWindow* parent,
                const wxString& message = wxDirSelectorPromptStr,
                const wxString& defaultPath = wxEmptyString,
                long style = wxDD_DEFAULT_STYLE,
                const wxPoint& pos = wxDefaultPosition,
                const wxSize& size = wxDefaultSize,
                const wxString& name = wxDirDialogNameStr);
    wxString GetPath();
    wxString GetMessage();
    void SetMessage(const wxString& message);
    void SetPath(const wxString& path);
};


// compatability only

enum {
    // These will dissappear in 2.8
    wxOPEN,
    wxSAVE,
    wxOVERWRITE_PROMPT,
    wxFILE_MUST_EXIST,
    wxMULTIPLE,
    wxCHANGE_DIR,
    wxHIDE_READONLY,

    wxFD_OPEN,
    wxFD_SAVE,
    wxFD_OVERWRITE_PROMPT,
    wxFD_FILE_MUST_EXIST,
    wxFD_MULTIPLE,
    wxFD_CHANGE_DIR,
    wxFD_PREVIEW,
    wxFD_DEFAULT_STYLE,
};

class wxFileDialog : wxDialog
{
public:
    wxFileDialog(wxWindow* parent,
                 const wxString& message = wxFileSelectorPromptStr,
                 const wxString& defaultDir = wxEmptyString,
                 const wxString& defaultFile = wxEmptyString,
                 const wxString& wildcard = wxFileSelectorDefaultWildcardStr,
                 long style = wxFD_DEFAULT_STYLE,
                 const wxPoint& pos = wxDefaultPosition);

    void SetMessage(const wxString& message);
    void SetPath(const wxString& path);
    void SetDirectory(const wxString& dir);
    void SetFilename(const wxString& name);
    void SetFilterIndex(int filterIndex);

    wxString GetMessage() const;
    wxString GetPath() const;
    wxString GetDirectory() const;
    wxString GetFilename() const;
    wxString GetWildcard() const;
    int GetFilterIndex() const;

    void GetFilenames(wxArrayString& filenames /Out/) const;
    void GetPaths(wxArrayString& paths /Out/) const;
};

enum {
    wxCHOICEDLG_STYLE
};

class wxMultiChoiceDialog : wxDialog
{
public:

    wxMultiChoiceDialog(wxWindow *parent,
                        const wxString& message,
                        const wxString& caption,
                        int choices=0, wxString* choices_array=NULL,
                        long style = wxCHOICEDLG_STYLE,
                        const wxPoint& pos = wxDefaultPosition);


    //void SetSelections(const wxArrayInt& selections);
    //wxArrayInt GetSelections() const;
};

/*
class wxSingleChoiceDialog : wxDialog
{
public:

    // don't let Python set clientData
    wxSingleChoiceDialog(wxWindow* parent,
                         const wxString& message,
                         const wxString& caption,
                         int choices /ArraySize/,
                         wxString* choices_array /Array/,
                         //char** clientData = NULL,
                         long style = wxCHOICEDLG_STYLE,
                         const wxPoint& pos = wxDefaultPosition);
%MethodCode
    sipCpp = new wxSingleChoiceDialog(a0, *a1, *a2, a3, a4, NULL, a5, *a6);
%End

    int GetSelection();
    wxString GetStringSelection();
    void SetSelection(int sel);
};
*/


enum
{
    wxTextEntryDialogStyle
};

class wxTextEntryDialog : wxDialog
{
public:
    wxTextEntryDialog(wxWindow* parent,
                      const wxString& message,
                      const wxString& caption = wxGetTextFromUserPromptStr,
                      const wxString& defaultValue = wxEmptyString,
                      long style = wxTextEntryDialogStyle,
                      const wxPoint& pos = wxDefaultPosition);

    wxString GetValue();
    void SetValue(const wxString& value);
};

class wxPasswordEntryDialog : wxTextEntryDialog
{
public:
    wxPasswordEntryDialog(wxWindow *parent,
                      const wxString& message,
                      const wxString& caption = wxGetPasswordFromUserPromptStr,
                      const wxString& value = wxEmptyString,
                      long style = wxTextEntryDialogStyle,
                      const wxPoint& pos = wxDefaultPosition);
};

%If (wxUSE_NUMBERDLG)
class wxNumberEntryDialog : wxDialog
{
%TypeHeaderCode
#ifndef WXPY_PREC
#include <wx/numdlg.h>
#endif
%End
public:
    wxNumberEntryDialog(wxWindow *parent,
                        const wxString& message,
                        const wxString& prompt,
                        const wxString& caption,
                        long value, long min, long max,
                        const wxPoint& pos = wxDefaultPosition);
    long GetValue();
};

%End // wxUSE_NUMBERDLG
%If (wxUSE_FONTDLG)

class wxFontData : wxObject
{
public:
    wxFontData();
    ~wxFontData();

    void EnableEffects(bool enable);

    bool GetAllowSymbols();

    wxColour GetColour();
    wxFont GetChosenFont();
    bool GetEnableEffects();
    wxFont GetInitialFont();
    bool GetShowHelp();
    void SetAllowSymbols(bool allowSymbols);
    void SetChosenFont(const wxFont& font);
    void SetColour(const wxColour& colour);
    void SetInitialFont(const wxFont& font);
    void SetRange(int min, int max);
    void SetShowHelp(bool showHelp);
};


class wxFontDialog : wxDialog
{
public:
    wxFontDialog(wxWindow* parent, const wxFontData& data);
    wxFontData& GetFontData();
};


wxFont wxGetFontFromUser(wxWindow *parent = NULL,
                         const wxFont& fontInit = wxNullFont,
                         const wxString& caption = wxEmptyString);


%End // wxUSE_FONTDLG
%If (wxUSE_MSGDLG)


class wxMessageDialog : wxDialog {
public:

    wxMessageDialog(wxWindow* parent,
                    const wxString& message,
                    const wxString& caption = wxMessageBoxCaptionStr,
                    long style = wxOK | wxCANCEL | wxCENTRE,
                    const wxPoint& pos = wxDefaultPosition) /Transfer/;
};

%End
%If (wxUSE_PROGRESSDLG)

enum {
    wxPD_AUTO_HIDE,
    wxPD_APP_MODAL,
    wxPD_CAN_ABORT,
    wxPD_ELAPSED_TIME,
    wxPD_ESTIMATED_TIME,
    wxPD_REMAINING_TIME,
    wxPD_SMOOTH,
    wxPD_CAN_SKIP
};


// TODO: wxPD_CAN_SKIP

class wxProgressDialog : wxDialog {
public:

        wxProgressDialog(const wxString& title,
                         const wxString& message,
                         int maximum = 100,
                         wxWindow* parent = NULL,
                         int style = wxPD_AUTO_HIDE | wxPD_APP_MODAL );

    bool Update(int value, const wxString& newmsg = wxEmptyString, bool *skip /Out/ = NULL);
    bool Pulse(const wxString& newmsg = wxEmptyString, bool *skip /Out/ = NULL);
    void Resume();
};

%End // wxUSE_PROGRESSDLG
%If (wxUSE_FINDREPLDLG)


enum wxFindReplaceFlags
{
    wxFR_DOWN       = 1,
    wxFR_WHOLEWORD  = 2,
    wxFR_MATCHCASE  = 4
};


enum wxFindReplaceDialogStyles
{
    wxFR_REPLACEDIALOG = 1,
    wxFR_NOUPDOWN      = 2,
    wxFR_NOMATCHCASE   = 4,
    wxFR_NOWHOLEWORD   = 8
};

%PostInitialisationCode
add_event(sipModuleDict, "EVT_FIND", wxEVT_COMMAND_FIND, 0);
add_event(sipModuleDict, "EVT_FIND_NEXT", wxEVT_COMMAND_FIND_NEXT, 0);
add_event(sipModuleDict, "EVT_FIND_REPLACE", wxEVT_COMMAND_FIND_REPLACE, 0);
add_event(sipModuleDict, "EVT_FIND_REPLACE_ALL", wxEVT_COMMAND_FIND_REPLACE_ALL, 0);
add_event(sipModuleDict, "EVT_FIND_CLOSE", wxEVT_COMMAND_FIND_CLOSE, 0);
%End

class wxFindDialogEvent : wxCommandEvent
{
public:
    wxFindDialogEvent(wxEventType commandType = wxEVT_NULL, int id = 0);

    int GetFlags();
    const wxString& GetFindString();
    const wxString& GetReplaceString();

    wxFindReplaceDialog* GetDialog();
    void SetFlags(int flags);
    void SetFindString(const wxString& str);
    void SetReplaceString(const wxString& str);

private:
    wxFindDialogEvent(const wxFindDialogEvent&);
};


class wxFindReplaceData : wxObject
{
public:
    wxFindReplaceData(int flags=0);
    ~wxFindReplaceData();
    const wxString& GetFindString();
    const wxString& GetReplaceString();
    int GetFlags();
    void SetFlags(int flags);
    void SetFindString(const wxString& str);
    void SetReplaceString(const wxString& str);
};



class wxFindReplaceDialog : wxDialog
{
public:

    wxFindReplaceDialog(wxWindow *parent,
                        wxFindReplaceData *data,
                        const wxString &title,
                        int style = 0);

    const wxFindReplaceData* GetData();
    void SetData(wxFindReplaceData *data);
};

%End // wxUSE_FINDREPLDLG

