enum {
    wxTIMER_CONTINUOUS,
    wxTIMER_ONE_SHOT
};

class wxTimer : wxEvtHandler
{
public:
    wxTimer(wxEvtHandler* owner = NULL, int id = wxID_ANY);
    virtual ~wxTimer();
    
    void SetOwner(wxEvtHandler* ownder, int id = wxID_ANY);
    wxEvtHandler* GetOwner() const;
    
    bool Start(int milliseconds = -1, bool oneShot = false);
    void Stop();
    
    virtual void Notify();
    
    bool IsRunning() const;
    
    int GetInterval() const;
    int GetId() const;
    bool IsOneShot() const;
};

class wxTimerEvent : wxEvent
{
public:
    wxTimerEvent(int timerid = 0, int interval = 0);
    int GetInterval() const;
};