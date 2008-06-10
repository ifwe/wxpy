%ModuleHeaderCode
#ifndef WXPY_PREC
#include <wx/pickerbase.h>
#if wxUSE_DIRPICKERCTRL
#include <wx/fontpicker.h>
#endif
#if wxUSE_DIRPICKERCTRL
#include <wx/filepicker.h>
#endif
#if wxUSE_COLOURPICKERCTRL
#include <wx/clrpicker.h>
#endif
#endif
%End



enum
{
     wxPB_USE_TEXTCTRL,
};


class wxPickerBase : wxControl
{
private:
    wxPickerBase();
    wxPickerBase(const wxPickerBase&);

public:
    void SetInternalMargin(int newmargin);
    int GetInternalMargin() const;
    void SetTextCtrlProportion(int prop);
    int GetTextCtrlProportion() const;
    void SetPickerCtrlProportion(int prop);
    int GetPickerCtrlProportion() const;
    bool IsTextCtrlGrowable() const;
    void SetTextCtrlGrowable(bool grow = true);
    bool IsPickerCtrlGrowable() const;
    void SetPickerCtrlGrowable(bool grow = true);
    bool HasTextCtrl() const;
    wxTextCtrl* GetTextCtrl();
    wxControl* GetPickerCtrl();
};


enum {
    wxCLRP_SHOW_LABEL,
    wxCLRP_USE_TEXTCTRL,
    wxCLRP_DEFAULT_STYLE,
};


%If (wxUSE_COLOURPICKERCTRL)

%PostInitialisationCode
add_event(sipModuleDict, "EVT_COLOURPICKER_CHANGED", wxEVT_COMMAND_COLOURPICKER_CHANGED, 0);
%End

/*
class wxColourPickerCtrl : wxPickerBase
{
public:
    wxColourPickerCtrl(wxWindow *parent, wxWindowID id=-1,
                       const wxColour& col = wxBLACK,
                       const wxPoint& pos = wxDefaultPosition,
                       const wxSize& size = wxDefaultSize,
                       long style = wxCLRP_DEFAULT_STYLE,
                       const wxValidator& validator = wxDefaultValidator,
                       const wxString& name = wxColourPickerCtrlNameStr);

    wxColour GetColour() const;
    void SetColour(const wxColour& col);
};
*/

enum { wxEVT_COMMAND_COLOURPICKER_CHANGED };


class wxColourPickerEvent : wxCommandEvent
{
public:
    wxColourPickerEvent(wxObject *generator, int id, const wxColour &col);

    wxColour GetColour() const;
    void SetColour(const wxColour &c);
};

%End


%If (wxUSE_FILEPICKERCTRL)

%PostInitialisationCode
add_event(sipModuleDict, "EVT_FILEPICKER_CHANGED",   wxEVT_COMMAND_FILEPICKER_CHANGED, 0);
%End

class wxFilePickerCtrl : wxPickerBase
{
public:
    wxFilePickerCtrl(wxWindow *parent,
                     wxWindowID id=-1,
                     const wxString& path = wxEmptyString,
                     const wxString& message = wxFileSelectorPromptStr,
                     const wxString& wildcard = wxFileSelectorDefaultWildcardStr,
                     const wxPoint& pos = wxDefaultPosition,
                     const wxSize& size = wxDefaultSize,
                     long style = wxFLP_DEFAULT_STYLE,
                     const wxValidator& validator = wxDefaultValidator,
                     const wxString& name = wxFilePickerCtrlNameStr);

    wxString GetPath() const;
    void SetPath(const wxString &str);

    bool CheckPath(const wxString& path) const;

    wxString GetTextCtrlValue() const;
};
enum { wxEVT_COMMAND_FILEPICKER_CHANGED };

enum
{
    wxFLP_OPEN,
    wxFLP_SAVE,
    wxFLP_OVERWRITE_PROMPT,
    wxFLP_FILE_MUST_EXIST,
    wxFLP_CHANGE_DIR,

    wxFLP_USE_TEXTCTRL,
    wxFLP_DEFAULT_STYLE,
};

%End // wxUSE_FILEPICKERCTRL

%If (wxUSE_DIRPICKERCTRL)

%PostInitialisationCode
add_event(sipModuleDict, "EVT_DIRPICKER_CHANGED",    wxEVT_COMMAND_DIRPICKER_CHANGED, 0);
%End


class wxDirPickerCtrl : wxPickerBase
{

public:
    wxDirPickerCtrl(wxWindow *parent, wxWindowID id=-1,
                    const wxString& path = wxEmptyString,
                    const wxString& message = wxDirSelectorPromptStr,
                    const wxPoint& pos = wxDefaultPosition,
                    const wxSize& size = wxDefaultSize,
                    long style = wxDIRP_DEFAULT_STYLE,
                    const wxValidator& validator = wxDefaultValidator,
                    const wxString& name = wxDirPickerCtrlNameStr);

    wxString GetPath() const;
    void SetPath(const wxString &str);

    bool CheckPath(const wxString& path) const;

    wxString GetTextCtrlValue() const;
};

enum
{
    wxDIRP_DIR_MUST_EXIST,
    wxDIRP_CHANGE_DIR,
    wxDIRP_USE_TEXTCTRL,
    wxDIRP_DEFAULT_STYLE,

};



enum { wxEVT_COMMAND_DIRPICKER_CHANGED };


%End

class wxFileDirPickerEvent : wxCommandEvent
{
public:
    wxFileDirPickerEvent(wxEventType type, wxObject *generator, int id, const wxString &path);

    wxString GetPath() const;
    void SetPath(const wxString &p);
};


enum {
    wxFNTP_FONTDESC_AS_LABEL,
    wxFNTP_USEFONT_FOR_LABEL,
    wxFNTP_USE_TEXTCTRL,
    wxFNTP_DEFAULT_STYLE,
};

%If (wxUSE_FONTPICKERCTRL)

%PostInitialisationCode
add_event(sipModuleDict, "EVT_FONTPICKER_CHANGED", wxEVT_COMMAND_FONTPICKER_CHANGED, 0);
%End

class wxFontPickerCtrl : wxPickerBase
{
public:
    wxFontPickerCtrl(wxWindow *parent,
                     wxWindowID id=-1,
                     const wxFont& initial = wxNullFont,
                     const wxPoint& pos = wxDefaultPosition,
                     const wxSize& size = wxDefaultSize,
                     long style = wxFNTP_DEFAULT_STYLE,
                     const wxValidator& validator = wxDefaultValidator,
                     const wxString& name = wxFontPickerCtrlNameStr);

    wxFont GetSelectedFont() const;
    void SetSelectedFont(const wxFont& f);

    void SetMaxPointSize(unsigned int max);
    unsigned int GetMaxPointSize() const;
};


enum { wxEVT_COMMAND_FONTPICKER_CHANGED };


class wxFontPickerEvent : wxCommandEvent
{
public:
    wxFontPickerEvent(wxObject *generator, int id, const wxFont &f);

    wxFont GetFont() const;
    void SetFont(const wxFont &c);
};

%End // wxUSE_FONTPICKERCTRL
