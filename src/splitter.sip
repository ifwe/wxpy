%ModuleHeaderCode
void add_event(PyObject* module_dict, const char* name, ...);

#include <wx/splitter.h>
%End

%PostInitialisationCode
add_event(sipModuleDict, "EVT_SPLITTER_SASH_POS_CHANGED",  wxEVT_COMMAND_SPLITTER_SASH_POS_CHANGED, 0);
add_event(sipModuleDict, "EVT_SPLITTER_SASH_POS_CHANGING", wxEVT_COMMAND_SPLITTER_SASH_POS_CHANGING, 0);
add_event(sipModuleDict, "EVT_SPLITTER_DOUBLECLICKED",     wxEVT_COMMAND_SPLITTER_DOUBLECLICKED, 0);
add_event(sipModuleDict, "EVT_SPLITTER_UNSPLIT",           wxEVT_COMMAND_SPLITTER_UNSPLIT, 0);
//add_event(sipModuleDict, "EVT_SPLITTER_DCLICK",            wxEVT_COMMAND_SPLITTER_DCLICK, 0);
%End

enum {
    wxSP_NOBORDER,
    wxSP_NOSASH,
    wxSP_PERMIT_UNSPLIT,
    wxSP_LIVE_UPDATE,
    wxSP_3DSASH,
    wxSP_3DBORDER,
    wxSP_NO_XP_THEME,
    wxSP_BORDER,
    wxSP_3D,
};


enum wxSplitMode
{
    wxSPLIT_HORIZONTAL = 1,
    wxSPLIT_VERTICAL
};

enum
{
    wxSPLIT_DRAG_NONE,
    wxSPLIT_DRAG_DRAGGING,
    wxSPLIT_DRAG_LEFT_DOWN
};

class wxSplitterWindow : wxWindow
{
public:
    wxSplitterWindow(wxWindow* parent, wxWindowID id=-1,
                     const wxPoint& pos = wxDefaultPosition,
                     const wxSize& size = wxDefaultSize,
                     long style=wxSP_3D,
                     const wxString& name = wxT("wxSplitterWindow"));

    wxWindow * GetWindow1() const;
    wxWindow * GetWindow2() const;
    void SetSplitMode(int mode);
    wxSplitMode GetSplitMode() const;
    void Initialize(wxWindow *window);
    virtual bool SplitVertically(wxWindow *window1, wxWindow *window2, int sashPosition = 0);
    virtual bool SplitHorizontally(wxWindow *window1, wxWindow *window2, int sashPosition = 0);
    bool Unsplit(wxWindow *toRemove = NULL);
    bool ReplaceWindow(wxWindow *winOld, wxWindow *winNew);
    void UpdateSize();
    bool IsSplit() const;
    void SetSashSize(int width);
    void SetBorderSize(int width);
    int GetSashSize() const;
    int GetBorderSize() const;
    void SetSashPosition(int position, bool redraw = true);
    int GetSashPosition() const;
    void SetSashGravity(double gravity);
    double GetSashGravity() const;
    void SetMinimumPaneSize(int min);
    int GetMinimumPaneSize() const;
    virtual bool SashHitTest(int x, int y, int tolerance = 5);
    virtual void SizeWindows();
    void SetNeedUpdating(bool needUpdating);
    bool GetNeedUpdating() const;
};

class wxSplitterEvent : wxNotifyEvent
{
public:
    wxSplitterEvent(wxEventType type = wxEVT_NULL,
                    wxSplitterWindow *splitter = NULL);

    void SetSashPosition(int pos);
    int GetSashPosition() const;
    wxWindow* GetWindowBeingRemoved() const;
    int GetX() const;
    int GetY() const;
private:
    wxSplitterEvent(const wxSplitterEvent&);
};
