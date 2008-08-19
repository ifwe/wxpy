import os.path
import shutil
import sys

import genlisttypes
from wxpybuild.wxpyext import build_extension, WXWIN

wxpy_modules = [
    ('_wxcore',     ['src/wx.sip']),

    # TODO: use wxUSE_XXX flags
    ('_wxhtml',     ['src/html.sip']),
    ('_wxcalendar', ['src/calendar.sip']),
#   ('_wxcombo',    ['src/combo.sip']),
    ('_wxstc',      ['contrib/stc/stc.sip']),
]

if not '--nowk' in sys.argv:
    wxpy_modules.append(('_webview', ['src/webview.sip']))
    BUILDING_WK = True
else:
    sys.argv.remove('--nowk')
    BUILDING_WK = False

DEBUG = os.path.splitext(sys.executable)[0].endswith('_d')

def get_webkit_dir():
    from path import path

    for arg in sys.argv[:]:
        if arg.startswith('--webkit='):
            WEBKITDIR = path(arg[len('--webkit='):])
            break
    else:
        WEBKITDIR = path(os.environ.get('WEBKITDIR', 'webkit'))

    if not WEBKITDIR.isdir():
        raise Exception('%r is not a valid path\nplease set WEBKITDIR in the environment or pass --webkit=PATH to this script' % str(WEBKITDIR))

    return WEBKITDIR

def fatal(msg, returncode = -1):
    print >> sys.stderr, msg
    sys.exit(returncode)

def main():
    genlisttypes.generate()
    opts = {}

    if BUILDING_WK:
        WEBKITDIR = get_webkit_dir()
        WEBKITBUILD = WEBKITDIR / 'WebKitBuild'

        wk_libdir = WEBKITBUILD / 'Release'
        wk_lib = wk_libdir / 'wxwebkit.lib'
        if os.name == 'nt' and not wk_lib.isfile():
            fatal('could not find webkit libraries in %s' % wk_libdir)

        opts.update(includes = [WEBKITDIR / 'WebKit'],
                    libs     = ['wxwebkit'],
                    libdirs  = [wk_libdir])

        from path import path
        outputdir = path('wx').abspath()
        assert outputdir.isdir()
        opts['outputdir'] = outputdir

    build_extension('wxpy', wxpy_modules, **opts)

def windows_install_pyds():
    srcdir  = 'build/obj-msvs2005prj'
    srcdir += '_d/' if DEBUG else '/'

    destdir = 'wx/'

    print 'copying binaries from %s to %s:' % (srcdir, destdir)
    for name, sources in wxpy_modules:
        if DEBUG:
            name = name + '_d'
        for ext in ('.pyd', '.pdb'):
            print '  %s%s' % (name, ext)
            copy_with_prompt('%s%s%s' % (srcdir,  name, ext),
                             '%s%s%s' % (destdir, name, ext))

def copy_with_prompt(src, dest):
    try_again = True
    while try_again:
        try:
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
