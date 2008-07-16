rmdir /s /q Default

bakefile wxtest.bkl -f msvs2005prj

vcbuild wxtest.sln "Default|Win32" 

