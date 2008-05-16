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

class wxColour : wxGDIObject {
public:
    wxColour(byte red = 0, byte green = 0, byte blue = 0, byte alpha = 0);
    ~wxColour();

    wxString GetAsString(int flags);

    void Set(unsigned red, unsigned blue, unsigned green, unsigned alpha);

    bool operator ==(const wxColour& colour);

    unsigned Red() const;
    unsigned Blue() const;
    unsigned Green() const;
    unsigned Alpha() const;
    bool Ok() const;

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

int __len__();
%MethodCode
    sipRes = 4;
%End
};


class wxColourDatabase {
public:
    wxColourDatabase();
    ~wxColourDatabase();

    // find colour by name or name for the given colour
    wxColour Find(const wxString& name) const;
    wxString FindName(const wxColour& colour) const;
    //%pythoncode { FindColour = Find }

    void AddColour(const wxString& name, const wxColour& colour);
};
