'''
Utilities for building WXPY extensions, including the core library.

TODO: use distutils to track dependencies (i.e, every Python build
system will contain an ad hoc, informally-specified bug-ridden,
slow implementation of half of distutils :[)
'''

from __future__ import with_statement
import os.path
import shutil
import subprocess
import sys

from xml.etree.cElementTree import Element, SubElement, ElementTree
from itertools import chain
from contextlib import contextmanager
from wxpybuild.path import path

def wx_path():
    wxopt = '--wx='
    wxdir = None
    for arg in sys.argv[:]:
        if arg.startswith(wxopt):
            wxdir = arg[len(wxopt):]

    if wxdir is None:
        print >> sys.stderr, 'Please specifiy --wx=PATH_TO_WX on the command line'
        sys.exit(-1)

    wxdir = path(wxdir).abspath()
    if not wxdir.isdir(): raise AssertionError('cannot find WXWIN at %s' % wxdir)
    return wxdir

# Path to wxWidgets source and include files
WXWIN = wx_path()

from wxpyfeatures import emit_features_file

VERBOSE = True
BAKEFILES_VERBOSE = False
OUTPUT_DIR        = path('build')
SRC_DIR           = path('src')
GENERATED_SRC_DIR = SRC_DIR / 'generated'

# find out if we're running with a debug build of python
DEBUG = hasattr(sys, 'gettotalrefcount')

try:
    import sipconfig
except ImportError:
    sys.modules.pop('sipconfig', None)
    sip_dir = os.environ.get('SIP_DIR')
    if sip_dir is not None:
        sys.path.append(sip_dir)
        import sipconfig
    else:
        raise ImportError('Make sure SIP is on the PYTHONPATH, or set SIP_DIR in the enviro0ent.')

from wxpybuild.runsip import SIPGenerator, run

sip_cfg = sipconfig.Configuration()

def build_extension(project_name, modules,
                    includes = None,
                    libs = None,
                    libdirs = None,
                    outputdir = None):

    features = emit_features_file(WXWIN, 'src/generated/features.sip')
    feature_args = list(chain(*(('-x', feature)
                        for feature, enabled in features.iteritems() if not enabled)))

    if includes is not None:
        if isinstance(includes, basestring):
            includes = [includes]

        includes = [path(i).abspath() for i in includes]

    bakefile_xml = runsip(modules, feature_args, includes, libs, libdirs, outputdir)
    manage_cache(GENERATED_SRC_DIR)

    with cd(OUTPUT_DIR, make = True):
        output = bakefile(project_name, bakefile_xml)
        globals()['build_' + os.name](output)

def build_nt(solution_name):
    vcbuild_opts = [
        solution_name,
        '/nologo',    # leave out the MS copyright message
        '/showenv',
        '/time',
        #'/MP',       # TODO: multicore compilation doesn't seem to be working :[
    ]

    if 'rebuild' in sys.argv:
        vcbuild_opts.append('/rebuild')

    if 'pgooptimize' in sys.argv:
        config = 'PGOOptimize'
    elif 'pgoinstrument' in sys.argv:
        config = 'PGOInstrument'
    elif DEBUG:
        config = 'Debug'
    else:
        config = 'Release'

    platform = 'Win32'

    run('vcbuild %s "%s|%s"' % (' '.join(vcbuild_opts), config, platform))

def runsip(modules, features,
           includes = None,
           libs = None,
           libdirs = None,
           outputdir = None):

    sipgen = SIPGenerator(GENERATED_SRC_DIR, 'WXMSW', features)
    makefile = Element('makefile')

    pyver = sys.version[:3].replace('.', '')
    xmlnode(makefile, 'set', pyver, var='WXPY_PYTHON_VERSION')

    include = xmlnode(makefile, 'include', file = 'wxpy-settings.bkl')

    for module_name, sources in modules:
        sip_includes = [
            path('./src').abspath(),
            path('./src/generated').abspath(),
            path(__file__).parent.parent / 'src',
        ]

        sip_interfaces = [s for s in sources if s.endswith('.sip')]
        other_sources  = [s for s in sources if not s.endswith('.sip')]

        sip_sources = sipgen.generate_sources(module_name, sip_interfaces, sip_includes)

        # TODO: remove this awful hack
        if module_name == '_wxcore':
            template = 'wxpy_core'
        else:
            template = 'wxpy_extension'

        add_wxpy_module(makefile, module_name, sip_sources + other_sources,
                        includes, template, libs, libdirs, outputdir)

    return makefile

def bakefile_gen(input, formats):
    bakefile_gen = xmlnode(None, 'bakefile-gen',
                           xmlns = 'http://www.bakefile.org/schema/bakefile-gen')

    xmlnode(bakefile_gen, 'input', input)
    xmlnode(bakefile_gen, 'add-formats', ', '.join(compiler for compiler, output in formats))

    for compiler, output in formats:
        xmlnode(bakefile_gen, 'add-flags', '-o%s' % output,
                files   = input,
                formats = compiler)

    return bakefile_gen

def bakefile(project_name, makefile, outputdir = None):
    # First, create the BKL file which will tell bakefile how to create platform
    # specific makefiles.
    bkl = project_name + '.bkl'
    ElementTree(makefile).write(bkl, 'utf-8')

    # TODO: support more formats here
    formats = [('msvs2008prj', '%s.sln' % project_name)]

    # create Bakefiles.bkgen
    ElementTree(bakefile_gen(bkl, formats)).write('Bakefiles.bkgen', 'utf-8')


    # Bakefile needs to be told the locations of some .bkl files we need--
    # 1) wx.bkl (and related files)
    # 2) wxpy-settings.bkl, which will provide a template for all wxpy based extensions
    bakefile_paths = [WXWIN / 'build/bakefiles/wxpresets',
                      path(__file__).parent]

    os.environ.update(WXWIN = WXWIN,
                      BAKEFILE_PATHS = os.pathsep.join(bakefile_paths))

    # define extra variables that are passed to bakefile_gen with -D
    bakefile_vars = dict(
        WXPY_PYDEBUG = '1' if DEBUG else '0', # link against python25_d.dll
    )

    bakefile_vars_str = ' '.join('-D %s=%s' % (key, value)
        for key, value in bakefile_vars.iteritems())

    # This results in Makefile (autotools), SLN (Visual Studio), or other
    # platform specific files.
    run('bakefile_gen' + (' -V' if BAKEFILES_VERBOSE else '') + ' ' + bakefile_vars_str)

    if len(formats) > 1:
        raise AssertionError('figure out a better way to8return the name of the sln')
    return formats[0][1]


def build_path(p):
    'Fix a path so that it is relative to the build directory.'

    p = path(p)
    return OUTPUT_DIR.relpathto(p.parent) / p.name

def add_includes(module, inc_paths):
    return [xmlnode(module, 'include', p) for p in inc_paths]

def add_wxpy_module(makefile, module_name, sources,
                    include_paths = None,
                    template = None,
                    libs = None,
                    libdirs = None,
                    outputdir = None):

    module = xmlnode(makefile, 'module',
                     id = module_name,
                     template = 'wxpy_extension' if template is None else template)

    if DEBUG:
        module_name += '_d'

    dllname = xmlnode(module, 'dllname', '%s' % module_name)

    includes = [sip_cfg.sip_inc_dir,    # for sip.h
                sip_cfg.py_inc_dir]     # for python.h

    if os.name == 'nt':
        # on windows, pyconfig.h is in Python/PC
        includes.append(os.path.join(os.path.split(sip_cfg.py_inc_dir)[0], 'PC'))

    if include_paths is not None:
        assert not isinstance(include_paths, basestring)
        includes.extend(include_paths)

    add_includes(module, includes)

    if libs is not None:
        for lib in libs:
            xmlnode(module, 'sys-lib', lib)

    if libdirs is None:
        libdirs = []

    # Make sure the linker can find PythonXX.lib
    libdirs.append(get_pylibdir())

    for libdir in libdirs:
        xmlnode(module, 'lib-path', libdir)

    if outputdir is not None:
        xmlnode(module, 'dirname', outputdir)

    source_elem = xmlnode(module, 'sources', '\n'.join(build_path(s) for s in sources))

    # In Visual Studio, .c files do not mix with precompiled headers made for .cpp files.
    # see http://support.microsoft.com/kb/126717
    #
    # This places all .c files passed into sources into a <precom-headers-exclude> tag,
    # which tells Bakefile to mark them as excluded from precompiled headers use.
    exclude_precompiled = xmlnode(module, 'precomp-headers-exclude',
        '\n'.join(build_path(s) for s in sources if s.endswith('.c')))

    return module

def get_pylibdir():
    'Return the location of pythonXX.lib'

    if os.name == 'nt':
        from distutils import sysconfig

        try:
            projbase = path(sysconfig.project_base)
        except AttributeError:
            projbase = path(sysconfig.get_python_inc()).parent / 'pcbuild'

        if projbase.endswith('-pgo'):
            # PGO builds have pythonXX.lib one directory up from the
            # executable.
            pylibdir = projbase.parent
        else:
            pylibdir = projbase
    else:
        assert False, 'get_pylibdir needs to be implemented for this platform'

    return pylibdir


def xmlnode(root, name, text = '', **attrs):
    'Simple way to attach an ElementTree node.'

    elem = SubElement(root, name) if root is not None else Element(name)
    if text:
        elem.text = text

    for k, v in attrs.iteritems():
        elem.set(k, v)

    return elem


def different(file1, file2, start = 0):
    if not file1.exists() or not file2.exists():
        return True

    if file1.size != file2.size or file1.bytes() != file2.bytes():
        return True


def manage_cache(gendir, show_diffs = True):
    """
    This function keeps a cache of all sip-generated *.cpp and *.h files
    and restores the stats of the newly generated set whenever the content
    is unchanged
    """
    sipconfig.inform("Managing the module cache: %s" % gendir)

    gendir = path(gendir)
    cache = gendir / 'cache'
    if not cache.isdir():
        cache.makedirs()

    if 'clean' in sys.argv:
        cache.rmtree()

    changed_count = 0
    for newfile in gendir.files('*.cpp') + gendir.files('*.h'):
        oldfile = cache / newfile.name
        if different(newfile, oldfile):
            changed_count += 1

            if oldfile.exists():
                assert newfile.mtime > oldfile.mtime


            shutil.copy2(newfile, oldfile) # src, dest
            a, b = newfile.stat().st_mtime, oldfile.stat().st_mtime
            #assert a == b, "copy2 failed: mtimes are different! (%s and %s)" % (a, b)

            sipconfig.inform("--> changed: %s" % newfile.name)
        else:
            #sipconfig.inform("--> same:    %s" % newfile.name)
            shutil.copystat(oldfile, newfile)

    sipconfig.inform('%d file%s changed.' %
                     (changed_count, 's' if changed_count != 1 else ''))

@contextmanager
def cd(*path, **kwargs):
    '''
    chdirs to path, always restoring the cwd

    >>> with cd('mydir'):
    >>>     do_stuff()

    Optionally specify "make = True" to create the directory if it doesn't exist.
    '''
    path = os.path.join(*path)

    if kwargs.get('make'):
        if os.path.isfile(path):
            raise AssertionError('cannot create directory %r, there is a file with that name' % path)
        elif not os.path.isdir(path):
            os.makedirs(path)

    original_cwd = os.getcwd()
    try:
        os.chdir(path)
        yield
    finally:
        os.chdir(original_cwd)

