import gc
import sys
import wx

from weakref import ref

wx.tracing(True)

class MyObject(object):
    def __init__(self):
        self.test = 42

def test_tree():
    f = wx.Frame(None)
    print 'adding root item'
    t = wx.TreeCtrl(f)

    mydata = MyObject()
    mydata2 = MyObject()

    root = t.AddRoot('root')
    assert t.GetItemText(root) == 'root'

    t.SetPyData(root, mydata)
    assert root == t.GetRootItem()
    assert t.GetPyData(root) is t.GetPyData(t.GetRootItem()) is mydata

    t.SetPyData(root, None)
    assert t.GetPyData(root) is None



    weak_mydata = ref(mydata)
    del mydata
    gc.collect()

    assert weak_mydata() is None, repr(gc.get_referrers(weak_mydata()))

    return f

if __name__ == '__main__':
    a=wx.PySimpleApp()
    test_tree()