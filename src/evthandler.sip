

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

    int errorIncrement() { return ++m_error_count; }
    int errorCount() const { return m_error_count; }

protected:
    PyObject* m_func;
    int m_error_count;
};

%End // TypeHeaderCode


%TypeCode

wxPyCallback::wxPyCallback(PyObject* func)
    : m_func(func)
    , m_error_count(0)
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

    void Disconnect(int id, int id2, int eventType);
%MethodCode
        sipCpp->Disconnect(a0, a1, a2);
%End

    void Unbind(SIP_PYOBJECT event, int id = wxID_ANY, int id2 = wxID_ANY);
%MethodCode
    PyObject* events = a0;
    int event;

    if (PyTuple_Check(events)) {
        // Event types is a tuple of multiple types
        for (int i = 0; i < PyTuple_GET_SIZE(events); ++i) {
            event = PyInt_AsLong(PyTuple_GET_ITEM(events, i));
            if (event == -1 && PyErr_Occurred()) {
                sipIsErr = 1;
                break;
            } else
                sipCpp->Disconnect(a1, a2, event, (wxObjectEventFunction)&wxPyCallback::EventThunker);
        }
    } else {
        // Event type is a single integer
        event = PyInt_AsLong(events);
        if (event == -1 && PyErr_Occurred())
            sipIsErr = 1;
        else
            sipCpp->Disconnect(a1, a2, event, (wxObjectEventFunction)&wxPyCallback::EventThunker);
    }
%End

// the following code allows the GC to break cycles involving event callbacks

%GCTraverseCode
    sipRes = 0;

    wxList *dynamicEvents = sipCpp->GetDynamicEventTable() ;
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
