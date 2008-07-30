enum
{
    wxACCEL_ALT,
    wxACCEL_CTRL,
    wxACCEL_SHIFT,
    wxACCEL_NORMAL,
    wxACCEL_CMD,
};

class wxAcceleratorEntry
{
public:
    wxAcceleratorEntry(int flags = 0, int keyCode = 0, int cmdID = 0/*, wxMenuItem *menuitem = NULL*/);

    int GetFlags();
    int GetKeyCode();
    int GetCommand();
    bool IsOk() const;
    wxString ToString() const;
    bool FromString(const wxString &str);
};

class wxAcceleratorTable : wxObject
{
%TypeHeaderCode
#ifndef WXPY_PREC
#include <wx/accel.h>
#endif
    PyObject* accel_check(PyObject* item);
    void accel_from_tuple(PyObject* item, wxAcceleratorEntry* accel);

#define ACCEL_TYPE_ERROR "wxAcceleratorTable takes a sequence of 3 element tuples (flags, keyCode, cmd)"
%End

%TypeCode

PyObject* accel_check(PyObject* item)
{
    PyObject* fast = PySequence_Fast(item, ACCEL_TYPE_ERROR);

    if (PySequence_Fast_GET_SIZE(fast) == 3 &&
            PyNumber_Check(PySequence_Fast_GET_ITEM(fast, 0)) &&
            PyNumber_Check(PySequence_Fast_GET_ITEM(fast, 1)) &&
            PyNumber_Check(PySequence_Fast_GET_ITEM(fast, 2)))
        return fast;

    // otherwise, throw a type error
    Py_DECREF(fast);
    PyObject_Print(fast, stderr, 0);
    PyErr_SetString(PyExc_TypeError, ACCEL_TYPE_ERROR);
    return NULL;
}

void accel_from_tuple(PyObject* fast, wxAcceleratorEntry* entry)
{
    long flags   = PyInt_AS_LONG(PySequence_Fast_GET_ITEM(fast, 0));
    long keycode = PyInt_AS_LONG(PySequence_Fast_GET_ITEM(fast, 1));

    PyObject* pyid = PySequence_Fast_GET_ITEM(fast, 2);
    long command = PyLong_Check(pyid) ? PyLong_AsLong(pyid) : PyInt_AS_LONG(pyid);

    entry->Set(flags, keycode, command);
}
%End // TypeCode

private:
    wxAcceleratorTable();
    // TODO: why does this break?
public:
    virtual ~wxAcceleratorTable();

    bool IsOk() const;

};

wxAcceleratorTable wxAcceleratorTableFromSequence (SIP_PYOBJECT);
%MethodCode
PyObject* seq;
PyObject* fastitem;

if (!(seq = PySequence_Fast(a0, ACCEL_TYPE_ERROR)))
    sipIsErr = 1;
else
{
    size_t length = PySequence_Fast_GET_SIZE(seq);

    wxAcceleratorEntry* entries = new wxAcceleratorEntry[length];
    for (size_t i = 0; i < length; ++i)
    {
        fastitem = accel_check(PySequence_Fast_GET_ITEM(seq, i));
        if (!fastitem)
        {
            sipIsErr = 1;
            break;
        }
        accel_from_tuple(fastitem, &entries[i]);
        Py_DECREF(fastitem);
    }
    Py_DECREF(seq);
    if (!sipIsErr)
        sipRes = new wxAcceleratorTable(length, entries);

    delete [] entries;
}
%End

