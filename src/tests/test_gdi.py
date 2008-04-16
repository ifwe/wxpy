import wx
import py.test


def test_Point():
    return
    p = wx.Point()
    assert p.x == p.y == 0
    
    p2 = wx.Point(10, 20)
    assert p2.x == 10
    assert p2.y == 20
    
    p3 = wx.Point(5, 6)
    assert p2 != p3
    
    p4 = wx.Point(5, 6)
    assert p3 == p4
    assert p4 == p4
    
    assert p[0] == p[1] == 0
    assert p2[0] == 10
    
    p[0] = 42
    assert p[0] == p.x == 42
    p[1] = p3[1]
    assert p == wx.Point(42, 6)
    
    assert p == (42, 6)
    
def test_Size():
    s = wx.Size(1, 2)
    assert s == (1, 2)

    return
    s = wx.Size()
    assert s.x == s.y == 0
    assert s == s
    
    s2 = wx.Size(50, 60)
    assert s != s2
    
    s3 = wx.Size(50, 60)
    assert s2 == s3
    
    assert s3 == (50, 60)
    
def test_Rect():
    return
    r = wx.Rect()
    assert r.X == r.x == r.Y == r.y == r.Width == r.width == r.Height == r.height == 0
    
    r2 = wx.Rect(1, 2, 3, 4)
    assert r2.x == r2.GetX() == 1
    assert r2.y == r2.GetY() == 2
    assert r2.width == r2.GetWidth() == r2.Width == 3
    assert r2.height == r2.GetHeight() == r2.Height == 4
    
    assert r2.TopLeft == r2.GetTopLeft() == wx.Point(1, 2)
    assert r2.TopRight == r2.GetTopRight() == wx.Point(3, 2)
    assert r2.BottomLeft == r2.GetBottomLeft() == wx.Point(1, 5)
    assert r2.BottomRight == r2.GetBottomRight() == wx.Point(3, 5)
    
    assert r2 == (1, 2, 3, 4) == wx.rect(1, 2, 3, 4)
    assert r2 != (4, 3, 2, 1)

def test_Colour():
    return
    c = wx.Colour(33, 66, 99)
    assert c.Red() == 33

    assert c == wx.Colour(33, 66, 99)
    assert c != wx.Colour(99, 66, 33)

def test_Point2DDouble():
    p = wx.Point2DDouble(10, 20)
