enum {
    wxC2S_NAME,             // return colour name, when possible
    wxC2S_CSS_SYNTAX,       // return colour in rgb(r,g,b) syntax
    wxC2S_HTML_SYNTAX,      // return colour in #rrggbb syntax     
};

enum {
    wxALPHA_TRANSPARENT,
    wxALPHA_OPAQUE
};

class wxColour : wxGDIObject {
public:
    wxColour(byte red = 0, byte green = 0, byte blue = 0, byte alpha = 0);
    ~wxColour();
    
    wxString GetAsString(int flags);
    
    bool operator ==(const wxColour& colour);
    
    unsigned Red() const;
    unsigned Blue() const;
    unsigned Green() const;
    unsigned Alpha() const;
    
    SIP_PYOBJECT __repr__();
%MethodCode
    sipRes = PyString_FromFormat("<wx.Colour (%d, %d, %d, %d)>", 
        sipCpp->Red(), 
        sipCpp->Green(),
        sipCpp->Blue(),
        sipCpp->Alpha());
%End
};