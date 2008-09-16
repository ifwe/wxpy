%ModuleHeaderCode
#include <wx/statusbr.h>
%End

enum {
    wxSB_NORMAL,
    wxSB_FLAT,
    wxSB_RAISED
};

%ModuleHeaderCode
#define wxDEFAULT_STATUSBAR_STYLE wxST_SIZEGRIP|wxFULL_REPAINT_ON_RESIZE
%End

class wxStatusBar : wxWindow
{
public:
    wxStatusBar(wxWindow* parent /TransferThis/, wxWindowID id = -1,
                long style = wxDEFAULT_STATUSBAR_STYLE,
                const wxString& name = wxStatusLineNameStr);
    virtual ~wxStatusBar();

    void SetFieldsCount(int number = 1 /*, const int *widths = NULL*/);
    int GetFieldsCount() const;

    virtual void SetStatusText(const wxString& text, int number = 0);
    virtual wxString GetStatusText(int number = 0) const;

    void PushStatusText(const wxString& text, int number = 0);
    void PopStatusText(int number = 0);

    void SetStatusWidths(int widths, const int* widths_field);
    void SetStatusStyles(int styles, const int* styles_field);

    // sets the minimal vertical size of the status bar
    void SetMinHeight(int height);

    // get the dimensions of the horizontal and vertical borders
    int GetBorderX() const;
    int GetBorderY() const;
};
