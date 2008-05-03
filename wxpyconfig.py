'''
../configure --enable-unicode --enable-optimise --disable-ftp --disable-dialupman --disable-mediactrl --disable-help --disable-xrc --disable-aui --disable-constraints --disable-printarch --disable-mdi --disable-mdidoc --disable-richtext --disable-grid --disable-dataviewctrl --disable-tipdlg --disable-wizarddlg
'''

import os
import platform
import shlex
from path import path

wxpy_dir         = path('~/src/wxpy').expand()
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

    DEBUG_SYMBOLS = True
    ENABLE_EXCEPTIONS = True

    # TODO: infer these without a wx-config binary? (bakefiles!)
    cxxflags = ('/MD /DWIN32 /O2 /D__NO_VC_CRTDBG__ /D__WXMSW__ '
                '/D__WXDEBUG__ /D_UNICODE /DwxUSE_UNICODE_MSLU=1 '
                '/DwxUSE_GRAPHICS_CONTEXT=1 /DWXUSINGDLL').split()

    if DEBUG_SYMBOLS: # debug
        cxxflags.append('/Zi')

    if ENABLE_EXCEPTIONS:
        cxxflags.append('/EHa')


    wx_lib_dir = wxdir / 'lib/vc_dll'
    wx_flag = 'uh'
    wx_config_dir = 'msw' + wx_flag

    # TODO: these too ;)
    cxxflags.extend(['/I%s' % str(wx_lib_dir / wx_config_dir),
                     '/I%s' % str(wxdir / 'include')])

    wx_libs = '''\
base28%s
base28%s_net
base28%s_xml
msw28%s_adv
msw28%s_aui
msw28%s_core
msw28%s_html'''.split()

    wx_libs = ['wx' + (s % wx_flag) + '.lib' for s in wx_libs]



    lflags = ['/LIBPATH:' + str(wxdir / 'lib/vc_dll')]
    lflags.extend(wx_libs)

    if DEBUG_SYMBOLS:
        lflags.append('/DEBUG')

    sip_platform = 'WXMSW'


assert 'sip_platform' in locals(), "Must set sip_platform"
assert 'cxxflags' in locals(),     "Must set cxxflags"
assert 'lflags' in locals(),       "Must set lflags"
