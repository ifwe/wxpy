'''
wxGridBagSizer tests
'''

from itertools import izip
import wx

try: import sip
except ImportError:
    s = wx.GBPosition
    s.Row = property(s.GetRow, s.SetRow)
    s.Col = property(s.GetCol, s.SetCol)

    s = wx.GBSpan
    s.Rowspan = property(s.GetRowspan, s.SetRowspan)
    s.Colspan = property(s.GetColspan, s.SetColspan)

try:
    from sip import ispyowned
except ImportError:
    def ispyowned(o):
        return o.thisown

def test_GBPosition():
    p = wx.GBPosition(1, 2)
    assert p == wx.GBPosition(1, 2) == (1, 2)
    assert p.Row == p.GetRow() == 1
    assert p.Col == p.GetCol() == 2

def test_GBSpan():
    s = wx.GBSpan(3, 4)
    assert s == wx.GBSpan(3, 4) == (3, 4)
    assert s.Rowspan == s.GetRowspan() == 3
    assert s.Colspan == s.GetColspan() == 4

def test_GridBagSizer():
    f = wx.Frame(None, -1, 'Test')

    s = f.Sizer = wx.GridBagSizer()

    positions = [(0, 0), (0, 2), (1, 0),]
    spans     = [(1, 2), (1, 1), (1, 1),]
    buttons   = [wx.Button(f, -1, 'button %d' % n)
                 for n in xrange(len(positions))]

    def on_button(e):
        e.EventObject.Destroy()

    f.Bind(wx.EVT_BUTTON, on_button)

    sizer = f.Sizer = wx.GridBagSizer()

    sizer_items = []

    for n, (pos, span) in enumerate(izip(positions, spans)):
        button = buttons[n]
        res = sizer.Add(button, pos, span)

        assert isinstance(res, wx.GBSizerItem) and isinstance(res, wx.SizerItem)
        assert res.Pos  == res.GetPos()  == pos
        assert res.Span == res.GetSpan() == span

        #assert res == sizer.FindItemAtPosition(pos), "%r != %r" % \
        #    (res, sizer.FindItemAtPosition(pos))

        assert res is not None
        assert not ispyowned(res)

        # GetItemPosition
        p1, p2 = sizer.GetItemPosition(button), sizer.GetItemPosition(n)
        assert p1 == p2 == pos
        assert p1.Row == p2.Row == pos[0] != (321321,321321)
        assert p1.Col == p2.Col == pos[1] != (321321,321321)

        # GetItemSpan
        s1, s2 = sizer.GetItemSpan(button), sizer.GetItemSpan(n)
        assert s1 == s2 == span
        assert s1.Rowspan == s2.Rowspan == span[0]
        assert s1.Colspan == s2.Colspan == span[1]


    sizer.Layout()
    f.Destroy()

#    print 'CalcMin:', sizer.CalcMin()
#    print 'GetEmptyCellSize():', sizer.GetEmptyCellSize()

    #f.Show()

#    for n, b in enumerate(buttons):
#        print n, b, b.Rect

#    if __name__ == '__main__':
#        a.MainLoop()
#    else:
#        f.Destroy()


def main():
    a = wx.PySimpleApp()
    import memleak
    memleak.find(test_GridBagSizer, loops=5000)


if __name__ == '__main__':
    #test_GridBagSizer()
    main()

