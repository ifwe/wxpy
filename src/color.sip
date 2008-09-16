enum {
    wxC2S_NAME,             // return colour name, when possible
    wxC2S_CSS_SYNTAX,       // return colour in rgb(r,g,b) syntax
    wxC2S_HTML_SYNTAX,      // return colour in #rrggbb syntax
};

enum {
    wxALPHA_TRANSPARENT,
    wxALPHA_OPAQUE
};

wxColour NamedColour(const wxString& name);
%MethodCode
    sipRes = new wxColour(*a0);
%End

class wxColour : wxGDIObject
{
public:
    wxColour(byte red = 0, byte green = 0, byte blue = 0, byte alpha = wxALPHA_OPAQUE);
    virtual ~wxColour();

    wxString GetAsString(int flags);

    void Set(unsigned red, unsigned blue, unsigned green, unsigned alpha);

    bool operator ==(const wxColour& colour);

    unsigned Red() const;
    unsigned Blue() const;
    unsigned Green() const;
    unsigned Alpha() const;
    bool Ok() const;
    bool IsOk() const;
%MethodCode
    sipRes = sipCpp->Ok();
%End

    SIP_PYOBJECT __repr__();
%MethodCode
    sipRes = PyString_FromFormat("<wx.Colour (%d, %d, %d, %d)>",
        sipCpp->Red(),
        sipCpp->Green(),
        sipCpp->Blue(),
        sipCpp->Alpha());
%End

int __getitem__(int i);
%MethodCode
    switch (a0) {
        case 0: sipRes = sipCpp->Red();   break;
        case 1: sipRes = sipCpp->Green(); break;
        case 2: sipRes = sipCpp->Blue();  break;
        case 3: sipRes = sipCpp->Alpha(); break;
        default:
            PyErr_Format(PyExc_IndexError, "index out of range: %d", a0);
            sipIsErr = 1;
    }
%End

SIP_PYTUPLE __getitem__(SIP_PYSLICE);
%MethodCode
    Py_ssize_t start, stop, step, length;
    PySlice_GetIndicesEx((PySliceObject*)a0, 4, &start, &stop, &step, &length);

    sipRes = PyTuple_New(length);
    if (!sipRes) {
        sipIsErr = 1;
    } else {
        int c = 0;
        int val = -1;
        int i;

        for (i = start; (step > 0 ? i < stop : i > stop); i += step) {
            switch (i) {
                case 0: val = sipCpp->Red(); break;
                case 1: val = sipCpp->Green(); break;
                case 2: val = sipCpp->Blue(); break;
                case 3: val = sipCpp->Alpha(); break;
                default:
                    PyErr_SetString(PyExc_IndexError, "index out of range");
                    sipIsErr = 1;
            }

            if (sipIsErr)
                break;

            PyTuple_SET_ITEM(sipRes, c++, PyInt_FromLong(val));
        }
    }
%End

int __len__();
%MethodCode
    sipRes = 4;
%End
};


class wxColourDatabase
{
public:
    wxColourDatabase();
    virtual ~wxColourDatabase();

    // find colour by name or name for the given colour
    wxColour Find(const wxString& name) const;
    wxString FindName(const wxColour& colour) const;

    void AddColour(const wxString& name, const wxColour& colour);
};
