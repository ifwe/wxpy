@echo off
python setup.py build
IF %ERRORLEVEL% NEQ 0 GOTO done
copy build\lib.win32-2.6\*.pyd wx
copy build\lib.win32-2.6\*.pdb wx
IF %ERRORLEVEL% NEQ 0 GOTO done
color 02
echo ** SUCCESS **
pause
:done
color

