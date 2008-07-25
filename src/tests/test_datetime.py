import wx

def test_datetimesort():
    d1 = wx.DateTimeFromDMY(12, 6, 2007)

    assert d1.GetDay() == 12
    assert d1.GetYear() == 2007

    d2 = wx.DateTimeFromDMY(15, 7, 2008)
    d3 = wx.DateTimeFromDMY(11, 6, 2007)

    dates = [d1, d2, d3]
    dates.sort()
    assert dates == [d3, d1, d2], repr(dates)

def main():
    test_datetimesort()


if __name__ == '__main__':
    main()