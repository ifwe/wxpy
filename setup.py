'''

build the wxpy extension

'''

from __future__ import with_statement

import sipconfig
import sipdistutils
import wxpyconfig
import wxpysetup

from distutils.core import setup
from path import path

def build():
    if wxpyconfig.platform_name == 'msw':
        # no touch on windows
        import os; os.utime('src/wx.sip', None)

    extensions = [
        wxpysetup.make_sip_ext('_wxcore', ['src/wx.sip']),
        wxpysetup.make_sip_ext('_wxhtml', ['src/html.sip']),
    ]

    setup(name = 'wxpy',
          version = '1.0',
          ext_modules = extensions,
          cmdclass = {'build_ext': wxpysetup.wxpy_build_ext})

    if wxpyconfig.platform_name == 'mac':
        install()

def install():
    # TODO: figure out how to make distutils do this for us

    # copy the finished shared libraries into the "wx" directory
    # directly under this one
    build_dir = './build/lib.macosx-10.5-i386-2.5/'
    built_files = ['_wxcore.so', '_wxhtml.so']

    for f in built_files:
        (path(build_dir) / f).copy('./wx')

    # write some build statistics
    import os.path, time
    with open('buildstats.txt', 'a') as f:
        f.write('%s %s\n' % (time.time(), os.path.getsize(build_dir + '_wxcore.so')))

if __name__ == '__main__':
    build()