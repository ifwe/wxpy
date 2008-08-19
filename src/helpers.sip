
%ModuleHeaderCode

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

    if (PyErr_Occurred()) {
        PyErr_Print();
        PyErr_Clear();
    }

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
        PyErr_Clear();
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
    {
        PyErr_Print();
        PyErr_Clear();
        return false;
    }

    return is_ints;
}

inline bool sequence_4_ints(PyObject* source, int* i1, int* i2, int* i3, int* i4)
{
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
        PyErr_Clear();
        return false;
    }

    return true;
}


%End


%ModuleHeaderCode
void setDeleted(void* cppObject, sipWrapperType* type);
void setDeletedWrapper(sipWrapper* w);
void transferBack(void* cppObject, sipWrapperType* type);
%End


%ModuleCode

// TODO: actually use the one from sip.h
static void removeFromParent(sipWrapper *self)
{
    if (self->parent != NULL)
    {
        if (self->parent->first_child == self)
            self->parent->first_child = self->sibling_next;

        if (self->sibling_next != NULL)
            self->sibling_next->sibling_prev = self->sibling_prev;

        if (self->sibling_prev != NULL)
            self->sibling_prev->sibling_next = self->sibling_next;

        self->parent = NULL;
        self->sibling_next = NULL;
        self->sibling_prev = NULL;

        /*
         * We must do this last, after all the pointers are correct, because
         * this is used by the clear slot.
         */
        Py_DECREF(self);
    }
}


void setDeleted(void* cppObject, sipWrapperType* type)
{
    sipWrapper* w = (sipWrapper*)sipGetWrapper(cppObject, type);
    setDeletedWrapper(w);
}

void setDeletedWrapper(sipWrapper* w)
{
    if (!w)
        return;

    removeFromParent(w);
    sipResetPyOwned(w);
    w->u.cppPtr = NULL;
}

void transferBack(void* cppObject, sipWrapperType* type)
{
    if (!cppObject)
        return;

    sipWrapper* w = (sipWrapper*)sipGetWrapper(cppObject, type);
    if (!w)
        return;

    sipTransferBack((PyObject*)w);
}

%End // %ModuleCode