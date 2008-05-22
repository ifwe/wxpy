//
// wxLog
//

typedef unsigned long wxTraceMask;
typedef unsigned long wxLogLevel;

enum
{
    wxLOG_FatalError, // program can't continue, abort immediately
    wxLOG_Error,      // a serious error, user must be informed about it
    wxLOG_Warning,    // user is normally informed about it but may be ignored
    wxLOG_Message,    // normal message (i.e. normal output of a non GUI app)
    wxLOG_Status,     // informational: might go to the status line of GUI app
    wxLOG_Info,       // informational message (a.k.a. 'Verbose')
    wxLOG_Debug,      // never shown to the user, disabled in release mode
    wxLOG_Trace,      // trace messages are also only enabled in debug mode
    wxLOG_Progress,   // used for progress indicator (not yet)
    wxLOG_User = 100, // user defined levels start here
    wxLOG_Max = 10000
};
/*
#define wxTRACE_MemAlloc "memalloc" // trace memory allocation (new/delete)
#define wxTRACE_Messages "messages" // trace window messages/X callbacks
#define wxTRACE_ResAlloc "resalloc" // trace GDI resource allocation
#define wxTRACE_RefCount "refcount" // trace various ref counting operations
#define wxTRACE_OleCalls "ole"      // OLE interface calls

#define wxTraceMemAlloc 0x0001  // trace memory allocation (new/delete)
#define wxTraceMessages 0x0002  // trace window messages/X callbacks
#define wxTraceResAlloc 0x0004  // trace GDI resource allocation
#define wxTraceRefCount 0x0008  // trace various ref counting operations
#define wxTraceOleCalls 0x0100  // OLE interface calls
*/

class wxLog
{
public:
    wxLog();
    ~wxLog();

    static bool IsEnabled();
    static bool EnableLogging(bool doIt = true);
//    static void OnLog(wxLogLevel level, const wxChar *szString, time_t t);
    virtual void Flush();
    static void FlushActive();
    static wxLog *GetActiveTarget();

    static wxLog *SetActiveTarget(wxLog *pLogger /Transfer/);
    static void Suspend();
    static void Resume();

    static void SetVerbose(bool bVerbose = true);
    static void SetLogLevel(wxLogLevel logLevel);
    static void DontCreateOnDemand();
    static void SetRepetitionCounting(bool bRepetCounting = true);
    static bool GetRepetitionCounting();
    static void SetTraceMask(wxTraceMask ulMask);
    static void AddTraceMask(const wxString& str);
    static void RemoveTraceMask(const wxString& str);
    static void ClearTraceMasks();
//    static const wxArrayString &GetTraceMasks();
//    static void SetTimestamp(const wxChar *ts);
    static bool GetVerbose();
    static wxTraceMask GetTraceMask();
//    static bool IsAllowedTraceMask(const wxChar *mask);
    static wxLogLevel GetLogLevel();
//    static const wxChar *GetTimestamp();
};

class wxLogStderr : wxLog
{
public:
    wxLogStderr(/* TODO: FILE *fp = (FILE *) NULL*/);
private:
    wxLogStderr(const wxLogStderr&);
};

class wxLogTextCtrl : wxLog
{
public:
    wxLogTextCtrl(wxTextCtrl *pTextCtrl);
private:
    wxLogTextCtrl(const wxLogTextCtrl&);
};

class wxLogGui : wxLog
{
public:
    wxLogGui();
};

class wxLogWindow : wxLog
{
public:
    wxLogWindow(wxFrame *pParent,         // the parent frame (can be NULL)
            const wxString& szTitle,      // the title of the frame
            bool bShow = true,            // show window immediately?
            bool bPassToOld = true);      // pass log messages to the old target?

    void Show(bool bShow = true);
    wxFrame *GetFrame() const;
    wxLog *GetOldLog() const;
    bool IsPassingMessages() const;
    void PassMessages(bool bDoPass);
private:
    wxLogWindow(const wxLogWindow&);
};


class wxLogChain : wxLog
{
public:
    wxLogChain(wxLog *logger);
    void SetLog(wxLog *logger);
    void PassMessages(bool bDoPass);
    bool IsPassingMessages();
    wxLog *GetOldLog();
    void DetachOldLog();
private:
    wxLogChain(const wxLogChain&);
};

class wxLogBuffer : wxLog
{
public:
    wxLogBuffer();
    //const wxString& GetBuffer() const;
    virtual void Flush();
private:
    wxLogBuffer(const wxLogBuffer&);
};

void wxSafeShowMessage(const wxString& title, const wxString& text);

class wxLogNull
{
public:
    wxLogNull();
    ~wxLogNull();
};
