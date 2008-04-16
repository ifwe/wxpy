%ModuleHeaderCode
#include <wx/sound.h>
%End

enum wxSoundFlags
{
    wxSOUND_SYNC,
    wxSOUND_ASYNC,
    wxSOUND_LOOP
};


class wxSound : wxObject
{
public:
    bool Play(unsigned flags = wxSOUND_ASYNC) const;
    static bool Play(const wxString& filename, unsigned flags = wxSOUND_ASYNC) /PyName=PlaySound/;
};
