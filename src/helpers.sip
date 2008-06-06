
%ModuleHeaderCode
//inline bool sequence_2_ints_check(PyObject* obj);
//inline bool sequence_2_ints(PyObject* source, int* i1, int* i2);
//
//inline bool sequence_4_ints_check(PyObject* obj);
//inline bool sequence_4_ints(PyObject* source, int* i1, int* i2, int* i3, int* i4);

inline bool sequence_2_ints_check(PyObject* obj)
{
    bool is_ints = false;

    if (!PySequence_Check(obj) || PySequence_Length(obj) != 2)
        return false;

    PyObject* o1 = PySequence_GetItem(obj, 0);
    PyObject* o2 = PySequence_GetItem(obj, 1);

    is_ints = PyNumber_Check(o1) && PyNumber_Check(o2);

    Py_DECREF(o1);
    Py_DECREF(o2);

    if (PyErr_Occurred())
        PyErr_Print();

    return is_ints;
}

inline bool sequence_2_ints(PyObject* source, int* i1, int* i2) {
    PyObject *o1, *o2;

    if (!(PySequence_Check(source) && PySequence_Length(source) == 2))
        return false;

    if (PyList_Check(source) || PyTuple_Check(source)) {
        o1 = PySequence_Fast_GET_ITEM(source, 0);
        o2 = PySequence_Fast_GET_ITEM(source, 1);
        *i1 = PyInt_AsLong(o1);
        *i2 = PyInt_AsLong(o2);
    } else {
        o1 = PySequence_GetItem(source, 0);
        o2 = PySequence_GetItem(source, 1);
        *i1 = PyInt_AsLong(o1);
        *i2 = PyInt_AsLong(o2);
        Py_DECREF(o1);
        Py_DECREF(o2);
    }

    if (PyErr_Occurred()) {
        PyErr_Print();
        return false;
    }

    return true;
}


inline bool sequence_4_ints_check(PyObject* obj)
{
    bool is_ints = false;

    if (!PySequence_Check(obj))
        return false;
    else if (PySequence_Length(obj) != 4)
        return false;

    PyObject* o1 = PySequence_GetItem(obj, 0);
    PyObject* o2 = PySequence_GetItem(obj, 1);
    PyObject* o3 = PySequence_GetItem(obj, 2);
    PyObject* o4 = PySequence_GetItem(obj, 3);

    is_ints = PyNumber_Check(o1) && PyNumber_Check(o2)
                && PyNumber_Check(o3) && PyNumber_Check(o4);

    Py_DECREF(o1);
    Py_DECREF(o2);
    Py_DECREF(o3);
    Py_DECREF(o4);

    if (PyErr_Occurred())
        PyErr_Print();

    return is_ints;
}

inline bool sequence_4_ints(PyObject* source, int* i1, int* i2, int* i3, int* i4) {
    PyObject *o1, *o2, *o3, *o4;

    if (!(PySequence_Check(source) && PySequence_Length(source) == 4))
        return false;

    if (PyList_Check(source) || PyTuple_Check(source)) {
        o1 = PySequence_Fast_GET_ITEM(source, 0);
        o2 = PySequence_Fast_GET_ITEM(source, 1);
        o3 = PySequence_Fast_GET_ITEM(source, 2);
        o4 = PySequence_Fast_GET_ITEM(source, 3);
        *i1 = PyInt_AsLong(o1);
        *i2 = PyInt_AsLong(o2);
        *i3 = PyInt_AsLong(o3);
        *i4 = PyInt_AsLong(o4);
    } else {
        o1 = PySequence_GetItem(source, 0);
        o2 = PySequence_GetItem(source, 1);
        o3 = PySequence_GetItem(source, 2);
        o4 = PySequence_GetItem(source, 3);
        *i1 = PyInt_AsLong(o1);
        *i2 = PyInt_AsLong(o2);
        *i3 = PyInt_AsLong(o3);
        *i4 = PyInt_AsLong(o4);
        Py_DECREF(o1);
        Py_DECREF(o2);
        Py_DECREF(o3);
        Py_DECREF(o4);
    }

    if (PyErr_Occurred()) {
        fprintf(stderr, "Exception in sequence_4_ints:\n");
        PyErr_Print();
        return false;
    }

    return true;
}





%End

