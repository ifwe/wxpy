class wxStandardPaths
{
%TypeHeaderCode
#ifndef WXPY_PREC
#include <wx/stdpaths.h>
#endif
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
    wxStandardPaths& stdpaths = (wxStandardPaths&)wxStandardPaths::Get();
    sipRes = &stdpaths;
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

%If (WXMSW)
    wxString GetSpecialFolder(int) const;
%End
};