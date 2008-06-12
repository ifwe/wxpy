%Module _wxhtml
%Import wx.sip
%UnitCode
#include "stdwxpy.h"
%End


%ModuleHeaderCode
#include <wx/html/htmlwin.h>
%End


%PreInitialisationCode

%End

%PostInitialisationCode
typedef void (*add_event_type)(PyObject* moduple_dict, const char* name, ...);
add_event_type add_event = (add_event_type)sipImportSymbol("wxpy_add_event");

add_event(sipModuleDict, "EVT_HTML_CELL_CLICKED", wxEVT_COMMAND_HTML_CELL_CLICKED, 0);
add_event(sipModuleDict, "EVT_HTML_CELL_HOVER",   wxEVT_COMMAND_HTML_CELL_HOVER, 0);
add_event(sipModuleDict, "EVT_HTML_LINK_CLICKED", wxEVT_COMMAND_HTML_LINK_CLICKED, 0);

%End

enum {
    wxHTML_ALIGN_LEFT,
    wxHTML_ALIGN_CENTER,
    wxHTML_ALIGN_RIGHT,
    wxHTML_ALIGN_BOTTOM,
    wxHTML_ALIGN_TOP,

    wxHTML_CLR_FOREGROUND,
    wxHTML_CLR_BACKGROUND,

    wxHTML_UNITS_PIXELS,
    wxHTML_UNITS_PERCENT,

    wxHTML_INDENT_LEFT,
    wxHTML_INDENT_RIGHT,
    wxHTML_INDENT_TOP,
    wxHTML_INDENT_BOTTOM,

    wxHTML_INDENT_HORIZONTAL,
    wxHTML_INDENT_VERTICAL,
    wxHTML_INDENT_ALL,

    wxHTML_COND_ISANCHOR,
    wxHTML_COND_ISIMAGEMAP,
    wxHTML_COND_USER,

};


enum {
    wxHW_SCROLLBAR_NEVER,
    wxHW_SCROLLBAR_AUTO,
    wxHW_NO_SELECTION,
    wxHW_DEFAULT_STYLE,
};


// enums for wxHtmlWindow::OnOpeningURL
enum wxHtmlOpeningStatus
{
    wxHTML_OPEN,
    wxHTML_BLOCK,
    wxHTML_REDIRECT
};

enum wxHtmlURLType
{
    wxHTML_URL_PAGE,
    wxHTML_URL_IMAGE,
    wxHTML_URL_OTHER
};


class wxHtmlLinkInfo : wxObject
{
public:
    wxHtmlLinkInfo(const wxString& href, const wxString& target = wxEmptyString);
    virtual ~wxHtmlLinkInfo();

    wxString GetHref();
    wxString GetTarget();
    //wxMouseEvent* GetEvent();
    //wxHtmlCell* GetHtmlCell();

    void SetEvent(const wxMouseEvent *e);
    //void SetHtmlCell(const wxHtmlCell * e);
};

class wxHtmlWindow : wxWindow
{
private:
    wxHtmlWindow(const wxHtmlWindow&);
    wxHtmlWindow();
public:
    wxHtmlWindow(wxWindow *parent /TransferThis/, int id = -1,
                 const wxPoint& pos = wxDefaultPosition,
                 const wxSize& size = wxDefaultSize,
                 int style = wxHW_DEFAULT_STYLE,
                 const wxString& name = wxT("HtmlWindow"));
    virtual ~wxHtmlWindow();


    bool SetPage(const wxString& source);
    bool LoadPage(const wxString& location);
    bool LoadFile(const wxString& filename);
    bool AppendToPage(const wxString& source);
    wxString GetOpenedPage();
    wxString GetOpenedAnchor();
    wxString GetOpenedPageTitle();

    void SetRelatedFrame(wxFrame* frame, const wxString& format);
    wxFrame* GetRelatedFrame();

    void SetRelatedStatusBar(int bar);

    void SetStandardFonts(int size = -1,
                          const wxString& normal_face = wxEmptyString,
                          const wxString& fixed_face = wxEmptyString);

    void SetLabel(const wxString& title);

    // Sets space between text and window borders.
    void SetBorders(int b);

    // Sets the bitmap to use for background (currnetly it will be tiled,
    // when/if we have CSS support we could add other possibilities...)
    void SetBackgroundImage(const wxBitmap& bmpBg);

    // Saves custom settings into cfg config. it will use the path 'path'
    // if given, otherwise it will save info into currently selected path.
    // saved values : things set by SetFonts, SetBorders.
    //void ReadCustomization(wxConfigBase *cfg, wxString path = wxEmptyString);
    //void WriteCustomization(wxConfigBase *cfg, wxString path = wxEmptyString);

    void SetFonts(wxString normal_face, wxString fixed_face);

    // Goes to previous/next page (in browsing history)
    // Returns True if successful, False otherwise
    bool HistoryBack();
    bool HistoryForward();
    bool HistoryCanBack();
    bool HistoryCanForward();
    void HistoryClear();

    // wxHtmlContainerCell* GetInternalRepresentation();
    //wxHtmlWinParser* GetParser();

//    bool ScrollToAnchor(const wxString& anchor);
//    bool HasAnchor(const wxString& anchor);

    //Adds input filter
    //static void AddFilter(wxPyHtmlFilter *filter);

    void SelectWord(const wxPoint& pos);
    void SelectLine(const wxPoint& pos);
    void SelectAll();

    wxString SelectionToText();
    wxString ToText();

    enum HTMLCursor
    {
        HTMLCursor_Default,
        HTMLCursor_Link,
        HTMLCursor_Text
    };

    static wxCursor GetDefaultHTMLCursor(HTMLCursor type);
};

class wxHtmlTag : wxObject
{
public:
    virtual ~wxHtmlTag();

    wxHtmlTag *GetParent() const;
    wxHtmlTag *GetFirstSibling() const;
    wxHtmlTag *GetLastSibling() const;
    wxHtmlTag *GetChildren() const;
    wxHtmlTag *GetPreviousSibling() const;
    wxHtmlTag *GetNextSibling() const;
    wxHtmlTag *GetNextTag() const;

    wxString GetName() const;
    bool HasParam(const wxString& par) const;
    wxString GetParam(const wxString& par, bool with_commas = false) const;
    bool GetParamAsColour(const wxString& par, wxColour *clr) const;
    bool GetParamAsInt(const wxString& par, int *clr) const;
    int ScanParam(const wxString& par, const wxChar *format, void *param) const;
    wxString GetAllParams() const;
    bool HasEnding() const;
    int GetBeginPos() const;
    int GetEndPos1() const;
    int GetEndPos2() const;

private:
    wxHtmlTag(const wxHtmlTag&);
};



class wxHtmlParser
{
private:
    wxHtmlParser();

};

class wxHtmlTagHandler : wxObject
{
public:
    wxHtmlTagHandler();
    virtual ~wxHtmlTagHandler();

    void SetParser(wxHtmlParser *parser);
    void ParseInner(const wxHtmlTag& tag);

    virtual wxString GetSupportedTags() = 0;
    virtual bool HandleTag(const wxHtmlTag& tag) = 0;
private:
    wxHtmlTagHandler(const wxHtmlTagHandler&);
};

class wxHtmlWidgetCell : wxHtmlCell {
public:
    wxHtmlWidgetCell(wxWindow* wnd, int w = 0);
    virtual ~wxHtmlWidgetCell();
};


class wxHtmlWinTagHandler : wxHtmlTagHandler
{
public:
    wxHtmlWinTagHandler();
    virtual ~wxHtmlWinTagHandler();

    void SetParser(wxHtmlParser *parser);
    wxHtmlWinParser* GetParser() const;

private:
    wxHtmlWinTagHandler(const wxHtmlWinTagHandler&);
};


class wxHtmlCell : wxObject
{
private:
    wxHtmlCell(const wxHtmlCell&);
public:
    wxHtmlCell();
    ~wxHtmlCell();

    int GetPosX();
    int GetPosY();
    int GetWidth();
    int GetHeight();
    int GetDescent();

    int GetMaxTotalWidth() const;

    const wxString& GetId() const;
    void SetId(const wxString& id);
    wxHtmlLinkInfo* GetLink(int x = 0, int y = 0);
    wxHtmlCell* GetNext();
    //wxHtmlContainerCell* GetParent();
    wxHtmlCell* GetFirstChild() const;

    virtual wxCursor GetMouseCursor(wxHtmlWindowInterface *window) const;

    //wxCursor GetCursor() const;
    bool IsFormattingCell() const;
    void SetLink(const wxHtmlLinkInfo& link);
    void SetNext(wxHtmlCell *cell /Transfer/);
//  void SetParent(wxHtmlContainerCell *p);
    void SetPos(int x, int y);
    void Layout(int w);
    //void Draw(wxDC& dc, int x, int y, int view_y1, int view_y2,
    //          wxHtmlRenderingInfo& info);
    //void DrawInvisible(wxDC& dc, int x, int y,
    //          wxHtmlRenderingInfo& info);
    const wxHtmlCell* Find(int condition, const void* param);


    virtual bool ProcessMouseClick(wxHtmlWindowInterface *window,
                                   const wxPoint& pos,
                                   const wxMouseEvent& event);

    void SetCanLiveOnPagebreak(bool can);
    bool IsLinebreakAllowed() const;
    bool IsTerminalCell() const;
    wxHtmlCell *FindCellByPos(wxCoord x, wxCoord y,
                                  unsigned flags = wxHTML_FIND_EXACT) const;
    wxPoint GetAbsPos(wxHtmlCell *rootCell = NULL) const;
    wxHtmlCell *GetRootCell() const;

    wxHtmlCell *GetFirstTerminal() const ;
    wxHtmlCell *GetLastTerminal() const ;

    unsigned GetDepth() const;
    bool IsBefore(wxHtmlCell *cell) const;
    //wxString ConvertToText(wxHtmlSelection *sel) const;
};


class wxHtmlContainerCell : wxHtmlCell
{
private:
    wxHtmlContainerCell(const wxHtmlContainerCell&);
public:
    wxHtmlContainerCell(wxHtmlContainerCell *parent);

    void InsertCell(wxHtmlCell *cell /Transfer/);

    void SetAlignHor(int al);
    int GetAlignHor();
    void SetAlignVer(int al);
    int GetAlignVer();
    void SetIndent(int i, int what, int units = wxHTML_UNITS_PIXELS);
    int GetIndent(int ind);
    int GetIndentUnits(int ind);
    void SetAlign(const wxHtmlTag& tag);
    void SetWidthFloat(int w, int units);
    void SetWidthFloat(const wxHtmlTag& tag) /PyName=SetWidthFloatFromTag/;
    void SetMinHeight(int h, int align = wxHTML_ALIGN_TOP);
    void SetBackgroundColour(const wxColour& clr);
    wxColour GetBackgroundColour();
    void SetBorder(const wxColour& clr1, const wxColour& clr2);
    wxHtmlCell* GetFirstChild();
    //%pragma(python) addtoclass = "GetFirstCell = GetFirstChild"
};



class wxHtmlWinParser
{
%TypeCode

class wxPyHtmlTagsModule : public wxHtmlTagsModule
{
public:
    wxPyHtmlTagsModule(PyObject* thc) : wxHtmlTagsModule() {
        m_tagHandlerClass = thc;
        Py_INCREF(m_tagHandlerClass);
        RegisterModule(this);
        wxHtmlWinParser::AddModule(this);
    }

    void OnExit() {
        SIP_BLOCK_THREADS
        Py_DECREF(m_tagHandlerClass);
        m_tagHandlerClass = NULL;
        for (size_t x=0; x < m_objArray.GetCount(); x++)
        {
            PyObject* obj = (PyObject*)m_objArray.Item(x);
            Py_DECREF(obj);
        }
        SIP_UNBLOCK_THREADS
    };

    void FillHandlersTable(wxHtmlWinParser *parser)
    {
        // First, make a new instance of the tag handler
        SIP_BLOCK_THREADS
        PyObject* arg = PyTuple_New(0);
        PyObject* obj = PyObject_CallObject(m_tagHandlerClass, arg);
        Py_DECREF(arg);

        // now figure out where it's C++ object is...
        wxHtmlWinTagHandler* thPtr = 0;
        int sipIsErr = 0;

        if (sipCanConvertToInstance(obj, sipClass_wxHtmlWinTagHandler, SIP_NOT_NONE))
        {
            // add it,
            thPtr = (wxHtmlWinTagHandler*)sipConvertToInstance(obj, sipClass_wxHtmlWinTagHandler,
                                                               NULL, SIP_NOT_NONE, NULL, &sipIsErr);
            parser->AddTagHandler(thPtr);

            // and track it.
            m_objArray.Add(obj);

        }
        else
            sipIsErr = 1;

        SIP_UNBLOCK_THREADS
    }

private:
    PyObject*           m_tagHandlerClass;
    wxArrayPtrVoid      m_objArray;

};

%End

public:
    static void AddTagHandler(SIP_PYOBJECT);
%MethodCode
    new wxPyHtmlTagsModule(a0);
%End

    wxHtmlWindowInterface *GetWindowInterface();
    wxHtmlContainerCell* GetContainer();


private:
    wxHtmlWinParser();
    wxHtmlWinParser(const wxHtmlWinParser&);
};

class wxHtmlLinkEvent : wxCommandEvent
{

%ConvertToSubClassCode
    wxClassInfo* c = sipCpp->GetClassInfo();

    /* TODO: automate this by grepping for wxXXXEvent and putting
     * entries here before build :( */
    if(0) ;
#define C(clz) else if (c == CLASSINFO(clz)) sipClass = sipClass_ ## clz;
        C(wxHtmlLinkEvent)
    else
        sipClass = NULL;
#undef C
%End

public:
    wxHtmlLinkEvent(int id, const wxHtmlLinkInfo &linkinfo);
    const wxHtmlLinkInfo &GetLinkInfo() const;
};


class wxHtmlWindowInterface
{
private:
    wxHtmlWindowInterface();
    wxHtmlWindowInterface(const wxHtmlWindowInterface&);
    virtual ~wxHtmlWindowInterface();
public:

    virtual void SetHTMLWindowTitle(const wxString& title) = 0;
    //virtual wxPoint HTMLCoordsToWindow(wxHtmlCell *cell, const wxPoint& pos) const = 0;
    virtual wxWindow* GetHTMLWindow() = 0;
    virtual wxColour GetHTMLBackgroundColour() const = 0;
    virtual void SetHTMLBackgroundColour(const wxColour& clr) = 0;
    virtual void SetHTMLBackgroundImage(const wxBitmap& bmpBg) = 0;
    virtual void SetHTMLStatusText(const wxString& text) = 0;

    enum HTMLCursor
    {
        HTMLCursor_Default,
        HTMLCursor_Link,
        HTMLCursor_Text
    };
};
