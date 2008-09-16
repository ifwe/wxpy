%ModuleHeaderCode
#include <wx/display.h>
#include <wx/vidmode.h>
%End

struct wxVideoMode
{
    wxVideoMode(int width = 0, int height = 0, int depth = 0, int freq = 0);
    ~wxVideoMode();

    bool Matches(const wxVideoMode& other) const;
    int GetWidth() const;
    int GetHeight() const;
    int GetDepth() const;
    bool IsOk() const;

    int w;
    int h;
    int bpp;
    int refresh;
};

class wxDisplay
{
private:
    wxDisplay(const wxDisplay&);

public:
    wxDisplay(unsigned index = 0);
    virtual ~wxDisplay();

    static unsigned GetCount();
    static int GetFromPoint(const wxPoint& pt);
    static int GetFromWindow(wxWindow *window);
    bool IsOk() const;
    wxRect GetGeometry() const;
    wxRect GetClientArea() const;
    wxString GetName() const;
    bool IsPrimary() const;
    wxVideoMode GetCurrentMode() const;

    bool ChangeMode(const wxVideoMode& mode = wxDefaultVideoMode);
    void ResetMode();
};

//---------------------------------------------------------------------------
