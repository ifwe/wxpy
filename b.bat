@echo off

if "d"=="%1" goto debug

:release
echo ---------------------
echo building wxpy RELEASE
echo ---------------------
python setup.py %1 %2 %3 %4 %5 %6 %7 %8 %9
goto done

:debug
echo -------------------
echo building wxpy DEBUG
echo -------------------
python_d setup.py %1 %2 %3 %4 %5 %6 %7 %8 %9

:done
