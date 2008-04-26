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
    
    # TODO: how to infer these without a wx-config binary?    
    cxxflags = '/W4 /MD /DWIN32 /O2 /D__NO_VC_CRTDBG__ /D__WXMSW__ /D__WXDEBUG__ /D_UNICODE /DwxUSE_UNICODE_MSLU=1 /DwxUSE_GRAPHICS_CONTEXT=1'.split()
    
    # TODO: these too ;)
    cxxflags.extend(['/I%s' % (wxdir / 'lib/vc_dll/mswuh'),
                     '/I%s' % (wxdir / 'include')])
    
    lflags = '/LIBPATH:%s' % (wxdir / 'lib/vc_dll')
    
    sip_platform = 'WXMSW'
    
    
    
assert 'sip_platform' in locals(), "Must set sip_platform"
assert 'cxxflags' in locals(),     "Must set cxxflags"
assert 'lflags' in locals(),       "Must set lflags"
