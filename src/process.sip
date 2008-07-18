%ModuleHeaderCode
#ifndef WXPY_PREC
#include <wx/utils.h>
#endif
%End

enum wxKillError
{
    wxKILL_OK,
    wxKILL_BAD_SIGNAL,
    wxKILL_ACCESS_DENIED,
    wxKILL_NO_PROCESS,
    wxKILL_ERROR
};

enum wxKillFlags
{
    wxKILL_NOCHILDREN,
    wxKILL_CHILDREN,
};


enum wxSignal
{
    wxSIGNONE,
    wxSIGHUP,
    wxSIGINT,
    wxSIGQUIT,
    wxSIGILL,
    wxSIGTRAP,
    wxSIGABRT,
    wxSIGIOT,
    wxSIGEMT,
    wxSIGFPE,
    wxSIGKILL,
    wxSIGBUS,
    wxSIGSEGV,
    wxSIGSYS,
    wxSIGPIPE,
    wxSIGALRM,
    wxSIGTERM
};

enum
{
    wxEXEC_ASYNC,
    wxEXEC_SYNC,
    wxEXEC_NOHIDE,
    wxEXEC_MAKE_GROUP_LEADER,
    wxEXEC_NODISABLE
};

long wxExecute(const wxString& command, int flags = wxEXEC_ASYNC);

