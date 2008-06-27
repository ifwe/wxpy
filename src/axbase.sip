%If (WXMSW)

class _AxBaseWindow : wxWindow
{

typedef void* WXMSG;

%TypeHeaderCode
#ifndef WXPY_PREC
#include <wx/window.h>
#endif

class _AxBaseWindow : public wxWindow
{
    DECLARE_DYNAMIC_CLASS(_AxBaseWindow)

public:
    _AxBaseWindow(wxWindow* parent, const wxWindowID id=-1,
                    const wxPoint& pos = wxDefaultPosition,
                    const wxSize& size = wxDefaultSize,
                    long style = 0,
                    const wxString& name = wxPanelNameStr)
    : wxWindow(parent, id, pos, size, style, name) {}

    _AxBaseWindow() : wxWindow() {}

    bool MSWTranslateMessage(WXMSG* msg)
    {
        return PyMSWTranslateMessage(msg);
    }


    virtual bool PyMSWTranslateMessage(void* msg)
    {
        return wxWindow::MSWTranslateMessage((WXMSG*)msg);
    }
};
%End // TypeHeaderCode

%TypeCode
IMPLEMENT_DYNAMIC_CLASS(_AxBaseWindow, wxWindow);
%End

public:
    _AxBaseWindow(wxWindow* parent, const wxWindowID id=-1,
                    const wxPoint& pos = wxDefaultPosition,
                    const wxSize& size = wxDefaultSize,
                    long style = 0,
                    const wxString& name = wxPanelNameStr);

    virtual bool PyMSWTranslateMessage(WXMSG msg) /PyName=MSWTranslateMessage/;
};


_AxBaseWindow* _AxBaseWindow_FromHWND(wxWindow* parent, unsigned long _hWnd);
%MethodCode
    WXHWND hWnd = (WXHWND)a1;
    _AxBaseWindow* win = new _AxBaseWindow;
    if (a0)
        a0->AddChild(win);
    win->SetEventHandler(win);
    win->SetHWND(hWnd);
    win->SubclassWin(hWnd);
    win->AdoptAttributesFromHWND();
    win->SetupColours();
    sipRes = win;
%End


%End // If (WXMSW)