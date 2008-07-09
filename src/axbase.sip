%If (WXMSW)

class _AxBaseWindow : wxWindow /PyName=AxBaseWindow/
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
        return PyMSWTranslateMessage((long)msg);
    }


    virtual bool PyMSWTranslateMessage(long msg)
    {
        return wxWindow::MSWTranslateMessage((WXMSG*)msg);
    }
};
%End // TypeHeaderCode

%TypeCode
IMPLEMENT_DYNAMIC_CLASS(_AxBaseWindow, wxWindow);
%End

public:
//    _AxBaseWindow(wxWindow* parent, const wxWindowID id=-1,
//                    const wxPoint& pos = wxDefaultPosition,
//                    const wxSize& size = wxDefaultSize,
//                    long style = 0,
//                    const wxString& name = wxPanelNameStr);

    _AxBaseWindow();
    _AxBaseWindow(wxWindow* parent /TransferThis/, unsigned long _hWnd);
%MethodCode
        WXHWND hWnd = (WXHWND)a1;
        sipCpp = new sip_AxBaseWindow;
        if (a0)
            a0->AddChild(sipCpp);
        sipCpp->SetEventHandler(sipCpp);
        sipCpp->SetHWND(hWnd);
        sipCpp->SubclassWin(hWnd);
        sipCpp->AdoptAttributesFromHWND();
        sipCpp->SetupColours();
%End

    virtual bool PyMSWTranslateMessage(long msg) /PyName=MSWTranslateMessage/;
};




%End // If (WXMSW)