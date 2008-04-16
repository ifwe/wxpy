class wxStandardPaths
{
%TypeHeaderCode
#include <wx/stdpaths.h>
%End

public:
    enum ResourceCat
    {
        ResourceCat_None,
        ResourceCat_Messages,
        ResourceCat_Max
    };

    
    static wxStandardPaths* Get();
%MethodCode
    // manual cast is necessary because of the singleton subclass
    sipRes = (wxStandardPaths*)&wxStandardPaths::Get();
%End


    wxString GetExecutablePath() const;
    wxString GetConfigDir() const;
    wxString GetUserConfigDir() const;
    wxString GetDataDir() const;
    wxString GetLocalDataDir() const;
    wxString GetUserDataDir() const;
    wxString GetUserLocalDataDir() const;
    wxString GetPluginsDir() const;
    wxString GetResourcesDir() const;
    wxString GetLocalizedResourcesDir(const wxString& lang, ResourceCat category = ResourceCat_None) const;
    wxString GetDocumentsDir() const;
    wxString GetTempDir() const;
};