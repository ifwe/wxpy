class wxPalette: wxGDIObject /PyName=Palette/ {
    wxPalette();
    ~wxPalette();
    int GetPixel(byte red, byte green, byte blue);
    int GetColoursCount() const;
};
