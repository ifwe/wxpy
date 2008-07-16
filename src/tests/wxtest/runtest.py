import os.path
from subprocess import Popen

def main():
    os.chdir('Default')

    wxlibdir = os.path.join(os.environ['WXDIR'], 'lib', 'vc_dll')
    os.environ['PATH'] = os.pathsep.join([wxlibdir, os.environ['PATH']])
    from pprint import pprint
    pprint(os.environ['PATH'])

    Popen(['wxtest.exe'], env = os.environ)

if __name__ == '__main__':
    main()
