%If (WXMSW)
%If (wxUSE_CRASHREPORT)

enum
{
    wxCRASH_REPORT_LOCATION,
    wxCRASH_REPORT_STACK,
    wxCRASH_REPORT_LOCALS,
    wxCRASH_REPORT_GLOBALS,
    wxCRASH_REPORT_DEFAULT,
};

class wxCrashReport
{
private:
    wxCrashReport();
    wxCrashReport(const wxCrashReport&);
    ~wxCrashReport();
public:
    static void SetFileName(const wxString& filename);
    static bool GenerateNow(int flags = wxCRASH_REPORT_DEFAULT);
    static bool Generate(int flags = wxCRASH_REPORT_DEFAULT);
    static wxString GetFileName();
};

%End
%End