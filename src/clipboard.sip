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
PyObject* pyClipboard = sipConvertFromInstance((void*)wxTheClipboard, sipClass_wxClipboard, NULL);
if (pyClipboard) {
    PyDict_SetItemString(sipModuleDict, "TheClipboard", pyClipboard);
    Py_DECREF(pyClipboard);
}
%End
