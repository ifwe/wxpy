import os.path
import wx

image_folder = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'images')

def test_imageformats():
    images = [
        'digsbybig.bmp',
        'digsbybig.png',
        'digsby_ascii_popup.png',
        'digsbysmall.ico',
    ]

    assert os.path.isdir(image_folder), "can't find the images folder"

    for filename in images:
        imgfile = os.path.join(image_folder, filename)
        assert os.path.isfile(imgfile), 'cannot find %s' % imgfile
        assert wx.Image(imgfile).IsOk()

def main():
    app = wx.PySimpleApp()
    import memleak
    memleak.find(test_imageformats, loops=50)


if __name__ == '__main__':
    main()


