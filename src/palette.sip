class wxPalette: wxGDIObject {
    wxPalette();
    ~wxPalette();
    int GetPixel(byte red, byte green, byte blue);
    int GetColoursCount() const;
};
