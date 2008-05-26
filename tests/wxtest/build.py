from wxpyconfig import cxxflags, lflags
from os import system, chdir

def run(cmd):
    print cmd
    if system(cmd): raise SystemExit

def build():
    run('cl %s /c wxtest.cpp' % (' '.join(cxxflags)))
    run('link wxtest.obj %s'  % (' '.join(lflags)))

def run_program():
    run('wxtest.exe')


def main():
    chdir('src\\tests\\wxtest')
    build()
    run_program()


if __name__ == '__main__':
    main()