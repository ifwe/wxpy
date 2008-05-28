@echo off
python setup.py build
IF %ERRORLEVEL% NEQ 0 GOTO done
copy build\lib.win32-2.6\*.pyd wx
IF %ERRORLEVEL% NEQ 0 GOTO done
copy build\lib.win32-2.6\*.pdb wx
IF %ERRORLEVEL% NEQ 0 GOTO done
color 02
echo ** SUCCESS **
pause
goto reallydone
:done
color 4f
pause
:reallydone
color

