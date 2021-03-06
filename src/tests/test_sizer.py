from __future__ import with_statement

import gc
import sys
import wx

from weakref import ref
from time import clock
from contextlib import contextmanager

import sip
from testutil import assert_ownership, check_collected

def test_DetachItem():
    f = wx.Frame(None)
    s = wx.BoxSizer(wx.HORIZONTAL)
    buttons = []

    for x in xrange(3):
        buttons.append(wx.Button(f, -1, str(x)))
        s.Add(buttons[x])

    s.Detach(1)
    assert [c.Window for c in s.Children] == [buttons[0], buttons[2]]
    assert not sip.isdeleted(buttons[1])


def test_DetachSpacer():
    f = wx.Frame(None)
    s = wx.BoxSizer(wx.HORIZONTAL)

    s.AddSpacer((50, 50))
    s.AddSpacer((60, 60))
    s.AddSpacer((70, 70))

    assert s.Detach(1)
    assert s.Detach(0)
    assert s.Children[0].Spacer == (70, 70)

    f.Destroy()

def test_Detach():
    f = wx.Frame(None)
    s = wx.BoxSizer(wx.HORIZONTAL)

    @check_collected
    def spacer():
        item = s.Add((50, 50))
        s.Detach(0)
        return item

    @check_collected
    def subsizer():
        subsizer = wx.BoxSizer(wx.HORIZONTAL)
        assert sip.ispyowned(subsizer)
        s.Add(subsizer)
        assert not sip.ispyowned(subsizer)
        assert s.Detach(subsizer)
        assert sip.ispyowned(subsizer)
        return subsizer

    @check_collected
    def subsizer_item():
        vsizer = wx.BoxSizer(wx.VERTICAL)
        assert sip.ispyowned(vsizer)
        item = s.Add(vsizer)
        assert not sip.ispyowned(vsizer)
        assert s.Detach(vsizer)
        return item

    print 'calling Destroy'
    f.Destroy()
    print 'done Destroy'

def test_Children():
    @check_collected
    def sizer_children():
        f = wx.Frame(None)
        p = wx.Panel(f)
        f.Sizer = s = wx.BoxSizer(wx.HORIZONTAL)

        assert s.Add(p)

        item = s.Children[0]
        assert p is item.Window
        assert not sip.ispyowned(item)
        del item
        gc.collect()
        assert not sip.isdeleted(p)

        assert 1 == len(s.Children)
        s.Detach(0)
        assert 0 == len(p.Children)

        f.Destroy()

        wx.GetApp().ProcessIdle()
        return f, s, p


def test_FlexGridSizer():
    f = wx.Frame(None)

    buttons = []
    labels = ['SetSizer', 'Collect Garbage', 'test', 'test']
    for label in labels:
        b = wx.Button(f, -1, label)
        buttons.append(b)

    weakrefs = []

    def on_sizer(e=None):
        oldSizer = f.Sizer
        if oldSizer is not None:
            weakrefs.append(ref(oldSizer))

        s = wx.FlexGridSizer(2, 2)

        assert s.FlexibleDirection == s.GetFlexibleDirection() == wx.BOTH
        s.AddGrowableCol(1, 1)

        for b in buttons:
            s.Add(b)

        f.SetSizer(s, False)
        gc.collect()

    def on_gc(e=None):
        print 'gc.collect()'
        gc.collect()

    buttons[0].Bind(wx.EVT_BUTTON, on_sizer)
    buttons[1].Bind(wx.EVT_BUTTON, on_gc)

    on_sizer()

    f.Destroy()

def test_GridBagSizer():
    f = wx.Frame(None)
    s = wx.GridBagSizer()
    f.Sizer = s
    f.Destroy()

def test_BoxSizer():
    f = wx.Frame(None)
    b = wx.Button(f)

    s = wx.BoxSizer(wx.HORIZONTAL)
    assert_ownership(lambda: s.Add(b), pyowned = False)
    f.Destroy()

def test_SizerClear():
    f = wx.Frame(None)
    b1 = wx.Button(f, -1, 'test')
    b2 = wx.Button(f, -1, 'test2')

    s = wx.BoxSizer(wx.HORIZONTAL)
    s.Add(b1)
    s.Add(b2)

    assert not sip.isdeleted(b1)
    assert not sip.isdeleted(b2)

    s.Clear(True) # test deleteWindows argument

    assert sip.isdeleted(b1)
    assert sip.isdeleted(b2)

    f.Destroy()

def test_WindowSetSizer():
    f = wx.Frame(None)
    assert not sip.ispyowned(f)

    b = wx.Button(f, -1, 'test')

    s1 = wx.BoxSizer(wx.HORIZONTAL)
    f.SetSizer(s1)
    assert f.Sizer is s1
    s1.AddStretchSpacer(1)
    s1.Add(b)

    s2 = wx.BoxSizer(wx.VERTICAL)
    f.SetSizer(s2)
    assert f.Sizer is s2
    s2.AddStretchSpacer(1)
    s2.Add(b)

    assert not sip.isdeleted(b)
    assert sip.isdeleted(s1)
    f.Destroy()

    wx.GetApp().ProcessIdle()
    assert sip.isdeleted(f)


def test_HiddenItem():
    f = wx.Frame(None)
    s = f.Sizer = wx.BoxSizer(wx.VERTICAL)

    for x in xrange(10):
        st = wx.StaticText(f, -1, 'test %d' % x)
        if x % 2 == 0:
            st.Hide()

        s.Add(st)

    return f


def main():
    a = wx.PySimpleApp()
    test_DetachItem()
    #import memleak

    #test_Detach()
    #memleak.find(test_Detach, loops = 3)
#    for func in globals().values():
#        if callable(func) and func.__name__.startswith('test_'):
#            print
#            print func.__name__
#            print
#            memleak.find(func)

    #import pdb; pdb.set_trace()

if __name__ == '__main__':
    main()
