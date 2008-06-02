//
// wxString is not visible from Python, but we use %MappedType to allow
// them to become interoperable with Python unicode and str objects.
//

%MappedType wxString
{

%TypeHeaderCode
#ifndef WXPY_PREC
#include <wx/string.h>
#endif

#if !wxUSE_UNICODE
#error "wxpy currently requires that wxWidgets is built with Unicode support (--enable-unicode or wxUSE_UNICODE=1)"
#endif

%End

// wxString -> python unicode object
%ConvertFromTypeCode
    return PyUnicode_FromWideChar((wchar_t*)sipCpp->c_str(), sipCpp->Len());
%End

// python unicode/str objects -> wxString
%ConvertToTypeCode
    // just a type check
    if (!sipIsErr)
        return PyUnicode_Check(sipPy) || PyString_Check(sipPy);

    PyObject* unicode = sipPy;
    bool needsDeref = false;

    // str -> unicode via utf-8
    if (PyString_Check(sipPy))
    {
        unicode = PyUnicode_FromEncodedObject(sipPy, "utf-8", "strict");
        if (PyErr_Occurred())
            return 0;

        needsDeref = true;
    }

    wxString* target = new wxString;

    // Move Unicode wchar_t bytes into wxString
    size_t len = PyUnicode_GET_SIZE(unicode);
    if (len)
    {
        PyUnicode_AsWideChar((PyUnicodeObject*)unicode, target->GetWriteBuf(len), len);
        target->UngetWriteBuf();
    }

    *sipCppPtr = target;

    if (needsDeref)
        Py_DECREF(unicode);

    return sipGetState(sipTransferObj);
%End

};