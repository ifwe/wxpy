%ModuleHeaderCode




static int thunkEventType = 0;
typedef void (*ThunkCallback)(void);

class wxThunkEvent : public wxEvent
{
public:
    wxThunkEvent(ThunkCallback cb)
    {
        fprintf(stderr, "wxThunkEvent(%p)\n", cb);
        if (!thunkEventType)
        {
            thunkEventType = wxNewEventType();
            fprintf(stderr, "  thunkEventType = %d\n", thunkEventType);
            wxTheApp->Connect(-1, -1, thunkEventType,
                    (wxObjectEventFunction)&wxThunkEvent::EventThunker);
        }

        this->SetEventType(thunkEventType);
        this->cb = cb;
    }
    ~wxThunkEvent() {}

    virtual wxThunkEvent* Clone() const
    {
        return new wxThunkEvent(cb);
    }

    void EventThunker(wxThunkEvent& event)
    {
        fprintf(stderr, "wxThunkEvent::EventThunker: %p\n", event.cb);
        event.cb();
    }

    ThunkCallback cb;
};



void test_thunk_foo();
void test_thunk_bar();

%End

%ModuleCode

void test_thunk_foo() { fprintf(stderr, "foo\n"); }
void test_thunk_bar() { fprintf(stderr, "bar\n"); }


%End

void thunk_foo();
%MethodCode
    wxTheApp->AddPendingEvent(wxThunkEvent(&test_thunk_foo));
%End

void thunk_bar();
%MethodCode
    wxTheApp->AddPendingEvent(wxThunkEvent(&test_thunk_bar));
%End