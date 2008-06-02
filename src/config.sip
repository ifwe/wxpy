%ModuleHeaderCode
#ifndef WXPY_PREC
#include <wx/confbase.h>
#include <wx/fileconf.h>
#endif
%End

%If (WXMSW)
%ModuleHeaderCode
#ifndef WXPY_PREC
#include <wx/msw/regconf.h>
#endif
%End
%End

enum
{
    wxCONFIG_USE_LOCAL_FILE,
    wxCONFIG_USE_GLOBAL_FILE,
    wxCONFIG_USE_RELATIVE_PATH,
    wxCONFIG_USE_NO_ESCAPE_CHARACTERS
};

class wxConfigBase {
private:
    wxConfigBase();
public:
    virtual ~wxConfigBase();

    enum EntryType
    {
        Type_Unknown,
        Type_String,
        Type_Boolean,
        Type_Integer,
        Type_Float
    };

    static wxConfigBase* Set(wxConfigBase *config /Transfer/);
    static wxConfigBase* Get(bool createOnDemand = true);
    static wxConfigBase* Create();
    static void DontCreateOnDemand();
    //void SetPath(const wxString& path);
    //const wxString& GetPath() const;
    size_t GetNumberOfEntries(bool recursive = false) const;
    size_t GetNumberOfGroups(bool recursive = false) const;
    bool HasGroup(const wxString& name) const;
    bool HasEntry(const wxString& name) const;
    bool Exists(const wxString& name) const;
    EntryType GetEntryType(const wxString& name) const;
    wxString Read(const wxString& key, const wxString& defaultVal = wxEmptyString);
/*
    int ReadInt(const wxString& key, long defaultVal = 0);
%MethodCode
    long rv;
    sipCpp->Read(*a0, &rv, *a1);
    sipRes = rv;
%End

    float ReadFloat(const wxString& key, float defaultVal = 0);
%MethodCode
    float rv;
    sipCpp->Read(*a0, &rv, *a1);
    sipRes = rv;
%End

    bool ReadBool(const wxString& key, bool defaultVal = 0);
%MethodCode
    bool rv;
    sipCpp->Read(*a0, &rv, *a1);
    sipRes = rv;
%End
*/
    bool Write(const wxString& key, const wxString& value);
/*    bool Write(const wxString& key, long value);
    bool Write(const wxString& key, double value);
    bool Write(const wxString& key, bool value);
*/
    bool Flush(bool currentOnly = false);
    bool RenameEntry(const wxString& oldName, const wxString& newName);
    bool RenameGroup(const wxString& oldName, const wxString& newName);
    bool DeleteEntry(const wxString& key, bool deleteGroupIfEmpty = true);
    bool DeleteGroup(const wxString& key);
    bool DeleteAll();
    void SetExpandEnvVars(bool doIt = true);
    bool IsExpandingEnvVars() const;
    void SetRecordDefaults(bool doIt = true);
    bool IsRecordingDefaults() const;
    wxString ExpandEnvVars(const wxString& str) const;
    wxString GetAppName() const;
    wxString GetVendorName() const;
    void SetAppName(const wxString& appName);
    void SetVendorName(const wxString& vendorName);
    void SetStyle(long style);
    long GetStyle() const;
};


class wxConfig : wxConfigBase
{
private:
    wxConfig(const wxConfig&);
public:
    wxConfig(const wxString& appName = wxEmptyString,
             const wxString& vendorName = wxEmptyString,
             const wxString& localFilename = wxEmptyString,
             const wxString& globalFilename = wxEmptyString,
             long style = wxCONFIG_USE_LOCAL_FILE | wxCONFIG_USE_GLOBAL_FILE);

    virtual ~wxConfig();
};

class wxFileConfig : wxConfigBase
{
private:
    wxFileConfig(const wxFileConfig&);

public:
    wxFileConfig(const wxString& appName = wxEmptyString,
                 const wxString& vendorName = wxEmptyString,
                 const wxString& localFilename = wxEmptyString,
                 const wxString& globalFilename = wxEmptyString,
                 long style = wxCONFIG_USE_LOCAL_FILE | wxCONFIG_USE_GLOBAL_FILE);

    virtual ~wxFileConfig();
};

/*
class wxConfigPathChanger
{
public:
    wxConfigPathChanger(const wxConfigBase *config, const wxString& entry);
    ~wxConfigPathChanger();
    const wxString& Name() const;
};

wxString wxExpandEnvVars(const wxString &sz);
*/