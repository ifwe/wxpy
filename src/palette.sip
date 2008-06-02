class wxPalette: wxGDIObject {
    wxPalette();
    virtual ~wxPalette();
    int GetPixel(byte red, byte green, byte blue);
    int GetColoursCount() const;
};
