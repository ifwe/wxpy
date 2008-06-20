import os.path
import wx

def test_imageformats():

    image_folder = 'tests/images'
    images = [
        'digsbybig.bmp',
        'digsbybig.png',
        'digsby_ascii_popup.png',
        'digsbysmall.ico',
    ]

    for filename in images:
        imgfile = os.path.join(image_folder, filename)
        assert os.path.isfile(imgfile)
        assert wx.Image(imgfile).IsOk()

def main():
    app = wx.PySimpleApp()
    import memleak
    memleak.find(test_imageformats, loops=50)


if __name__ == '__main__':
    main()


