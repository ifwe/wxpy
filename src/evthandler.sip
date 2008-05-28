

class wxEvtHandler : wxObject
{

%TypeHeaderCode

class wxPyCallback: public wxObject
{
public:
    wxPyCallback(PyObject* func);
    ~wxPyCallback();
    void EventThunker(wxEvent& event);
    PyObject* m_func;
};

%End // TypeHeaderCode


%TypeCode

wxPyCallback::wxPyCallback(PyObject* func) {
    Py_INCREF(func);
    m_func = func;
}

wxPyCallback::~wxPyCallback() {
    Py_DECREF(m_func);
}

// All wxEvtHandler::Connect calls made from Python are routed through
// here.
void wxPyCallback::EventThunker(wxEvent& event) {
    wxPyCallback* cb = (wxPyCallback*)event.m_callbackUserData;
    PyObject* func = cb->m_func;

    // TODO: should the last argument (PyObject* transferObj) be NULL?
    // (NULL means C++ has ownership)
    SIP_BLOCK_THREADS

    PyObject* event_arg = sipConvertFromInstance(&event, sipClass_wxEvent, NULL);
    if (!event_arg)
    {
        printf("WARNING: could not convert to sipClass_wxEvent\n");
        return;
    }

    // Call the event handler, passing the event object
    PyObject* tuple = PyTuple_New(1);
    PyTuple_SET_ITEM(tuple, 0, event_arg); // steals ref to arg

    PyObject* result = PyEval_CallObject(func, tuple);
    if (result)
    {
        Py_DECREF(result); // result is ignored, but we still need to decref it

        if (PyErr_Occurred())
            PyErr_Print();
    } else
        PyErr_Print();

    Py_DECREF(tuple);

    SIP_UNBLOCK_THREADS
}

%End // TypeCode

%TypeHeaderCode
#include <wx/event.h>
%End

public:
    wxEvtHandler();

    wxEvtHandler* GetNextHandler();
    wxEvtHandler* GetPreviousHandler();
    void SetNextHandler(wxEvtHandler *handler);
    void SetPreviousHandler(wxEvtHandler *handler);

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
    SIP_BLOCK_THREADS
        sipCpp->Connect(id, lastId, eventType,
            (wxObjectEventFunction)&wxPyCallback::EventThunker, new wxPyCallback(func));
    SIP_UNBLOCK_THREADS
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
    SIP_BLOCK_THREADS
    if (PyTuple_Check(events))
    {
        for (int i = 0; i < PyTuple_GET_SIZE(events); ++i)
        {
            event = PyInt_AsLong(PyTuple_GET_ITEM(events, i));
            if (event == -1 && PyErr_Occurred())
            {
                sipIsErr = 1;
                break;
            }
            else
                sipCpp->Connect(id, id2, event,
                        (wxObjectEventFunction)&wxPyCallback::EventThunker, new wxPyCallback(func));
        }
    }
    else
    {
        event = PyInt_AsLong(events);
        if (event == -1 && PyErr_Occurred())
            sipIsErr = 1;
        else
            sipCpp->Connect(id, id2, event,
                (wxObjectEventFunction)&wxPyCallback::EventThunker, new wxPyCallback(func));
    }
    SIP_UNBLOCK_THREADS
%End

    void Disconnect(int id, int id2, int eventType);
%MethodCode
        sipCpp->Disconnect(a0, a1, a2);
%End

    void Unbind(SIP_PYOBJECT event, int id = wxID_ANY, int id2 = wxID_ANY);
%MethodCode
    PyObject* events = a0;
    int event;

    SIP_BLOCK_THREADS
    if (PyTuple_Check(events))
    {
        for (int i = 0; i < PyTuple_GET_SIZE(events); ++i)
        {
            event = PyInt_AsLong(PyTuple_GET_ITEM(events, i));
            if (event == -1 && PyErr_Occurred())
            {
                sipIsErr = 1;
                break;
            }
            else
                sipCpp->Disconnect(a1, a2, event, (wxObjectEventFunction)&wxPyCallback::EventThunker);
        }
    }
    else
    {
        event = PyInt_AsLong(events);
        if (event == -1 && PyErr_Occurred())
            sipIsErr = 1;
        else
            sipCpp->Disconnect(a1, a2, event, (wxObjectEventFunction)&wxPyCallback::EventThunker);
    }
    SIP_UNBLOCK_THREADS
%End

private:
    wxEvtHandler(const wxEvtHandler &);

};