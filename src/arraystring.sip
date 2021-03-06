%MappedType wxArrayString
{
%TypeHeaderCode
#ifndef WXPY_PREC
#include <wx/arrstr.h>
#endif
%End

%ConvertToTypeCode
    // See if we are just being asked to check the type of the Python object.
    const sipMappedType* wxStringMappedType = sipFindMappedType("wxString");
    if (!sipIsErr) {
        if (!PyList_Check(sipPy)) // Check it is a list.
            return 0;

        // Now check each element of the list is of the type we expect.
        // The template is for a pointer type so we don't disallow None.
        for (int i = 0; i < PyList_GET_SIZE(sipPy); ++i)
            if (!sipCanConvertToMappedType(PyList_GET_ITEM(sipPy, i), wxStringMappedType, 0))
                return 0;

        return 1;
    }

    // Create the instance on the heap.
    wxArrayString *ql = new wxArrayString;

    for (int i = 0; i < PyList_GET_SIZE(sipPy); ++i) {
        // Use the SIP API to convert the Python object to the
        // corresponding C++ instance.  Note that we apply any ownership
        // transfer to the list itself, not the individual elements.
        wxString *t = reinterpret_cast<wxString *>(sipConvertToMappedType(
                                            PyList_GET_ITEM(sipPy, i),
                                            wxStringMappedType, 0, 0, 0,
                                            sipIsErr));

        if (*sipIsErr) {
            delete ql;
            return 0; // There is nothing on the heap.
        }

        ql->Add(*t); // Add the pointer to the C++ instance.
        delete t;
    }

    *sipCppPtr = ql; // Return the instance on the heap.
    return sipGetState(sipTransferObj); // Apply the normal transfer.
%End

%ConvertFromTypeCode
    PyObject *l = PyList_New(sipCpp->Count());
    if (!l)
        return NULL;

    const sipMappedType* wxStringMappedType = sipFindMappedType("wxString");

    // Go through each element in the C++ instance and convert it to the
    // corresponding Python object.
    for (size_t i = 0; i < sipCpp->Count(); ++i) {
        wxString s = sipCpp->Item(i);

        PyObject* tobj = sipConvertFromMappedType(&s, wxStringMappedType, sipTransferObj);
        if (!tobj) {
            Py_DECREF(l);
            return NULL;
        }

        PyList_SET_ITEM(l, i, tobj); // steals
    }

    return l;
%End

};