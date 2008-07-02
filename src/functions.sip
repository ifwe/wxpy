%ModuleHeaderCode
#ifndef WXPY_PREC
#include <wx/stockitem.h>
#endif
%End

void wxWakeUpIdle();

void wxBeginBusyCursor(wxCursor& cursor);
%MethodCode
    wxBeginBusyCursor(a0);
%End

void wxEndBusyCursor();


long wxNewId();
void wxRegisterId(long id);
long wxGetCurrentId();
/*
bool wxIsStockID(wxWindowID id);
bool wxIsStockLabel(wxWindowID id, const wxString& label);

enum wxStockLabelQueryFlag
{
    wxSTOCK_NOFLAGS = 0,

    wxSTOCK_WITH_MNEMONIC = 1,
    wxSTOCK_WITH_ACCELERATOR = 2
};

wxString wxGetStockLabel(wxWindowID id,
                         long flags = wxSTOCK_WITH_MNEMONIC);

enum wxStockHelpStringClient
{
    wxSTOCK_MENU        // help string to use for menu items
};


wxString wxGetStockHelpString(wxWindowID id,
                              wxStockHelpStringClient client = wxSTOCK_MENU);
*/
void wxBell();


bool wxShell(const wxString& command = wxEmptyString);

void wxSleep(int secs);
void wxMilliSleep(unsigned long milliseconds);
void wxMicroSleep(unsigned long microseconds);
void wxEnableTopLevelWindows(bool enable);

wxString wxGetEmailAddress();
wxString wxGetHostName();
wxString wxGetFullHostName();
wxString wxGetUserId();
wxString wxGetUserName();
wxString wxGetHomeDir();
wxString wxGetUserHome(const wxString& user = wxEmptyString);

void wxTrap();

// Dialog Functions
wxString wxFileSelector(const wxString& message = wxFileSelectorPromptStr,
                        const wxString& default_path = wxEmptyString,
                        const wxString& default_filename = wxEmptyString,
                        const wxString& default_extension = wxEmptyString,
                        const wxString& wildcard = wxFileSelectorDefaultWildcardStr,
                        int flags = 0,
                        wxWindow *parent = NULL,
                        int x = -1, int y = -1);

wxString wxLoadFileSelector(const wxString& what,
                            const wxString& extension,
                            const wxString& default_name = wxEmptyString,
                            wxWindow *parent = NULL);

wxString wxSaveFileSelector(const wxString& what,
                            const wxString& extension,
                            const wxString& default_name = wxEmptyString,
                            wxWindow *parent = NULL);

wxString wxDirSelector(const wxString& message = wxDirSelectorPromptStr,
                       const wxString& defaultPath = wxEmptyString,
                       long style = wxDD_DEFAULT_STYLE,
                       const wxPoint& pos = wxDefaultPosition,
                       wxWindow *parent = NULL);

wxString wxGetTextFromUser(const wxString& message,
                           const wxString& caption = wxEmptyString,
                           const wxString& default_value = wxEmptyString,
                           wxWindow *parent = NULL,
                           int x = -1, int y = -1,
                           bool centre = true);

wxString wxGetPasswordFromUser(const wxString& message,
                               const wxString& caption = wxEmptyString,
                               const wxString& default_value = wxEmptyString,
                               wxWindow *parent = NULL);


wxString wxGetSingleChoice(const wxString& message,
                           const wxString& caption,
                           const wxArrayString& aChoices,
                           wxWindow *parent = NULL,
                           int x = -1,
                           int y = -1,
                           bool centre = true,
                           int width=150,
                           int height=200);
/*
int wxGetSingleChoiceIndex(const wxString& message, const wxString& caption,
                           int choices, wxString* choices_array,
                           wxWindow *parent = NULL,
                           int x = -1, int y = -1,
                           bool centre = true,
                           int width=150, int height=200);
*/

int wxMessageBox(const wxString& message,
                 const wxString& caption = wxEmptyString,
                 int style = wxOK | wxCENTRE,
                 wxWindow *parent = NULL,
                 int x = -1, int y = -1);

long wxGetNumberFromUser(const wxString& message,
                         const wxString& prompt,
                         const wxString& caption,
                         long value,
                         long min = 0, long max = 100,
                         wxWindow *parent = NULL,
                         const wxPoint& pos = wxDefaultPosition);


void wxSetCursor(wxCursor& cursor);
//void wxBeginBusyCursor(wxCursor *cursor = wxHOURGLASS_CURSOR);

wxPoint wxGetMousePosition();
wxWindow* wxGetActiveWindow();

wxWindow* wxFindWindowAtPoint(const wxPoint& pt);

// this form has an out value as an argument
wxWindow* wxFindWindowAtPointer();
%MethodCode
    wxPoint pos;
    sipRes = wxFindWindowAtPointer(pos);
%End

wxWindow* wxGetTopLevelParent(wxWindow *win);

bool wxLaunchDefaultBrowser(const wxString& url);
bool wxGetKeyState(wxKeyCode key);

class wxMouseState
{
public:
    wxMouseState();
    ~wxMouseState();

    wxCoord     GetX();
    wxCoord     GetY();

    bool        LeftDown();
    bool        MiddleDown();
    bool        RightDown();

    bool        ControlDown();
    bool        ShiftDown();
    bool        AltDown();
    bool        MetaDown();
    bool        CmdDown();

    void        SetX(wxCoord x);
    void        SetY(wxCoord y);

    void        SetLeftDown(bool down);
    void        SetMiddleDown(bool down);
    void        SetRightDown(bool down);

    void        SetControlDown(bool down);
    void        SetShiftDown(bool down);
    void        SetAltDown(bool down);
    void        SetMetaDown(bool down);
};


wxMouseState wxGetMouseState();
unsigned long wxGetProcessId();
wxString wxGetOsDescription();
bool wxIsPlatformLittleEndian();
bool wxIsPlatform64Bit();

bool wxHandleFatalExceptions();

bool wxYieldIfNeeded();