
%ModuleHeaderCode
bool sequence_2_ints_check(PyObject* obj);
bool sequence_2_ints(PyObject* source, int* i1, int* i2);
%End

%ModuleCode
bool sequence_2_ints_check(PyObject* obj)
{
    bool is_ints = false;
    
    if (!PySequence_Check(obj) || PySequence_Size(obj) != 2)
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

bool sequence_2_ints(PyObject* source, int* i1, int* i2) {
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

    *i1 = PyInt_AsLong(o1);
    *i2 = PyInt_AsLong(o2);

    if (PyErr_Occurred()) {
        fprintf(stderr, "Exception in sequence_2_ints:\n");
        PyErr_Print();
    }
    
    return true;
}
%End

