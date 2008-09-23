%If (wxUSE_IMAGLIST)

%ModuleHeaderCode
#include <wx/imaglist.h>
%End

enum {
    wxIMAGELIST_DRAW_NORMAL,
    wxIMAGELIST_DRAW_TRANSPARENT,
    wxIMAGELIST_DRAW_SELECTED,
    wxIMAGELIST_DRAW_FOCUSED,

    wxIMAGE_LIST_NORMAL,
    wxIMAGE_LIST_SMALL,
    wxIMAGE_LIST_STATE
};


class wxImageList : wxObject
{
private:
    wxImageList(const wxImageList&);
public:
    wxImageList(int width, int height, int mask=true, int initialCount=1);
    virtual ~wxImageList();

    int Add(const wxBitmap& bitmap, const wxBitmap& mask = wxNullBitmap);
    int Add(const wxBitmap& bitmap, const wxColour& maskColour) /PyName=AddWithColourMask/;
    int Add(const wxIcon& icon) /PyName=AddIcon/;

    wxBitmap GetBitmap(int index) const;
    wxIcon GetIcon(int index) const;

    bool Replace(int index, const wxBitmap& bitmap, const wxBitmap& mask = wxNullBitmap);

    bool Draw(int index, wxDC& dc, int x, int x, int flags = wxIMAGELIST_DRAW_NORMAL,
              const bool solidBackground = false);

    int GetImageCount();
    bool Remove(int index);
    bool RemoveAll();

    void GetSize(int index, int& OUTPUT, int& OUTPUT);
};

%End