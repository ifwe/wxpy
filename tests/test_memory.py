import os
import wx
from ctypes import byref, WinError, sizeof, create_unicode_buffer, Structure, c_ulong, windll
from ctypes.wintypes import DWORD, HMODULE, MAX_PATH

# constants for OpenProcess
PROCESS_QUERY_INFORMATION = 0x400
PROCESS_VM_READ           = 0x10
PROCESS_SET_QUOTA         = 0x0100

OPEN_PROCESS_FLAGS = PROCESS_QUERY_INFORMATION | PROCESS_VM_READ

pid = os.getpid()
SIZE_T = c_ulong

OpenProcess = windll.kernel32.OpenProcess
CloseHandle = windll.kernel32.CloseHandle
GetProcessMemoryInfo = windll.Psapi.GetProcessMemoryInfo

class PROCESS_MEMORY_COUNTERS(Structure):
    _fields_ = [
        ("cb", DWORD),
        ("PageFaultCount", DWORD),
        ("PeakWorkingSetSize", SIZE_T),
        ("WorkingSetSize", SIZE_T),
        ("QuotaPeakPagedPoolUsage", SIZE_T),
        ("QuotaPagedPoolUsage", SIZE_T),
        ("QuotaPeakNonPagedPoolUsage", SIZE_T),
        ("QuotaNonPagedPoolUsage", SIZE_T),
        ("PagefileUsage", SIZE_T),
        ("PeakPagefileUsage", SIZE_T)
      ]

def meminfo():
    hProcess = OpenProcess(OPEN_PROCESS_FLAGS, False, pid)
    if not hProcess:
        raise WinError()

    try:
        pmc = PROCESS_MEMORY_COUNTERS()
        pmc.cb = sizeof(PROCESS_MEMORY_COUNTERS)

        if not GetProcessMemoryInfo(hProcess, byref(pmc), sizeof(PROCESS_MEMORY_COUNTERS)):
            raise WinError()

        return pmc
    finally:
        CloseHandle(hProcess)

import math
def nicebytecount(bytes):
    if bytes == 0:
        return '0B'

    count = 0
    while math.log(bytes, 2) >= 10:
        bytes, count = bytes/(1024), count+1

    return (('%d' if int(bytes) == bytes else '%.2f')+' %sB') % \
            (bytes, ('','k','M','G', 'T','P')[count])

def app():
    a = wx.PySimpleApp()
    f = wx.Frame(None)
    f.count = 0

    def o(e):
        s = meminfo().WorkingSetSize
        f.SetTitle('%s (%s) (%s)' % (s, nicebytecount(s), f.count))

    def foo():
        f.count += 1

    f.timer = wx.PyTimer(foo)
    f.timer.Start(15, False)

    f.Bind(wx.EVT_SIZE, o)
    f.Show()
    a.MainLoop()

def main():
    app()

if __name__ == '__main__':
    main()