%ModuleHeaderCode
#ifndef WXPY_PREC
#include <wx/dnd.h>
#endif
%End

enum
{
    wxDrag_CopyOnly    = 0, // allow only copying
    wxDrag_AllowMove   = 1, // allow moving (copying is always allowed)
    wxDrag_DefaultMove = 3  // the default operation is move, not copy
};

// result of wxDropSource::DoDragDrop() call
enum wxDragResult
{
    wxDragError,    // error prevented the d&d operation from completing
    wxDragNone,     // drag target didn't accept the data
    wxDragCopy,     // the data was successfully copied
    wxDragMove,     // the data was successfully moved (MSW only)
    wxDragLink,     // operation is a drag-link
    wxDragCancel    // the operation was cancelled by user (not an error)
};

bool wxIsDragResultOk(wxDragResult res);

class wxDropTarget
{
    wxDropTarget(wxDataObject* = NULL) /Transfer/;
    ~wxDropTarget();

    wxDataObject *GetDataObject() const;
    void SetDataObject(wxDataObject *dataObject /Transfer/);

    virtual wxDragResult OnEnter(wxCoord x, wxCoord y, wxDragResult def);
    virtual wxDragResult OnDragOver(wxCoord x, wxCoord y, wxDragResult def);
    virtual void OnLeave();

    virtual bool OnDrop(wxCoord x, wxCoord y) = 0;
    virtual wxDragResult OnData(wxCoord x, wxCoord y, wxDragResult def) = 0;
    virtual bool GetData() = 0;

    void SetDefaultAction(wxDragResult action);
    wxDragResult GetDefaultAction();
};

class wxDropSource
{
public:

//%If (WXGTK)
     wxDropSource(wxWindow *win,
                    const wxCursor &copy = wxNullCursor,
                    const wxCursor &move = wxNullCursor,
                    const wxCursor &none = wxNullCursor);
/*
%End
%If (!WXGTK)
    wxDropSource(wxWindow *win,
                   const wxIcon& copy = wxNullIcon,
                   const wxIcon& move = wxNullIcon,
                   const wxIcon& none = wxNullIcon);
%End
*/
    ~wxDropSource();

    void SetData(wxDataObject& data);
    wxDataObject *GetDataObject();
    void SetCursor(wxDragResult res, const wxCursor& cursor);
    virtual bool GiveFeedback(wxDragResult effect);
private:
    wxDropSource(const wxDropSource&);
};


