#include "stdwxpy.h"
#include <Python.h>
#include <frameobject.h>
#include <wx/log.h>

#define GET_PYSTRING(s) ((char*)((PyStringObject *)s)->ob_sval)
#define TO_WXSTRING(c) (wxString(c, wxConvUTF8, strlen(c)))

/* walk Python frames starting from the current thread state,
 * printing function names, filenames, and line numbers */
void print_python_stack()
{
    PyFrameObject* f = PyThreadState_GET()->frame;

    while (f) {
        const char* c_filename = GET_PYSTRING(f->f_code->co_filename);
        const char* c_name     = GET_PYSTRING(f->f_code->co_name);

        wxLogError(wxT("%s:%s(%d)"),
            TO_WXSTRING(c_filename),
            TO_WXSTRING(c_name),
            PyCode_Addr2Line(f->f_code, f->f_lasti));

        f = f->f_back;
    }
}

