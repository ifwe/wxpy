wxCursor wxStockCursor(int id);
%MethodCode
    sipRes = new wxCursor(a0);
%End

class wxCursor : wxGDIObject {
    wxCursor(const wxString& cursorName, long type, int hotSpotX = 0, int hotSpotY = 0);
    virtual ~wxCursor();
};