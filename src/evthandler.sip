

class wxEvtHandler : wxObject
{

%TypeHeaderCode

class wxPyCallback: public wxObject
{
public:
    wxPyCallback(PyObject* func);
    virtual ~wxPyCallback();
    void EventThunker(wxEvent& event);

    PyObject* callback() const
    {
        return m_func;
    }

protected:
    PyObject* m_func;
};

%End // TypeHeaderCode


%TypeCode

wxPyCallback::wxPyCallback(PyObject* func)
    : m_func(func)
{
    Py_INCREF(func);
}

wxPyCallback::~wxPyCallback() {
    // may be called at any time
    SIP_BLOCK_THREADS
    Py_CLEAR(m_func);
    SIP_UNBLOCK_THREADS
}

// All wxEvtHandler::Connect calls made from Python are routed through
// here.
void wxPyCallback::EventThunker(wxEvent& event) {

    SIP_BLOCK_THREADS
    wxPyCallback* cb = (wxPyCallback*)event.m_callbackUserData;
    PyObject* func = cb->m_func;

    if (!func)
        goto skip_event;

    // TODO: should the last argument (PyObject* transferObj) be NULL?
    // (NULL means C++ has ownership)

    PyObject* event_arg = sipConvertFromInstance(&event, sipClass_wxEvent, NULL);
    if (!event_arg) {
        fprintf(stderr, "WARNING: could not convert to sipClass_wxEvent\n");
        goto skip_event;
    }

    // Call the event handler, passing the event object
    PyObject* tuple = PyTuple_New(1);
    if (tuple) {
        PyTuple_SET_ITEM(tuple, 0, event_arg); // steals ref to arg

        PyObject* result = PyEval_CallObject(func, tuple);
        Py_DECREF(tuple);

        Py_XDECREF(result);
    } else
        Py_DECREF(event_arg);

    if (PyErr_Occurred()) {
        PyErr_Print();
    }

skip_event:
    SIP_UNBLOCK_THREADS
}

%End // TypeCode

%TypeHeaderCode
#include <wx/event.h>
%End

private:
    wxEvtHandler(const wxEvtHandler &);

public:
    wxEvtHandler();
    virtual ~wxEvtHandler();

    wxEvtHandler* GetNextHandler() /Transfer/;
    wxEvtHandler* GetPreviousHandler() /Transfer/;
    void SetNextHandler(wxEvtHandler *handler /Transfer/);
    void SetPreviousHandler(wxEvtHandler *handler /Transfer/);

    void SetEvtHandlerEnabled(bool enabled);
    bool GetEvtHandlerEnabled() const;

    bool ProcessEvent(wxEvent& event);
    void AddPendingEvent(wxEvent& event);
    void ProcessPendingEvents();

    void Connect(int id, int lastId, int eventType, SIP_PYCALLABLE func);
%MethodCode
    int id = a0;
    int lastId = a1;
    int eventType = a2;
    PyObject* func = a3;

    // func must be callable
    sipCpp->Connect(id, lastId, eventType,
        (wxObjectEventFunction)&wxPyCallback::EventThunker, new wxPyCallback(func));
%End

    void Bind(SIP_PYOBJECT event, SIP_PYCALLABLE func, wxWindow* source = NULL, int id = wxID_ANY, int id2 = wxID_ANY);
%MethodCode
    PyObject* events = a0;
    PyObject* func = a1;
    wxWindow* source = a2;
    int id = a3;
    int id2 = a4;

    if (source)
        id = source->GetId();

    int event;
    if (PyTuple_Check(events)) {
        for (int i = 0; i < PyTuple_GET_SIZE(events); ++i) {
            event = PyInt_AsLong(PyTuple_GET_ITEM(events, i));
            if (event == -1 && PyErr_Occurred()) {
                sipIsErr = 1;
                break;
            }
            else
                sipCpp->Connect(id, id2, event,
                        (wxObjectEventFunction)&wxPyCallback::EventThunker, new wxPyCallback(func));
        }
    } else {
        event = PyInt_AsLong(events);
        if (event == -1 && PyErr_Occurred())
            sipIsErr = 1;
        else
            sipCpp->Connect(id, id2, event,
                (wxObjectEventFunction)&wxPyCallback::EventThunker, new wxPyCallback(func));
    }
%End

    bool Disconnect(int id, int id2 = -1, int eventType = wxEVT_NULL, SIP_PYOBJECT func = NULL);
%MethodCode
        PyObject* func = a3;
        if (!func || func == Py_None)
            sipRes = sipCpp->Disconnect(a0, a1, a2);
        else {
            int id = a0;
            int lastId = a1;
            int eventType = a2;

            // Find the current matching binder that has this function
            // pointer and dissconnect that one.  Unfortuneatly since we
            // wrapped the PyObject function pointer in another object we
            // have to do the searching ourselves...
            wxList::compatibility_iterator node = sipCpp->GetDynamicEventTable()->GetFirst();
            while (node) {
                wxDynamicEventTableEntry *entry = (wxDynamicEventTableEntry*)node->GetData();
                if ((entry->m_id == id) &&
                    ((entry->m_lastId == lastId) || (lastId == wxID_ANY)) &&
                    ((entry->m_eventType == eventType) || (eventType == wxEVT_NULL)) &&
                    ((entry->m_fn == (wxObjectEventFunction)&wxPyCallback::EventThunker)) &&
                    (entry->m_callbackUserData != NULL))
                {
                    wxPyCallback *cb = (wxPyCallback*)entry->m_callbackUserData;
                    int result = PyObject_Compare(cb->callback(), func);
                    if (result == 0) {
                        delete cb;
                        sipCpp->GetDynamicEventTable()->Erase(node);
                        delete entry;
                        sipRes = true;
                        goto done;
                    }
                }
                node = node->GetNext();
            }
            sipRes = false;
        }
    done:
%End

    bool Unbind(SIP_PYOBJECT event, int id = wxID_ANY, int id2 = wxID_ANY, SIP_PYOBJECT handler = NULL);
%MethodCode
    PyObject* events = a0;
    PyObject* handler = a3 ? a3 : Py_None;
    PyObject* result;
    int event;

    sipRes = false;

    if (PyTuple_Check(events)) {
        // Event types is a tuple of multiple types
        for (int i = 0; i < PyTuple_GET_SIZE(events); ++i) {
            event = PyInt_AsLong(PyTuple_GET_ITEM(events, i));
            if (event == -1 && PyErr_Occurred()) {
                sipIsErr = 1;
                break;
            } else {
                result = PyObject_CallMethod(sipSelf, "Disconnect", "(iiiO)", a1, a2, event, handler);
                if (!result) {
                    sipIsErr = 1;
                    break;
                } else {
                    sipRes = sipRes || PyObject_IsTrue(result);
                    Py_DECREF(result);
                }
            }
        }
    } else {
        // Event type is a single integer
        event = PyInt_AsLong(events);
        if (event == -1 && PyErr_Occurred())
            sipIsErr = 1;
        else {
            result = PyObject_CallMethod(sipSelf, "Disconnect", "(iiiO)", a1, a2, event, handler);
            if (!result)
                sipIsErr = 1;
            else {
                sipRes = 0 != PyObject_IsTrue(result);
                Py_DECREF(result);
            }
        }
    }
%End

// TODO: the following methods could greatly benefit from a macro to iterate over event handlers

    SIP_PYLIST GetPythonHandlers();
%MethodCode
        if (!(sipRes = PyList_New(0)))
            sipIsErr = 1;
        else {
            if (wxList *dynamicEvents = sipCpp->GetDynamicEventTable()) {
                wxList eventList(*dynamicEvents);
                wxList::compatibility_iterator node = eventList.GetFirst();
                while (node) {
                    wxDynamicEventTableEntry *entry = (wxDynamicEventTableEntry*)node->GetData();
                    node = node->GetNext();
                    if (entry->m_fn == &wxPyCallback::EventThunker && entry->m_callbackUserData) {
                        if (PyObject* func = (reinterpret_cast<wxPyCallback*>(entry->m_callbackUserData))->callback()) {
                            PyObject* tuple = Py_BuildValue("(iiiO)",
                                entry->m_eventType, entry->m_id, entry->m_lastId, func);
                            if (!tuple || -1 == PyList_Append(sipRes, tuple)) {
                                Py_DECREF(sipRes);
                                sipRes = NULL;
                                sipIsErr = 1;
                                if (tuple)
                                    Py_DECREF(tuple);
                                break;
                            }
                            Py_DECREF(tuple);
                        }
                    }
                }
            }
        }
%End

// the following code allows the GC to break cycles involving event callbacks

%GCTraverseCode
    sipRes = 0;

    wxList *dynamicEvents = sipCpp->GetDynamicEventTable();
    if (dynamicEvents) {
        wxList list(*dynamicEvents);
        wxList::compatibility_iterator node = list.GetFirst();
        while (node) {
            wxDynamicEventTableEntry *entry = (wxDynamicEventTableEntry*)node->GetData();
            node = node->GetNext();

            // find the match
            if (entry->m_fn == &wxPyCallback::EventThunker && entry->m_callbackUserData) {
                PyObject* func = (reinterpret_cast<wxPyCallback*>(entry->m_callbackUserData))->callback();

                if (func) {
                    sipRes = sipVisit(func, sipArg);
                    if (sipRes)
                        break;
                }
            }
        }
    }
%End

%GCClearCode
    wxList *dynamicEvents = sipCpp->GetDynamicEventTable() ;
    if (dynamicEvents) {
        wxList list(*dynamicEvents);
        wxList::compatibility_iterator node = list.GetFirst();
        while (node) {
            wxDynamicEventTableEntry *entry = (wxDynamicEventTableEntry*)node->GetData();
            node = node->GetNext();

            // find the match
            if (entry->m_fn == &wxPyCallback::EventThunker && entry->m_callbackUserData) {
                wxObject* obj = entry->m_callbackUserData;
                entry->m_callbackUserData = 0;
                if (obj)
                    delete obj; // will DECREF the callback
            }
        }
    }

    sipRes = 0;
%End


};
