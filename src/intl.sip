%ModuleHeaderCode
#ifndef WXPY_PREC
#include <wx/intl.h>
#endif
%End

enum wxLanguage
{
    wxLANGUAGE_DEFAULT,
};

struct wxLanguageInfo
{
    int Language;
    wxString CanonicalName;
    wxString Description;
};

enum wxLocaleCategory
{
    wxLOCALE_CAT_NUMBER,
    wxLOCALE_CAT_DATE,
    wxLOCALE_CAT_MONEY,
    wxLOCALE_CAT_MAX
};

enum wxLocaleInfo
{
    wxLOCALE_THOUSANDS_SEP,
    wxLOCALE_DECIMAL_POINT
};

enum wxLocaleInitFlags
{
    wxLOCALE_LOAD_DEFAULT  = 0x0001,     // load wxwin.mo?
    wxLOCALE_CONV_ENCODING = 0x0002      // convert encoding on the fly?
};

class wxLocale
{
private:
    wxLocale(const wxLocale&);
public:
    wxLocale(int language, int flags = wxLOCALE_LOAD_DEFAULT | wxLOCALE_CONV_ENCODING);
    ~wxLocale();

    static int GetSystemLanguage();
    static wxFontEncoding GetSystemEncoding();
    static wxString GetSystemEncodingName();

    bool IsOk() const;
    int __nonzero__();
%MethodCode
        sipRes = sipCpp->IsOk();
%End

    wxString GetLocale() const;
    int GetLanguage() const;

    wxString GetSysName() const;
    wxString GetCanonicalName() const;
    static void AddCatalogLookupPathPrefix(const wxString& prefix);

    bool AddCatalog(const wxString& szDomain);

    static bool IsAvailable(int lang);

    bool IsLoaded(const wxString& szDomain) const;

//    static const wxLanguageInfo *GetLanguageInfo(int lang);
    static wxString GetLanguageName(int lang);

//    static const wxLanguageInfo *FindLanguageInfo(const wxString& locale);
    static void AddLanguage(const wxLanguageInfo& info);

    wxString GetString(const wxString& szOrigString,
                       const wxString& szDomain = wxEmptyString) const;

    const wxString& GetName() const;

};
enum
{
    wxCONVERT_STRICT,
    wxCONVERT_SUBSTITUTE
};


enum
{
    wxPLATFORM_CURRENT = -1,

    wxPLATFORM_UNIX = 0,
    wxPLATFORM_WINDOWS,
    wxPLATFORM_OS2,
    wxPLATFORM_MAC
};
