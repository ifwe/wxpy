//
// maps wxList<T> to python list objects
//

%MappedType wxMenuItemList
{
%TypeHeaderCode
#include <wx/list.h>
#include <wx/window.h>
%End

%ConvertToTypeCode
    // See if we are just being asked to check the type of the Python object.
    if (sipIsErr == NULL) {
        if (!PyList_Check(sipPy)) // Check it is a list.
            return 0;

        // Now check each element of the list is of the type we expect.
        // The template is for a pointer type so we don't disallow None.
        for (int i = 0; i < PyList_GET_SIZE(sipPy); ++i)
            if (!sipCanConvertToInstance(PyList_GET_ITEM(sipPy, i),
                                         sipClass_wxMenuItem, 0))
                return 0;

        return 1;
    }

    // Create the instance on the heap.
    wxMenuItemList *ql = new wxMenuItemList;

    for (int i = 0; i < PyList_GET_SIZE(sipPy); ++i) {
        // Use the SIP API to convert the Python object to the
        // corresponding C++ instance.  Note that we apply any ownership
        // transfer to the list itself, not the individual elements.
        wxMenuItem *t = reinterpret_cast<wxMenuItem *>(sipConvertToInstance(
                                            PyList_GET_ITEM(sipPy, i),
                                            sipClass_wxMenuItem, 0, 0, 0,
                                            sipIsErr));

        if (*sipIsErr) {
            delete ql;
            return 0; // There is nothing on the heap.
        }

        ql->push_back(t); // Add the pointer to the C++ instance.
    }

    *sipCppPtr = ql; // Return the instance on the heap.
    return sipGetState(sipTransferObj); // Apply the normal transfer.
%End

%ConvertFromTypeCode
    PyObject *l;

    // Create the Python list of the correct length.
    if ((l = PyList_New(sipCpp -> size())) == NULL)
        return NULL;

    // Go through each element in the C++ instance and convert it to the
    // corresponding Python object.
    wxMenuItemList::iterator iter;
    size_t i = 0;
    for (iter = sipCpp->begin(); iter != sipCpp->end(); ++iter, ++i) {
        wxMenuItem *t = *iter;
        PyObject *tobj;

        if ((tobj = sipConvertFromInstance(t, sipClass_wxMenuItem, sipTransferObj)) == NULL)
        {
            // There was an error so garbage collect the Python list.
            Py_DECREF(l);
            return NULL;
        }

        PyList_SET_ITEM(l, i, tobj);
    }

    // Return the Python list.
    return l;
%End

};