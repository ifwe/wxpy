import os
import shutil

import genlisttypes
from wxpybuild.wxpyext import build_extension, WXWIN

wxpy_modules = [
    ('_wxcore', ['src/wx.sip']),
    ('_wxhtml', ['src/html.sip']),
    ('_wxstc',  ['contrib/stc/stc.sip']),
]

def main():
    genlisttypes.generate()
    build_extension('wxpy', wxpy_modules)

    import os
    if os.name == 'nt':
        windows_install_pyds()

def windows_install_pyds():
    for name, sources in wxpy_modules:
        for ext in ('.pyd', '.pdb'):
            copy_with_prompt('build/obj-msvs2005prj/%s%s' % (name, ext),
                             'wx/%s%s' % (name, ext))

def copy_with_prompt(src, dest):
    try_again = True
    while try_again:
        try:
            print 'copy %s --> %s' % (src, dest)
            shutil.copy2(src, dest)
        except IOError, e:
            print e
            inp = raw_input('Retry? [Y|n] ')

            if inp and not inp.startswith('y'):
                raise SystemExit(1)
            else:
                try_again = True
        else:
            try_again = False





if __name__ == '__main__':
    from traceback import print_exc
    import sys

    try: main()
    except SystemExit: raise
    except: print_exc(); sys.exit(1)