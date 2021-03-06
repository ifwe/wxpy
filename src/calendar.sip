%Module wx._wxcalendar

%DefaultSupertype sip.simplewrapper

%Import wx.sip
%UnitCode
#include "stdwxpy.h"
#include <windows.h>
%End

%ModuleHeaderCode
#include <wx/calctrl.h>
%End

enum
{
    wxCAL_SUNDAY_FIRST,
    wxCAL_MONDAY_FIRST,
    wxCAL_SHOW_HOLIDAYS,
    wxCAL_NO_YEAR_CHANGE,
    wxCAL_NO_MONTH_CHANGE,
    wxCAL_SEQUENTIAL_MONTH_SELECTION,
    wxCAL_SHOW_SURROUNDING_WEEKS,
};

enum wxCalendarHitTestResult
{
    wxCAL_HITTEST_NOWHERE,      // outside of anything
    wxCAL_HITTEST_HEADER,       // on the header (weekdays)
    wxCAL_HITTEST_DAY,          // on a day in the calendar
    wxCAL_HITTEST_INCMONTH,
    wxCAL_HITTEST_DECMONTH,
    wxCAL_HITTEST_SURROUNDING_WEEK
};

enum wxCalendarDateBorder
{
    wxCAL_BORDER_NONE,          // no border (default)
    wxCAL_BORDER_SQUARE,        // a rectangular border
    wxCAL_BORDER_ROUND          // a round border
};

class wxCalendarDateAttr /Supertype=sip.wrapper/
{
public:
    wxCalendarDateAttr(const wxColour& colText = wxNullColour,
                       const wxColour& colBack = wxNullColour,
                       const wxColour& colBorder = wxNullColour,
                       const wxFont& font = wxNullFont,
                       wxCalendarDateBorder border = wxCAL_BORDER_NONE);

    ~wxCalendarDateAttr();

    void SetTextColour(const wxColour& colText);
    void SetBackgroundColour(const wxColour& colBack);
    void SetBorderColour(const wxColour& col);
    void SetFont(const wxFont& font);
    void SetBorder(wxCalendarDateBorder border);
    void SetHoliday(bool holiday);

    bool HasTextColour() const;
    bool HasBackgroundColour() const;
    bool HasBorderColour() const;
    bool HasFont() const;
    bool HasBorder() const;

    bool IsHoliday() const;

    wxColour GetTextColour() const;
    wxColour GetBackgroundColour() const;
    wxColour GetBorderColour() const;
    wxFont GetFont() const;
    wxCalendarDateBorder GetBorder() const;
};

enum
{
    wxEVT_CALENDAR_DOUBLECLICKED,
    wxEVT_CALENDAR_SEL_CHANGED,
    wxEVT_CALENDAR_DAY_CHANGED,
    wxEVT_CALENDAR_MONTH_CHANGED,
    wxEVT_CALENDAR_YEAR_CHANGED,
    wxEVT_CALENDAR_WEEKDAY_CLICKED,
};

%PostInitialisationCode
typedef void (*add_event_type)(PyObject* moduple_dict, const char* name, ...);
add_event_type add_event = (add_event_type)sipImportSymbol("wxpy_add_event");

add_event(sipModuleDict, "EVT_CALENDAR", wxEVT_CALENDAR_DOUBLECLICKED, 0);
add_event(sipModuleDict, "EVT_CALENDAR_SEL_CHANGED", wxEVT_CALENDAR_SEL_CHANGED, 0);
add_event(sipModuleDict, "EVT_CALENDAR_DAY", wxEVT_CALENDAR_DAY_CHANGED, 0);
add_event(sipModuleDict, "EVT_CALENDAR_MONTH", wxEVT_CALENDAR_MONTH_CHANGED, 0);
add_event(sipModuleDict, "EVT_CALENDAR_YEAR", wxEVT_CALENDAR_YEAR_CHANGED, 0);
add_event(sipModuleDict, "EVT_CALENDAR_WEEKDAY_CLICKED", wxEVT_CALENDAR_WEEKDAY_CLICKED, 0);
%End

class wxCalendarEvent : wxDateEvent
{
private:
    wxCalendarEvent();
    wxCalendarEvent(const wxCalendarEvent&);

public:
    wxCalendarEvent(wxCalendarCtrl *cal, wxEventType type);
    virtual ~wxCalendarEvent();

    void SetWeekDay(const wxDateTime::WeekDay wd);
    wxDateTime::WeekDay GetWeekDay() const;
};

class wxCalendarCtrl : wxControl
{
public:
    wxCalendarCtrl(wxWindow *parent /TransferThis/,
                   wxWindowID id=-1,
                   const wxDateTime& date = wxDefaultDateTime,
                   const wxPoint& pos = wxDefaultPosition,
                   const wxSize& size = wxDefaultSize,
                   long style = wxCAL_SHOW_HOLIDAYS | wxWANTS_CHARS,
                   const wxString& name = wxCalendarNameStr);
    virtual ~wxCalendarCtrl();

    void SetDate(const wxDateTime& date);
    const wxDateTime GetDate() const;
    bool SetLowerDateLimit(const wxDateTime& date = wxDefaultDateTime);
    bool SetUpperDateLimit(const wxDateTime& date = wxDefaultDateTime);
    const wxDateTime GetLowerDateLimit() const;
    const wxDateTime GetUpperDateLimit() const;
    bool SetDateRange(const wxDateTime& lowerdate = wxDefaultDateTime,
                      const wxDateTime& upperdate = wxDefaultDateTime);
    void EnableYearChange(bool enable = true);
    void EnableMonthChange(bool enable = true);
    void EnableHolidayDisplay(bool display = true);
    void SetHeaderColours(const wxColour& colFg, const wxColour& colBg);
    wxColour GetHeaderColourFg() const;
    wxColour GetHeaderColourBg() const;
    void SetHighlightColours(const wxColour& colFg, const wxColour& colBg);
    wxColour GetHighlightColourFg() const;
    wxColour GetHighlightColourBg() const;
    void SetHolidayColours(const wxColour& colFg, const wxColour& colBg);
    wxColour GetHolidayColourFg() const;
    wxColour GetHolidayColourBg() const;
    wxCalendarDateAttr* GetAttr(size_t day) const /Transfer/;

    void SetAttr(size_t day, wxCalendarDateAttr* attr /Transfer/);
    void SetHoliday(size_t day);
    void ResetAttr(size_t day);

    wxControl* GetMonthControl() const;
    wxControl* GetYearControl() const;
};
