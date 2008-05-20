'''
../configure --enable-unicode --enable-optimise --disable-ftp --disable-dialupman --disable-mediactrl --disable-help --disable-xrc --disable-aui --disable-constraints --disable-printarch --disable-mdi --disable-mdidoc --disable-richtext --disable-grid --disable-dataviewctrl --disable-tipdlg --disable-wizarddlg
'''

import os
import platform
import shlex
from path import path

wxpy_dir         = path(os.environ['WXPYDIR'])
possible_wx_libs = 'xrc stc aui html qa adv core xml net base'.split()
use_wx_libs      = 'core base adv'.split()

if os.name == 'nt':
    platform_name = 'msw'
elif 'Darwin' in platform.platform():
    platform_name = 'mac'

wxconfig = 'wx-config'

if platform_name in ('mac',):
    #wxconfig = path('~/src/wxWebKitBranch-2.8/macbuild/wx-config').expand()
    wxconfig = path('~/wxpython-2.8/bin/wx-config').expand()

    print 'using wxconfig:', str(wxconfig)

    if not wxconfig.exists():
        raise AssertionError('cannot find wx-config at: "%s"' % wxconfig)

    cxxflags = shlex.split(wxconfig.run('--cxxflags').strip()) + ['-Wall', '-ggdb']
    lflags   = shlex.split(wxconfig.run('--libs %s' % ','.join(use_wx_libs)).strip())

    # passed as -t argument
    sip_platform = 'WXMAC'

elif platform_name == 'msw':
    wxdir = path(os.environ['WXDIR'])
    assert wxdir.exists()

    print 'using wxwidgets dir:', wxdir

    WX_FLAG = 'ud'              # the postfix on .libs and .dlls
    WXDEBUG = True              # __WXDEBUG__
    DEBUG_SYMBOLS = True        # /Zi
    ENABLE_EXCEPTIONS = False
    WHOLE_PROGRAM_OPTIMIZATION = False

    class CONTRIB(object):
        STC = True

    # TODO: infer these without a wx-config binary? (bakefiles!)
    cxxflags = ('/MD /DWIN32 /GR /D__NO_VC_CRTDBG__ /D__WXMSW__ '
                '/D_UNICODE /DwxUSE_UNICODE_MSLU=1 '
                '/DwxUSE_GRAPHICS_CONTEXT=1 /DWXUSINGDLL /Ox').split()

    lflags = ['/LIBPATH:' + str(wxdir / 'lib/vc_dll')]

    if WHOLE_PROGRAM_OPTIMIZATION:
        cxxflags.append('/GL')
        lflags.append('/LTCG')

    if WXDEBUG:
        cxxflags.extend(['/D__WXDEBUG__', '/D__NO_VC_CRTDBG__'])

    if DEBUG_SYMBOLS: # debug
        cxxflags.append('/Zi')

    if ENABLE_EXCEPTIONS:
        cxxflags.append('/EHa')
    else:
        cxxflags.append('/DwxNO_EXCEPTIONS')


    wx_lib_dir = wxdir / 'lib/vc_dll'
    wx_config_dir = 'msw' + WX_FLAG

    # TODO: these too ;)
    cxxflags.extend(['/I%s' % str(wx_lib_dir / wx_config_dir),
                     '/I%s' % str(wxdir / 'include'),
                     '/I%s' % str(wxdir / 'contrib' / 'include')])

    version_number = '28'

    wx_libs = '''\
base%s
base%s_net
base%s_xml
msw%s_adv
msw%s_aui
msw%s_core
msw%s_html'''.split()

    if CONTRIB.STC:
        wx_libs.append('msw%s_stc')

    wx_libs = ['wx' + (s % (version_number + WX_FLAG)) + '.lib' for s in wx_libs]
    lflags.extend(wx_libs)

    if DEBUG_SYMBOLS:
        lflags.append('/DEBUG')

    sip_platform = 'WXMSW'


assert 'sip_platform' in locals(), "Must set sip_platform"
assert 'cxxflags' in locals(),     "Must set cxxflags"
assert 'lflags' in locals(),       "Must set lflags"
