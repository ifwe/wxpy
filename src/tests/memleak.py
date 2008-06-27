import gc
from collections import defaultdict
from ctypes import *
from ctypes.wintypes import *
from operator import itemgetter
import sys, time
################################################################

class PROCESS_MEMORY_COUNTERS(Structure):
    _fields_ = [("cb", DWORD),
                ("PageFaultCount", DWORD),
                ("PeakWorkingSetSize", c_size_t),
                ("WorkingSetSize", c_size_t),
                ("QuotaPeakPagedPoolUsage", c_size_t),
                ("QuotaPagedPoolUsage", c_size_t),
                ("QuotaPeakNonPagedPoolUsage", c_size_t),
                ("QuotaNonPagedPoolUsage", c_size_t),
                ("PagefileUsage", c_size_t),
                ("PeakPagefileUsage", c_size_t)]
    def __init__(self):
        self.cb = sizeof(self)

    def dump(self):
        for n, _ in self._fields_[2:]:
            print n, getattr(self, n)/1e6

windll.psapi.GetProcessMemoryInfo.argtypes = (HANDLE, POINTER(PROCESS_MEMORY_COUNTERS), DWORD)

def wss():
    # Return the working set size (memory used by process)
    pmi = PROCESS_MEMORY_COUNTERS()
    if not windll.psapi.GetProcessMemoryInfo(-1, byref(pmi), sizeof(pmi)):
        raise WinError()
    return pmi.WorkingSetSize

LOOPS = 1000

import math
def nicebytecount(bytes):
    if bytes == 0:
        return '0B'

    count = 0
    while math.log(bytes, 2) >= 10:
        bytes, count = bytes/(1024), count+1

    return (('%d' if int(bytes) == bytes else '%.2f')+' %sB') % \
            (bytes, ('','k','M','G', 'T','P')[count])

def find(func, loops=LOOPS):
    # call 'func' several times, so that memory consumption
    # stabilizes:
    name = func.__name__
    before = time.clock()
    w=sys.stdout.write

    print 'repeating', name, loops, 'times for warmup...'
    for j in xrange(loops):
#        w('.')
        func()

    gc.collect(); gc.collect(); gc.collect()
    bytes = wss()
    objs  = len(gc.get_objects())

    # call 'func' several times, recording the difference in
    # memory consumption before and after the call.  Repeat this a
    # few times, and return a list containing the memory
    # consumption differences.
    print 'repeating', name, loops, 'times with measurements'
    for j in xrange(loops):
#        w('.')
        func()
    gc.collect(); gc.collect(); gc.collect()
    # return the increased in process size
    result = wss() - bytes
    result_objs = len(gc.get_objects()) - objs
    # Sometimes the process size did decrease, we do not report leaks
    # in this case:

    ram_leaked = max(result, 0)
    print class_counts()
    print nicebytecount(ram_leaked), result_objs
    if ram_leaked > 100 * 1024:
        print name, 'leaked!'
    print 'took %s secs' % (time.clock() - before)

    return ram_leaked

def class_counts():
    counts = defaultdict(int)
    for t, obj in ((type(o), o) for o in gc.get_objects()):
        counts[t] += 1

    sorted_counts = sorted(counts.iteritems(), key = itemgetter(1))
    return '\n'.join('%s: %d' % (item[0], item[1]) for item in sorted_counts[-10:])
