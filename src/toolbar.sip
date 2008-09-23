enum wxToolBarToolStyle
{
    wxTOOL_STYLE_BUTTON    = 1,
    wxTOOL_STYLE_SEPARATOR = 2,
    wxTOOL_STYLE_CONTROL
};

enum {
    wxTB_HORIZONTAL,
    wxTB_VERTICAL,
    wxTB_TOP,
    wxTB_LEFT,
    wxTB_BOTTOM,
    wxTB_RIGHT,

    wxTB_3DBUTTONS,
    wxTB_FLAT,
    wxTB_DOCKABLE,
    wxTB_NOICONS,
    wxTB_TEXT,
    wxTB_NODIVIDER,
    wxTB_NOALIGN,
    wxTB_HORZ_LAYOUT,
    wxTB_HORZ_TEXT,
    wxTB_NO_TOOLTIPS
};

class wxToolBarToolBase : wxObject
{
private:
    wxToolBarToolBase(const wxToolBarToolBase&);
    wxToolBarToolBase();
    ~wxToolBarToolBase();

public:

    int GetId();
    wxControl *GetControl();
    wxToolBarBase *GetToolBar();
    int IsButton();
    int IsControl();
    int IsSeparator();
    int GetStyle();
    wxItemKind GetKind();
    bool IsEnabled();
    bool IsToggled();
    bool CanBeToggled();
    const wxBitmap& GetNormalBitmap();
    const wxBitmap& GetDisabledBitmap();
    wxBitmap GetBitmap();
    wxString GetLabel();
    wxString GetShortHelp();
    wxString GetLongHelp();
    bool Enable(bool enable);
    void Toggle();
    bool SetToggle(bool toggle);
    bool SetShortHelp(const wxString& help);
    bool SetLongHelp(const wxString& help);
    void SetNormalBitmap(const wxBitmap& bmp);
    void SetDisabledBitmap(const wxBitmap& bmp);
    void SetLabel(const wxString& label);
    void Detach();
    void Attach(wxToolBarBase *tbar);
};

class wxToolBarBase : wxControl
{
private:
    wxToolBarBase();
    virtual ~wxToolBarBase();
    wxToolBarBase(const wxToolBarBase&);
public:


//
//    // This is an Abstract Base Class
//
//    %extend {
//
//        // The full AddTool() function.  Call it DoAddTool in wxPython and
//        // implement the other Add methods by calling it.
//        //
//        // If bmpDisabled is wxNullBitmap, a shadowed version of the normal bitmap
//        // is created and used as the disabled image.
//        wxToolBarToolBase *DoAddTool(int id,
//                                     const wxString& label,
//                                     const wxBitmap& bitmap,
//                                     const wxBitmap& bmpDisabled = wxNullBitmap,
//                                     wxItemKind kind = wxITEM_NORMAL,
//                                     const wxString& shortHelp = wxPyEmptyString,
//                                     const wxString& longHelp = wxPyEmptyString,
//                                     PyObject *clientData = NULL)
//        {
//            wxPyUserData* udata = NULL;
//            if (clientData && clientData != Py_None)
//                udata = new wxPyUserData(clientData);
//            return self->AddTool(id, label, bitmap, bmpDisabled, kind,
//                                 shortHelp, longHelp, udata);
//        }
//
//
//        // Insert the new tool at the given position, if pos == GetToolsCount(), it
//        // is equivalent to DoAddTool()
//        wxToolBarToolBase *DoInsertTool(size_t pos,
//                                      int id,
//                                      const wxString& label,
//                                      const wxBitmap& bitmap,
//                                      const wxBitmap& bmpDisabled = wxNullBitmap,
//                                      wxItemKind kind = wxITEM_NORMAL,
//                                      const wxString& shortHelp = wxPyEmptyString,
//                                      const wxString& longHelp = wxPyEmptyString,
//                                      PyObject *clientData = NULL)
//        {
//            wxPyUserData* udata = NULL;
//            if (clientData && clientData != Py_None)
//                udata = new wxPyUserData(clientData);
//            return self->InsertTool(pos, id, label, bitmap, bmpDisabled, kind,
//                                    shortHelp, longHelp, udata);
//        }
//
//    }

    wxToolBarToolBase* AddTool(int toolId,
                               const wxString& label,
                               const wxBitmap& bitmap1,
                               const wxBitmap& bitmap2 = wxNullBitmap,
                               wxItemKind kind = wxITEM_NORMAL,
                               const wxString& shortHelpString = wxEmptyString,
                               const wxString& longHelpString = wxEmptyString) /Transfer/;
//
//    def AddTool(self, int id, const wxBitmap& bitmap,
//                pushedBitmap = wx.NullBitmap,
//                isToggle = 0,
//                clientData = None,
//                shortHelpString = '',
//                longHelpString = '') :
//        '''Old style method to add a tool to the toolbar.'''
//        kind = wx.ITEM_NORMAL
//        if isToggle: kind = wx.ITEM_CHECK
//        return self.DoAddTool(id, '', bitmap, pushedBitmap, kind,
//                              shortHelpString, longHelpString, clientData)
//
//    def AddSimpleTool(self, id, bitmap,
//                      shortHelpString = '',
//                      longHelpString = '',
//                      isToggle = 0):
//        '''Old style method to add a tool to the toolbar.'''
//        kind = wx.ITEM_NORMAL
//        if isToggle: kind = wx.ITEM_CHECK
//        return self.DoAddTool(id, '', bitmap, wx.NullBitmap, kind,
//                              shortHelpString, longHelpString, None)
//
//    def InsertTool(self, pos, id, bitmap,
//                   pushedBitmap = wx.NullBitmap,
//                   isToggle = 0,
//                   clientData = None,
//                   shortHelpString = '',
//                   longHelpString = ''):
//        '''Old style method to insert a tool in the toolbar.'''
//        kind = wx.ITEM_NORMAL
//        if isToggle: kind = wx.ITEM_CHECK
//        return self.DoInsertTool(pos, id, '', bitmap, pushedBitmap, kind,
//                                 shortHelpString, longHelpString, clientData)
//
//    def InsertSimpleTool(self, pos, id, bitmap,
//                         shortHelpString = '',
//                         longHelpString = '',
//                         isToggle = 0):
//        '''Old style method to insert a tool in the toolbar.'''
//        kind = wx.ITEM_NORMAL
//        if isToggle: kind = wx.ITEM_CHECK
//        return self.DoInsertTool(pos, id, '', bitmap, wx.NullBitmap, kind,
//                                 shortHelpString, longHelpString, None)


//    %# The following are the new toolbar Add methods starting with
//    %# 2.3.3.  They are renamed to have 'Label' in the name so as to be
//    %# able to keep backwards compatibility with using the above
//    %# methods.  Eventually these should migrate to be the methods used
//    %# primarily and lose the 'Label' in the name...
//
//    def AddLabelTool(self, id, label, bitmap,
//                     bmpDisabled = wx.NullBitmap,
//                     kind = wx.ITEM_NORMAL,
//                     shortHelp = '', longHelp = '',
//                     clientData = None):
//        '''
//        The full AddTool() function.
//
//        If bmpDisabled is wx.NullBitmap, a shadowed version of the normal bitmap
//        is created and used as the disabled image.
//        '''
//        return self.DoAddTool(id, label, bitmap, bmpDisabled, kind,
//                              shortHelp, longHelp, clientData)
//
//
//    def InsertLabelTool(self, pos, id, label, bitmap,
//                        bmpDisabled = wx.NullBitmap,
//                        kind = wx.ITEM_NORMAL,
//                        shortHelp = '', longHelp = '',
//                        clientData = None):
//        '''
//        Insert the new tool at the given position, if pos == GetToolsCount(), it
//        is equivalent to AddTool()
//        '''
//        return self.DoInsertTool(pos, id, label, bitmap, bmpDisabled, kind,
//                                 shortHelp, longHelp, clientData)
//
//    def AddCheckLabelTool(self, id, label, bitmap,
//                        bmpDisabled = wx.NullBitmap,
//                        shortHelp = '', longHelp = '',
//                        clientData = None):
//        '''Add a check tool, i.e. a tool which can be toggled'''
//        return self.DoAddTool(id, label, bitmap, bmpDisabled, wx.ITEM_CHECK,
//                              shortHelp, longHelp, clientData)
//
//    def AddRadioLabelTool(self, id, label, bitmap,
//                          bmpDisabled = wx.NullBitmap,
//                          shortHelp = '', longHelp = '',
//                          clientData = None):
//        '''
//        Add a radio tool, i.e. a tool which can be toggled and releases any
//        other toggled radio tools in the same group when it happens
//        '''
//        return self.DoAddTool(id, label, bitmap, bmpDisabled, wx.ITEM_RADIO,
//                              shortHelp, longHelp, clientData)
//
//
//    %# For consistency with the backwards compatible methods above, here are
//    %# some non-'Label' versions of the Check and Radio methods
//
//    def AddCheckTool(self, id, bitmap,
//                     bmpDisabled = wx.NullBitmap,
//                     shortHelp = '', longHelp = '',
//                     clientData = None):
//        '''Add a check tool, i.e. a tool which can be toggled'''
//        return self.DoAddTool(id, '', bitmap, bmpDisabled, wx.ITEM_CHECK,
//                              shortHelp, longHelp, clientData)
//
//    def AddRadioTool(self, id, bitmap,
//                     bmpDisabled = wx.NullBitmap,
//                     shortHelp = '', longHelp = '',
//                     clientData = None):
//        '''
//        Add a radio tool, i.e. a tool which can be toggled and releases any
//        other toggled radio tools in the same group when it happens
//        '''
//        return self.DoAddTool(id, '', bitmap, bmpDisabled, wx.ITEM_RADIO,
//                              shortHelp, longHelp, clientData)
//    }

    wxToolBarToolBase* AddTool(wxToolBarToolBase *tool) /PyName=AddToolItem, Transfer/;
    wxToolBarToolBase* InsertTool(size_t pos, wxToolBarToolBase *tool /Transfer/) /PyName=InsertToolItem, Transfer/;

    wxToolBarToolBase *AddControl(wxControl *control) /Transfer/;
    wxToolBarToolBase *InsertControl(size_t pos, wxControl *control) /Transfer/;
    wxControl* FindControl(int id);

    wxToolBarToolBase *AddSeparator() /Transfer/;
    wxToolBarToolBase *InsertSeparator(size_t pos) /Transfer/;
    wxToolBarToolBase *RemoveTool(int id) /Factory/;

    bool DeleteToolByPos(size_t pos);
    bool DeleteTool(int id);
    void ClearTools();
    bool Realize();

    void EnableTool(int id, bool enable);
    void ToggleTool(int id, bool toggle);
    void SetToggle(int id, bool toggle);

    int GetToolPos(int id) const;

    bool GetToolState(int id);
    bool GetToolEnabled(int id);
    void SetToolShortHelp(int id, const wxString& helpString);
    wxString GetToolShortHelp(int id);
    void SetToolLongHelp(int id, const wxString& helpString);
    wxString GetToolLongHelp(int id);

    void SetMargins(const wxSize& size);
    void SetMargins(int x, int y) /PyName=SetMarginsXY/;
    void SetToolPacking(int packing);
    void SetToolSeparation(int separation);
    wxSize GetToolMargins();
    wxSize GetMargins();
    int GetToolPacking();
    int GetToolSeparation();

    void SetRows(int nRows);
    void SetMaxRowsCols(int rows, int cols);
    int GetMaxRows();
    int GetMaxCols();

    void SetToolBitmapSize(const wxSize& size);
    wxSize GetToolBitmapSize();
    wxSize GetToolSize();

    wxToolBarToolBase *FindToolForPosition(wxCoord x, wxCoord y) /Transfer/;
    wxToolBarToolBase *FindById(int toolid) const /Transfer/;
    bool IsVertical();
    size_t GetToolsCount() const;
};



class wxToolBar : wxToolBarBase
{
public:
    wxToolBar(wxWindow *parent,
              wxWindowID id=-1,
              const wxPoint& pos = wxDefaultPosition,
              const wxSize& size = wxDefaultSize,
              long style = wxNO_BORDER | wxTB_HORIZONTAL,
              const wxString& name = wxToolBarNameStr);

    void SetToolNormalBitmap(int id, const wxBitmap& bitmap);
    void SetToolDisabledBitmap(int id, const wxBitmap& bitmap);
};

