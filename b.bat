@echo off

if "d"=="%1" goto debug

set SIP_DIR=c:\dev\sip
set PYTHON_EXE=c:\dev\digsby\build\msw\python\pcbuild\win32-pgo\python

set WXDIR=c:\dev\digsby\build\msw\wxWidgets
set WEBKITDIR=c:\dev\digsby\build\msw\WebKit

set wxpysetup_args=--wx=%WXDIR% --webkit=%WEBKITDIR%

:release
echo ---------------------
echo building wxpy RELEASE
echo ---------------------
%PYTHON_EXE% setup.py %wxpysetup_args% %1 %2 %3 %4 %5 %6 %7 %8 %9
goto done

:debug
echo -------------------
echo building wxpy DEBUG
echo -------------------
%PYTHON_EXE%_d setup.py %wxpysetup_args% %1 %2 %3 %4 %5 %6 %7 %8 %9

:done
