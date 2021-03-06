'''
../configure --enable-unicode --enable-optimise --disable-ftp --disable-dialupman --disable-mediactrl --disable-help --disable-xrc --disable-aui --disable-constraints --disable-printarch --disable-mdi --disable-mdidoc --disable-richtext --disable-grid --disable-dataviewctrl --disable-tipdlg --disable-wizarddlg
'''

from distutils.debug import DEBUG

if False and DEBUG:
    DEBUG_RUNTIME = True
    WX_FLAG = 'ud'                       # the postfix on .libs and .dlls
    WXDEBUG = True                       # __WXDEBUG__
    DEBUG_SYMBOLS = True                 # /Zi
    WHOLE_PROGRAM_OPTIMIZATION = False   # /GL (slow)
else:
    DEBUG_RUNTIME = False
    WX_FLAG = 'u'
    WXDEBUG = False
    DEBUG_SYMBOLS = True
    WHOLE_PROGRAM_OPTIMIZATION = True

ENABLE_EXCEPTIONS = False

class CONTRIB(object):
    STC = True


import os
import platform
import shlex
from path import path

wxpy_dir         = path(__file__).parent
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
    from wxpybuild.wxpyext import WXWIN as wxdir
    assert wxdir.exists(), '%s does not exist!' % wxdir

    print 'using wxwidgets dir:', wxdir

    # TODO: infer these without a wx-config binary? (bakefiles!)
    if DEBUG_RUNTIME:
        # DEBUG runtime
        cxxflags = ('/MDd /Zi /D_DEBUG /Od /W4').split()
    else:
        # RELEASE runtime
        cxxflags = ('/MD').split()

    cxxflags.extend(['/DWXUSINGDLL'
                     '/DWIN32',
                     '/D__WXMSW__',
                     '/D_UNICODE',
                     '/DwxUSE_GRAPHICS_CONTEXT=1',
                     '/GR',
                     ])

    lflags = ['/LIBPATH:' + str(wxdir / 'lib/vc_dll')]

    if WHOLE_PROGRAM_OPTIMIZATION:
        cxxflags.append('/GL')
        lflags.append('/LTCG')

    if WXDEBUG:
        cxxflags.append('/D__WXDEBUG__')
        if not DEBUG_RUNTIME:
            cxxflags.append('/D__NO_VC_CRTDBG__')
    else:
        cxxflags.append('/DNDEBUG')

    if DEBUG_SYMBOLS: # debug
        if '/Zi' not in cxxflags:
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
msw%s_core
msw%s_adv
msw%s_html
'''.strip().split()

#msw%s_aui
#base%s_xml

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
