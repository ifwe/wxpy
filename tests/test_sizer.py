import sip
import wx
from testutil import assert_ownership

def test_FlexGridSizer():
    s = wx.FlexGridSizer(2, 2)


def test_GridBagSizer():
    s = wx.GridBagSizer()

def test_BoxSizer():


    s = wx.BoxSizer(wx.HORIZONTAL)

    f = wx.Frame(None)
    b = wx.Button(f)

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

    print 'BEFORE: button1 title is', b1.Label
    s.Clear(True) # test deleteWindows argument
    print 'AFTER:  button1 title is', b1.Label

    assert sip.isdeleted(b1)
    assert sip.isdeleted(b2)

    return f

def test_WindowSetSizer():
    f = wx.Frame(None)
    b = wx.Button(f, -1, 'test')

    s1 = f.Sizer = wx.BoxSizer(wx.HORIZONTAL)
    s1.AddStretchSpacer(1)
    s1.Add(b)

    s2 = f.Sizer = wx.BoxSizer(wx.VERTICAL)
    s2.AddStretchSpacer(1)
    s2.Add(b)

    assert not sip.isdeleted(b)
    assert sip.isdeleted(s1)

    f.Destroy()

def main():
    a = wx.PySimpleApp()
    test_SizerClear().Destroy()

if __name__ == '__main__':
    main()