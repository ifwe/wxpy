import wx
from time import clock

print wx.__file__

N = 1000000


def timeit(callable, n = N):
    start = clock()
    for x in xrange(n):
        callable()
    return clock() - start
    
def timed(callable, n = N):
    elapsed = timeit(callable, n)
    print callable.__name__, elapsed

def test_gdi():
    
    def recttest():
        r = wx.Rect(2, 4, 6, 8)
    
    timed(recttest)
    
if __name__ == '__main__':
    test_gdi()
    
