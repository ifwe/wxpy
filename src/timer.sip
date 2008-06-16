enum {
    wxTIMER_CONTINUOUS,
    wxTIMER_ONE_SHOT
};

class wxTimer : wxEvtHandler
{


public:
    wxTimer(wxEvtHandler* owner = NULL, int id = wxID_ANY);
    virtual ~wxTimer();

    void SetOwner(wxEvtHandler* owner, int id = wxID_ANY);
    wxEvtHandler* GetOwner() const;

    bool Start(int milliseconds = -1, bool oneShot = false);
    void Stop();

    virtual void Notify();

    bool IsRunning() const;

    int GetInterval() const;
    int GetId() const;
    bool IsOneShot() const;
};

class wxPyTimer : wxTimer
{

%TypeHeaderCode

class wxPyTimer : wxTimer
{
public:
    wxPyTimer(PyObject* cb)
    {
        callable = cb;
        Py_XINCREF(callable);
    }

    virtual ~wxPyTimer()
    {
        Py_XDECREF(callable);
        callable = NULL;
    }

    virtual void Notify()
    {
        if (callable != NULL)
        {
            SIP_BLOCK_THREADS
            PyObject_CallObject(callable, NULL);
            SIP_UNBLOCK_THREADS
        }
    }

    PyObject* callable;
};

%End //TypeHeaderCode

public:
    wxPyTimer(SIP_PYCALLABLE cb);
    virtual ~wxPyTimer();
    void Notify();
    SIP_PYOBJECT callable;


%GCTraverseCode
    sipRes = sipVisit(sipCpp->callable, sipArg);
%End

%GCClearCode
    PyObject* callable = sipCpp->callable;
    sipCpp->callable = NULL;
    Py_XDECREF(callable);
    sipRes = 0;
%End

};

class wxTimerEvent : wxEvent
{
public:
    wxTimerEvent(int timerid = 0, int interval = 0);
    virtual ~wxTimerEvent();

    int GetInterval() const;
};
