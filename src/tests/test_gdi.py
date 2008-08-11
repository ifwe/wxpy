import os.path
import wx

image_folder = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'images')

def test_Image():
    imgpath = os.path.join(image_folder, 'digsby_ascii_popup.png')

    assert os.path.exists(imgpath)
    img = wx.Image(imgpath)

    assert img.IsOk()
    assert img.GetSize() == (362, 324)
    assert img.GetWidth() == img.Width == 362
    assert img.GetHeight() == img.Height == 324
    assert img.GetRed(0, 0) == img.GetGreen(0, 0) == img.GetBlue(0, 0) == 255

    img2 = img.Scale(50, 50)
    assert img2.IsOk()
    assert img2.GetSize() == (50, 50)

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
    r = wx.Rect()
    attrs = 'X Y x y Width Height width height'.split()
    assert all(0 == val for val in (getattr(r, a) for a in attrs))

    r2 = wx.Rect(1, 2, 3, 4)
    assert r2.x == r2.GetX() == 1
    assert r2.y == r2.GetY() == 2
    assert r2.width == r2.GetWidth() == r2.Width == 3
    assert r2.height == r2.GetHeight() == r2.Height == 4

    assert r2[:2] == r2.Position

    assert r2.TopLeft == r2.GetTopLeft() == wx.Point(1, 2)
    assert r2.TopRight == r2.GetTopRight() == wx.Point(3, 2)
    assert r2.BottomLeft == r2.GetBottomLeft() == wx.Point(1, 5)
    assert r2.BottomRight == r2.GetBottomRight() == wx.Point(3, 5)

    assert r2 == (1, 2, 3, 4)
    assert r2 != (4, 3, 2, 1)

    r3 = wx.RectPS(wx.Point(20, 30), wx.Size(40, 50))
    r4 = wx.RectPS((20, 30), (40, 50))
    assert r3 == r4

    r5 = r3.Inflate(10, 10)

    r6 = wx.Rect(40, 40, 20, 20)
    r6.Offset((20, -10))
    assert r6 == (60, 30, 20, 20)


def test_Colour():
    c = wx.Colour(33, 66, 99)
    assert c.Red() == 33

    assert c == wx.Colour(33, 66, 99) != wx.Colour(33, 66, 99, 254)
    assert c != wx.Colour(99, 66, 33)

    assert wx.Colour(*c) == c
    assert (lambda *a: sum(a))(*wx.Colour(1,2,3,4)) == 10

    # test color slicing
    assert c[:2] == (33, 66)
    assert c[:4] == (33, 66, 99, 255)

def test_Pen():
    c = wx.Colour(213, 213, 213)
    p = wx.Pen(c)
    assert p.Colour == c == wx.Colour(213, 213, 213)

    assert p.Width == 1
    p.SetWidth(5)
    assert p.Width == p.GetWidth() == 5

    assert p.Style == p.GetStyle() == wx.SOLID

    assert p.IsOk()



def main():
    app = wx.PySimpleApp()
    test_Colour()
    #import memleak
    #memleak.find(test_Rect, loops=50000)



if __name__ == '__main__':
    main()
