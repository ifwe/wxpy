@echo off
setlocal

set python=dpy
%python% -c "import nose; nose.main()" %*
