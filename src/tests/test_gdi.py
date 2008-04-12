import wx
import py.test


def test_Point():
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
    s = wx.Size()
    assert s.x == s.y == 0
    assert s == s
    
    s2 = wx.Size(50, 60)
    assert s != s2
    
    s3 = wx.Size(50, 60)
    assert s2 == s3
    
    assert s3 == (50, 60)
    
def test_Rect():
    r = wx.Rect()
    assert r.x == r.y == r.width == r.height == 0
    
    r2 = wx.Rect(1, 2, 3, 4)
    assert r2.x == r2.GetX() == 1
    assert r2.y == r2.GetY() == 2
    assert r2.width == r2.GetWidth() == 3
    assert r2.height == r2.GetHeight() == 4
    
    assert r2.GetTopLeft() == wx.Point(1, 2)
    assert r2.GetTopRight() == wx.Point(3, 2)
    assert r2.GetBottomLeft() == wx.Point(1, 5)
    assert r2.GetBottomRight() == wx.Point(3, 5)
    
    assert r2 == (1, 2, 3, 4)
    
