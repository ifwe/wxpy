%ModuleHeaderCode
#include "wx/renderer.h"
%End

enum
{
    wxCONTROL_DISABLED   = 0x00000001,  // control is disabled
    wxCONTROL_FOCUSED    = 0x00000002,  // currently has keyboard focus
    wxCONTROL_PRESSED    = 0x00000004,  // (button) is pressed
    wxCONTROL_SPECIAL    = 0x00000008,  // control-specific bit:
    wxCONTROL_ISDEFAULT  = wxCONTROL_SPECIAL, // only for the buttons
    wxCONTROL_ISSUBMENU  = wxCONTROL_SPECIAL, // only for the menu items
    wxCONTROL_EXPANDED   = wxCONTROL_SPECIAL, // only for the tree items
    wxCONTROL_SIZEGRIP   = wxCONTROL_SPECIAL, // only for the status bar panes
    wxCONTROL_CURRENT    = 0x00000010,  // mouse is currently over the control
    wxCONTROL_SELECTED   = 0x00000020,  // selected item in e.g. listbox
    wxCONTROL_CHECKED    = 0x00000040,  // (check/radio button) is checked
    wxCONTROL_CHECKABLE  = 0x00000080,  // (menu) item can be checked
    wxCONTROL_UNDETERMINED = wxCONTROL_CHECKABLE, // (check) undetermined state

    wxCONTROL_FLAGS_MASK = 0x000000ff,

    // this is a pseudo flag not used directly by wxRenderer but rather by some
    // controls internally
    wxCONTROL_DIRTY      = 0x80000000
};

struct wxSplitterRenderParams
{
    wxSplitterRenderParams(wxCoord widthSash_, wxCoord border_, bool isSens_);
    ~wxSplitterRenderParams();

    const wxCoord widthSash;
    const wxCoord border;
    const bool isHotSensitive;
};

struct wxHeaderButtonParams
{
    wxHeaderButtonParams();
    ~wxHeaderButtonParams();

    wxColour    m_arrowColour;
    wxColour    m_selectionColour;
    wxString    m_labelText;
    wxFont      m_labelFont;
    wxColour    m_labelColour;
    wxBitmap    m_labelBitmap;
    int         m_labelAlignment;
};

enum wxHeaderSortIconType {
    wxHDR_SORT_ICON_NONE,        // Header button has no sort arrow
    wxHDR_SORT_ICON_UP,          // Header button an an up sort arrow icon
    wxHDR_SORT_ICON_DOWN         // Header button an a down sort arrow icon
};
/*
 * sip_wxcorecmodule.cpp(3893) : error C2582: 'operator =' function is unavailable
 * in 'wxRendererVersion'
 */

/*
struct wxRendererVersion
{
    wxRendererVersion(int version_, int age_);
    ~wxRendererVersion();

    enum
    {
        Current_Version,
        Current_Age
    };

    // check if the given version is compatible with the current one
    static bool IsCompatible(const wxRendererVersion& ver);

    const int version;
    const int age;
};
*/

class wxRendererNative
{
public:
    int DrawHeaderButton(wxWindow *win,
                         wxDC& dc,
                         const wxRect& rect,
                         int flags = 0,
                         wxHeaderSortIconType sortArrow = wxHDR_SORT_ICON_NONE,
                         wxHeaderButtonParams* params=NULL);


    virtual int DrawHeaderButtonContents(wxWindow *win,
                                         wxDC& dc,
                                         const wxRect& rect,
                                         int flags = 0,
                                         wxHeaderSortIconType sortArrow = wxHDR_SORT_ICON_NONE,
                                         wxHeaderButtonParams* params=NULL);

    virtual int GetHeaderButtonHeight(wxWindow *win);

    virtual void DrawTreeItemButton(wxWindow *win,
                                    wxDC& dc,
                                    const wxRect& rect,
                                    int flags = 0);

    virtual void DrawSplitterBorder(wxWindow *win,
                                    wxDC& dc,
                                    const wxRect& rect,
                                    int flags = 0);

    virtual void DrawSplitterSash(wxWindow *win,
                                  wxDC& dc,
                                  const wxSize& size,
                                  wxCoord position,
                                  wxOrientation orient,
                                  int flags = 0);

    virtual void DrawComboBoxDropButton(wxWindow *win,
                                        wxDC& dc,
                                        const wxRect& rect,
                                        int flags = 0);

    virtual void DrawDropArrow(wxWindow *win,
                               wxDC& dc,
                               const wxRect& rect,
                               int flags = 0);

    virtual void DrawCheckBox(wxWindow *win,
                              wxDC& dc,
                              const wxRect& rect,
                              int flags = 0);

    virtual void DrawPushButton(wxWindow *win,
                                wxDC& dc,
                                const wxRect& rect,
                                int flags = 0);

    virtual void DrawItemSelectionRect(wxWindow *win,
                                       wxDC& dc,
                                       const wxRect& rect,
                                       int flags = 0);

    virtual wxSplitterRenderParams GetSplitterParams(const wxWindow *win);

    static wxRendererNative& Get();
    static wxRendererNative& GetGeneric();
    static wxRendererNative& GetDefault();
    static wxRendererNative* Set(wxRendererNative *renderer);
    //virtual wxRendererVersion GetVersion() const;
};
