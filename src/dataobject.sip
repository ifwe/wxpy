

class wxDataFormat /PyName=DataFormat/ {
    wxDataFormat(wxDataFormatId type);
    wxDataFormat(const wxString& format);
    ~wxDataFormat();
    
    bool operator==(wxDataFormatId format) const;
    bool operator!=(wxDataFormatId format) const;
    bool operator==(const wxDataFormat& format) const;
    bool operator!=(const wxDataFormat& format) const;    
};

class wxDataObject /PyName=DataObject/ {
public:
    enum Direction {
        Get  = 0x01,    // format is supported by GetDataHere()
        Set  = 0x02,    // format is supported by SetData()
        Both = 0x03     // format is supported by both (unused currently)
    };
    
    ~wxDataObject();
private:
    wxDataObject();
};
