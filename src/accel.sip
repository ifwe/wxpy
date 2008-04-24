enum
{
    wxACCEL_ALT,
    wxACCEL_CTRL,
    wxACCEL_SHIFT,
    wxACCEL_NORMAL,
    wxACCEL_CMD,
};

class wxAcceleratorEntry
{
public:
    wxAcceleratorEntry(int flags = 0, int keyCode = 0, int cmdID = 0/*, wxMenuItem *menuitem = NULL*/);
    
};

class wxAcceleratorTable : wxObject
{
public:
    wxAcceleratorTable();
};
