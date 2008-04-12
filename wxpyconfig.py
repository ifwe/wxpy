'''
../configure --enable-unicode --enable-optimise --disable-ftp --disable-dialupman --disable-mediactrl --disable-help --disable-xrc --disable-aui --disable-constraints --disable-printarch --disable-mdi --disable-mdidoc --disable-richtext --disable-grid --disable-dataviewctrl --disable-tipdlg --disable-wizarddlg
'''

import os
import platform
import shlex
from path import path


possible_wx_libs = 'xrc stc aui html qa adv core xml net base'.split()
use_wx_libs      = 'core base adv'.split()

if os.name == 'nt':
    platform_name = 'msw'
    raise NotImplementedError('TODO: build setup on wxMSW')
elif 'Darwin' in platform.platform():
    platform_name = 'mac'
    
wxconfig = 'wx-config'

if platform_name in ('mac',):
    wxconfig = path('/Users/kevin/src/wxWebKitBranch-2.8/macbuild/wx-config')
    
    print 'using wxconfig:', str(wxconfig)
    
    cxxflags = shlex.split(wxconfig.run('--cxxflags').strip())
    lflags   = shlex.split(wxconfig.run('--libs %s' % ','.join(use_wx_libs)).strip())
    
    # passed as -t argument
    sip_platform = 'WXMAC'
