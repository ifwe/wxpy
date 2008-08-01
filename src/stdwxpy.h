#ifdef WXPY_PREC
#include <wx/wxprec.h>
#include <wx/app.h>
#include <wx/list.h>
#include <wx/sizer.h>
#include <wx/accel.h>
#include <wx/arrstr.h>
#include <wx/button.h>
#include <wx/clipbrd.h>
#include <wx/control.h>
#include <wx/dataobj.h>
#include <wx/dcbuffer.h>
#include <wx/tooltip.h>
#include <wx/fontdlg.h>
#include <wx/colordlg.h>
#include <wx/fdrepdlg.h>
#include <wx/progdlg.h>
#include <wx/numdlg.h>
#include <wx/display.h>
#include <wx/vidmode.h>
#include <wx/dnd.h>
#include <wx/event.h>
#include <wx/fontenum.h>
#include <wx/stockitem.h>
#include <wx/gauge.h>
#include <wx/gbsizer.h>
#include <wx/gdicmn.h>
#include <wx/graphics.h>
#include <wx/geometry.h>
#include <wx/hyperlink.h>
#include <wx/confbase.h>
#include <wx/fileconf.h>
#include <wx/html/htmlwin.h>
#include <wx/mstream.h>
#include <wx/listctrl.h>
#include <wx/notebook.h>
#include <wx/caret.h>
#include <wx/object.h>
#include <wx/popupwin.h>
#include <wx/power.h>
#include <wx/dynlib.h>
#include <wx/vlbox.h>
#include <wx/vscroll.h>
#include <wx/validate.h>
#include <wx/tglbtn.h>
#include <wx/toplevel.h>
#include <wx/frame.h>
#include <wx/treectrl.h>
#include <wx/srchctrl.h>
#include <wx/sysopt.h>
#include <wx/slider.h>
#include <wx/sound.h>
#include <wx/splitter.h>
#include <wx/stattext.h>
#include <wx/statbox.h>
#include <wx/statline.h>
#include <wx/statbmp.h>
#include <wx/stdpaths.h>
#include <wx/string.h>
#include <wx/taskbar.h>
#include <wx/renderer.h>
#include <wx/dcgraph.h>
#include <wx/intl.h>
#include <wx/artprov.h>
#include <wx/utils.h>

#include <wx/pickerbase.h>
#if wxUSE_FONTPICKERCTRL
#include <wx/fontpicker.h>
#endif
#if wxUSE_DIRPICKERCTRL
#include <wx/filepicker.h>
#endif
#if wxUSE_COLOURPICKERCTRL
#include <wx/clrpicker.h>
#endif
#if wxUSE_CALENDARCTRL
#include <wx/calctrl.h>
#endif
#if wxUSE_IMAGLIST
#include <wx/imaglist.h>
#endif

#if wxUSE_SNGLINST_CHECKER
#include <wx/snglinst.h>
#endif

#if wxUSE_MINIFRAME
#include <wx/minifram.h>
#endif

#if wxUSE_STATUSBAR
#include <wx/statusbr.h>
#endif

#ifdef __WXMSW__
#include <wx/msw/regconf.h>
#include <wx/msw/crashrpt.h>
#include <wx/msw/seh.h>
#endif

#include <vector>
#include <list>
#include <Python.h>
#include <sip.h>

#endif // WXPY_PREC