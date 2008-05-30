//
// wxValidator
//

class wxValidator : wxEvtHandler
{

public:
    wxValidator();

    static bool IsSilent();
    static void SetBellOnError(bool doIt = true);
};
