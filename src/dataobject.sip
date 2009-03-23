%ModuleHeaderCode
#include <wx/dataobj.h>
%End

enum wxDataFormatId
{
    wxDF_INVALID,
    wxDF_TEXT,
    wxDF_BITMAP,
    wxDF_METAFILE,
    wxDF_SYLK,
    wxDF_DIF,
    wxDF_TIFF,
    wxDF_OEMTEXT,
    wxDF_DIB,
    wxDF_PALETTE,
    wxDF_PENDATA,
    wxDF_RIFF,
    wxDF_WAVE,
    wxDF_UNICODETEXT,
    wxDF_ENHMETAFILE,
    wxDF_FILENAME,
    wxDF_LOCALE,
    wxDF_PRIVATE,
    wxDF_HTML,
    wxDF_MAX,
};

wxDataFormat CustomDataFormat(const wxString& format);
%MethodCode
    sipRes = new wxDataFormat(*a0);
%End

class wxDataFormat
{
public:
    wxDataFormat(wxDataFormatId type);
    //wxDataFormat(const wxString& format);
    virtual ~wxDataFormat();

    bool operator==(wxDataFormatId format) const;
    bool operator!=(wxDataFormatId format) const;
    bool operator==(const wxDataFormat& format) const;
    bool operator!=(const wxDataFormat& format) const;

%If (WXMAC)
    void SetType(wxDataFormatId format);
%End
%If (WXMSW)
    void SetType(int format);
%End
    int GetType() const;

    wxString GetId() const;
    void SetId(const wxString& format);
};

class wxDataObject /Supertype=sip.wrapper/
{
public:
    enum Direction {
        Get  = 0x01,    // format is supported by GetDataHere()
        Set  = 0x02,    // format is supported by SetData()
        Both = 0x03     // format is supported by both (unused currently)
    };

    // wxDataObject();  // ***  It's an ABC.
    virtual ~wxDataObject();

    wxDataFormat GetPreferredFormat(Direction dir = Get) const;
    size_t GetFormatCount(Direction dir = Get) const;
    bool IsSupported(const wxDataFormat& format, Direction dir = Get) const;
    size_t GetDataSize(const wxDataFormat& format) const;
/*
    %extend {
        DocAStr(GetAllFormats,
                "GetAllFormats(self, int dir=Get) -> [formats]",
                "Returns a list of all the wx.DataFormats that this dataobject supports
in the given direction.", "");
        PyObject* GetAllFormats(Direction dir = Get) {
            size_t count = self->GetFormatCount(dir);
            wxDataFormat* formats = new wxDataFormat[count];
            self->GetAllFormats(formats, dir);

            wxPyBlock_t blocked = wxPyBeginBlockThreads();
            PyObject* list = PyList_New(count);
            for (size_t i=0; i<count; i++) {
                wxDataFormat* format = new wxDataFormat(formats[i]);
                PyObject* obj = wxPyConstructObject((void*)format, wxT("wxDataFormat"), true);
                PyList_SET_ITEM(list, i, obj); // PyList_SET_ITEM steals a reference
            }
            wxPyEndBlockThreads(blocked);
            delete [] formats;
            return list;
        }
    }
*/

/*
    // copy raw data (in the specified format) to the provided buffer, return
    // True if data copied successfully, False otherwise
    //  bool GetDataHere(const wxDataFormat& format, void *buf) const;

    %extend {
        DocAStr(GetDataHere,
                "GetDataHere(self, DataFormat format) -> String",
                "Get the data bytes in the specified format, returns None on failure.", "
:todo: This should use the python buffer interface isntead...");
        PyObject* GetDataHere(const wxDataFormat& format) {
            PyObject* rval = NULL;
            size_t size = self->GetDataSize(format);
            wxPyBlock_t blocked = wxPyBeginBlockThreads();
            if (size) {
                char* buf = new char[size];
                if (self->GetDataHere(format, buf))
                    rval = PyString_FromStringAndSize(buf, size);
                delete [] buf;
            }
            if (! rval) {
                rval = Py_None;
                Py_INCREF(rval);
            }
            wxPyEndBlockThreads(blocked);
            return rval;
        }
    }


    // get data from the buffer of specified length (in the given format),
    // return True if the data was read successfully, False otherwise
    // bool SetData(const wxDataFormat& format,
    //                     size_t len, const void * buf);
    DocAStr(SetData,
            "SetData(self, DataFormat format, String data) -> bool",
            "Set the data in the specified format from the bytes in the the data string.
", "
:todo: This should use the python buffer interface isntead...");
    %extend {
        bool SetData(const wxDataFormat& format, PyObject* data) {
            bool rval;
            wxPyBlock_t blocked = wxPyBeginBlockThreads();
            if (PyString_Check(data)) {
                rval = self->SetData(format, PyString_Size(data), PyString_AsString(data));
            }
            else {
                // raise a TypeError if not a string
                PyErr_SetString(PyExc_TypeError, "String expected.");
                rval = false;
            }
            wxPyEndBlockThreads(blocked);
            return rval;
        }
    }
    */
private:
    wxDataObject();
    wxDataObject(const wxDataObject&);
};


class wxDataObjectSimple : wxDataObject
{
private:
    wxDataObjectSimple(const wxDataObjectSimple&);

public:
    wxDataObjectSimple(const wxDataFormat& format = wxFormatInvalid);
    virtual ~wxDataObjectSimple();

    const wxDataFormat& GetFormat();
    void SetFormat(const wxDataFormat& format);
     size_t GetDataSize() const;
/*
    %extend {
        DocAStr(GetDataHere,
                "GetDataHere(self) -> String",
                "Returns the data bytes from the data object as a string, returns None
on failure.  Must be implemented in the derived class if the object
supports rendering its data.", "");
        PyObject* GetDataHere() {
            PyObject* rval = NULL;
            size_t size = self->GetDataSize();
            wxPyBlock_t blocked = wxPyBeginBlockThreads();
            if (size) {
                char* buf = new char[size];
                if (self->GetDataHere(buf))
                    rval = PyString_FromStringAndSize(buf, size);
                delete [] buf;
            }
            if (! rval) {
                rval = Py_None;
                Py_INCREF(rval);
            }
            wxPyEndBlockThreads(blocked);
            return rval;
        }
    }


    %extend {
        DocAStr(SetData,
                "SetData(self, String data) -> bool",
                "Copy the data value to the data object.  Must be implemented in the
derived class if the object supports setting its data.
", "");
        bool SetData(PyObject* data) {
            bool rval;
            wxPyBlock_t blocked = wxPyBeginBlockThreads();
            if (PyString_Check(data)) {
                rval = self->SetData(PyString_Size(data), PyString_AsString(data));
            }
            else {
                // raise a TypeError if not a string
                PyErr_SetString(PyExc_TypeError, "String expected.");
                rval = false;
            }
            wxPyEndBlockThreads(blocked);
            return rval;
        }
    }
    */
};

class wxDataObjectComposite : wxDataObject
{
private:
    wxDataObjectComposite(const wxDataObjectComposite&);

public:
    wxDataObjectComposite();
    virtual ~wxDataObjectComposite();

    void Add(wxDataObjectSimple *dataObject /Transfer/, bool preferred = false);
    wxDataFormat GetReceivedFormat() const;
};

class wxTextDataObject : wxDataObjectSimple
{
public:
    wxTextDataObject(const wxString& text = wxEmptyString);
    virtual ~wxTextDataObject();

    size_t GetTextLength();
    wxString GetText();
    void SetText(const wxString& text);
private:
    wxTextDataObject(const wxTextDataObject&);
};

class wxBitmapDataObject : wxDataObjectSimple
{
public:
    wxBitmapDataObject(const wxBitmap& bitmap = wxNullBitmap);
    virtual ~wxBitmapDataObject();

    wxBitmap GetBitmap() const;
    void SetBitmap(const wxBitmap& bitmap);
private:
    wxBitmapDataObject(const wxBitmapDataObject&);
};


class wxFileDataObject : wxDataObjectSimple
{
public:
    wxFileDataObject();
    virtual ~wxFileDataObject();

    const wxArrayString& GetFilenames();
    void AddFile(const wxString &filename);
private:
    wxFileDataObject(const wxFileDataObject&);
};

class wxCustomDataObject : wxDataObjectSimple
{
public:
    wxCustomDataObject(const wxDataFormat& format);
    wxCustomDataObject();
    virtual ~wxCustomDataObject();

    void SetData(SIP_PYOBJECT data);
%MethodCode
    if (PyString_Check(a0))
        sipCpp->SetData(PyString_Size(a0), PyString_AsString(a0));
    else
    {
        PyErr_SetString(PyExc_TypeError, "SetData requires a single string argument");
        sipIsErr = 1;
    }
%End


SIP_PYOBJECT GetData();
%MethodCode
    if (!sipCpp->GetData()) {
        Py_INCREF(Py_None);
        sipRes = Py_None;
    } else
        sipRes = PyString_FromStringAndSize((char*)sipCpp->GetData(), sipCpp->GetSize());
%End

    size_t GetSize();


private:
    wxCustomDataObject(const wxCustomDataObject&);
};

class wxURLDataObject : wxDataObject/*Composite*/
{
public:
    wxURLDataObject(const wxString& url = wxEmptyString);
    virtual ~wxURLDataObject();

    wxString GetURL();
    void SetURL(const wxString& url);
private:
    wxURLDataObject(const wxURLDataObject&);

};
