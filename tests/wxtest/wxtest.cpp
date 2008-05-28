/*
 * hworld.cpp
 * Hello world sample by Robert Roebling
 */

#include <wx/wx.h>
#include <wx/dcbuffer.h>

class MyApp: public wxApp
{
    virtual bool OnInit();
};

class MyFrame: public wxFrame
{
public:

    MyFrame(const wxString& title, const wxPoint& pos, const wxSize& size);

    void OnQuit(wxCommandEvent& event);
    void OnAbout(wxCommandEvent& event);
    void OnPaint(wxPaintEvent& event);

    DECLARE_EVENT_TABLE()
};

enum
{
    ID_Quit = 1,
    ID_About,
};

BEGIN_EVENT_TABLE(MyFrame, wxFrame)
    EVT_PAINT(MyFrame::OnPaint)
    EVT_MENU(ID_Quit, MyFrame::OnQuit)
    EVT_MENU(ID_About, MyFrame::OnAbout)
END_EVENT_TABLE()

IMPLEMENT_APP(MyApp)

bool MyApp::OnInit()
{
    wxString title;
    int size = 0;

    wxStockGDI& s = wxStockGDI::instance();
    const wxFont* f1 = s.GetFont(wxStockGDI::FONT_NORMAL);

    const wxFont* f2 = wxStockGDI::instance().GetFont(wxStockGDI::FONT_NORMAL);
    const wxFont* f3 = wxNORMAL_FONT;

    printf("%p %p %p\n", f1, f2, f3);

    size = wxNORMAL_FONT->GetPointSize();
    title.Printf(_T("Hello, World! %d"), size);

    MyFrame *frame = new MyFrame(title, wxPoint(50,50), wxSize(450,340) );
    frame->Show(TRUE);
    SetTopWindow(frame);
    return TRUE;
}

MyFrame::MyFrame(const wxString& title, const wxPoint& pos, const wxSize& size)
: wxFrame((wxFrame *)NULL, -1, title, pos, size)
{
    wxMenu *menuFile = new wxMenu;

    menuFile->Append(ID_About, _T("&About..."));
    menuFile->AppendSeparator();
    menuFile->Append(ID_Quit, _T("E&xit"));

    wxMenuBar *menuBar = new wxMenuBar;
    menuBar->Append(menuFile, _T("&File"));

    SetMenuBar(menuBar);

    CreateStatusBar();
    SetStatusText(_T("Welcome to wxWindows!"));
}

void MyFrame::OnPaint(wxPaintEvent& event)
{
    wxBufferedPaintDC dc(this);

    dc.SetBrush(*wxWHITE_BRUSH);
    dc.SetPen(*wxTRANSPARENT_PEN);
    dc.DrawRectangle(wxRect(GetClientSize()));

    wxGraphicsContext* gc = wxGraphicsContext::Create(dc);
    gc->SetPen(*wxRED_PEN);
    gc->SetBrush(*wxBLUE_BRUSH);
    gc->DrawRoundedRectangle(50, 50, 150, 150, 5);
    delete gc;

}

void MyFrame::OnQuit(wxCommandEvent& WXUNUSED(event))
{
    Close(TRUE);
}

void MyFrame::OnAbout(wxCommandEvent& WXUNUSED(event))
{
    wxMessageBox(_T("This is a wxWindows Hello world sample"),
        _T("About Hello World"), wxOK | wxICON_INFORMATION, this);
}

