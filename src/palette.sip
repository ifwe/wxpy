class wxPalette: wxGDIObject
{
    wxPalette();
    virtual ~wxPalette();
    int GetPixel(int red, int green, int blue);
    int GetColoursCount() const;
};
