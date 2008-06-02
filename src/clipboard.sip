%ModuleHeaderCode
#ifndef WXPY_PREC
#include <wx/clipbrd.h>
#endif
%End

class wxClipboard : wxObject
{
public:
    virtual bool Open();
    virtual void Close();
    virtual bool IsOpened() const;

    virtual bool AddData(wxDataObject *data /Transfer/);
    virtual bool SetData(wxDataObject *data /Transfer/);

    virtual bool IsSupported(const wxDataFormat& format);
    virtual bool GetData( wxDataObject& data );
    virtual void Clear();
    virtual bool Flush();

    virtual void UsePrimarySelection( bool primary = true );
    static wxClipboard* Get();
private:
    wxClipboard();
    ~wxClipboard();
};


%PostInitialisationCode
PyDict_SetItemString(sipModuleDict, "wxTheClipboard",
                     sipConvertFromInstance((void*)wxTheClipboard, sipClass_wxClipboard, NULL));
%End

/*
DocStr(wxClipboardLocker,
"A helpful class for opening the clipboard and automatically
closing it when the locker is destroyed.", "");

class wxClipboardLocker
{
public:
    wxClipboardLocker(wxClipboard *clipboard = NULL);
    ~wxClipboardLocker();

    DocStr(__nonzero__,
           "A ClipboardLocker instance evaluates to True if the clipboard was
successfully opened.", "");
    %extend {
        bool __nonzero__()   { return !!(*self); }
    }
};

*/