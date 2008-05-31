@echo off
python setup.py build %1 %2 %3 %4 %5 %6
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

