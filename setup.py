'''
builds the wxpy extension
'''

from __future__ import with_statement

import distutils.core
import os
import sipconfig
import sipdistutils
import wxpyconfig
import wxpysetup

from path import path

class wxUSE(object):
    STC = True
    HTML = True

def build():
    if wxpyconfig.platform_name == 'msw':
        # no touch on windows
        import os
        os.utime('src/wx.sip', None)
        os.utime('src/html.sip', None)
        os.utime('contrib/stc/stc.sip', None)

    extensions = [wxpysetup.make_sip_ext('_wxcore', ['src/wx.sip'], libs = ['user32.lib'])]

    if wxUSE.HTML:
        extensions.append(wxpysetup.make_sip_ext('_wxhtml', ['src/html.sip']))

    if wxUSE.STC:
        extensions.append(wxpysetup.make_sip_ext('_wxstc', ['contrib/stc/stc.sip']))

    generate_list_types()

    distutils.core.setup(name = 'wxpy',
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

def generate_list_types():
    import genlisttypes
    genlisttypes.generate()

if __name__ == '__main__':
    build()
