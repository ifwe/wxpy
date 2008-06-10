from __future__ import with_statement
import os.path
import shutil
import sipconfig
import sys

from xml.etree.cElementTree import Element, SubElement, ElementTree
from itertools import chain
from contextlib import contextmanager

from wxpybuild.runsip import SIPGenerator, run
from wxpybuild.path import path
from wxpyfeatures import emit_features_file

OUTPUT_DIR        = path('build')
SRC_DIR           = path('src')
GENERATED_SRC_DIR = SRC_DIR / 'generated'

VERBOSE = True
sip_cfg = sipconfig.Configuration()


DEBUG = os.path.splitext(sys.executable)[0].endswith('_d')

def wx_path():
    opts = {}

    try:
        execfile('wxpy.cfg', opts)
        wxwin = opts['WXWIN']
    except Exception:
        if 'WXWIN' in os.environ:
            wxwin = os.environ['WXWIN']
        else:
            raise

    wxdir = path(wxwin)
    if not wxdir.isdir(): raise AssertionError('cannot find WXWIN at %s' % wxdir)
    return wxdir

WXWIN = wx_path()

class wxpyext(object):
    def __init__(name, sources, includes = None, libs = None, libdirs = None):
        self.name = name
        self.sources = sources
        self.includes = includes if includes is not None else []
        self.libs = libs if libs is not None else []
        self.libdirs = libdirs if libdirs is not None else []

def build_extension(project_name, modules,
                    includes = None,
                    libs = None,
                    libdirs = None):
    features = emit_features_file(WXWIN, 'src/generated/features.sip')
    feature_args = list(chain(*(('-x', feature)
                        for feature, enabled in features.iteritems() if not enabled)))

    if includes is not None:
        if isinstance(includes, basestring):
            includes = [includes]

        includes = [path(i).abspath() for i in includes]

    sources = runsip(modules, feature_args, includes, libs, libdirs)
    manage_cache(GENERATED_SRC_DIR)

    # The files we create below go in OUTPUT_DIR
    if not OUTPUT_DIR.exists():
        OUTPUT_DIR.makedirs()

    with cd(OUTPUT_DIR):
        output = bakefile(project_name, sources)
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

    config = '"%s Multilib|Win32"' % ('Debug' if DEBUG else 'Release')

    run('vcbuild %s %s' % (' '.join(vcbuild_opts), config))

def runsip(modules, features, includes = None, libs = None, libdirs = None):
    sipgen = SIPGenerator(GENERATED_SRC_DIR, 'WXMSW', features)
    makefile = Element('makefile')

    include = xmlnode(makefile, 'include', file = 'wxpy-settings.bkl')

    for module_name, sources in modules:
        sip_sources = sipgen.generate_sources(module_name, sources, [os.path.abspath('./src'), path(__file__).parent.parent / 'src'])

        # TODO: remove this awful hack
        if module_name == '_wxcore':
            template = 'wxpy_core'
        else:
            template = 'wxpy_extension'

        add_wxpy_module(makefile, module_name, sip_sources, includes, template, libs, libdirs)

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

def bakefile(project_name, makefile):
    # First, create the BKL file which will tell bakefile how to create platform
    # specific makefiles.
    bkl = project_name + '.bkl'
    ElementTree(makefile).write(bkl, 'utf-8')

    # TODO: support more formats here
    formats = [('msvs2005prj', '%s.sln' % project_name)]

    # create Bakefiles.bkgen
    ElementTree(bakefile_gen(bkl, formats)).write('Bakefiles.bkgen', 'utf-8')

    # Bakefile needs to be told the locations of some .bkl files we need--
    # 1) wx.bkl (and related files)
    # 2) wxpy-settings.bkl, which will provide a template for all wxpy based extensions
    bakefile_paths = [WXWIN / 'build/bakefiles/wxpresets',
                      path(__file__).parent]

    os.environ.update(WXWIN = WXWIN,
                      BAKEFILE_PATHS = os.pathsep.join(bakefile_paths))

    # This results in Makefile (autotools), SLN (Visual Studio), or other
    # platform specific files.
    run('bakefile_gen')

    if len(formats) > 1:
        raise AssertionError('figure out a better way to return the name of the sln')
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
                    libdirs = None):

    module = xmlnode(makefile, 'module',
                     id = module_name,
                     template = 'wxpy_extension' if template is None else template)

    if DEBUG: module_name += '_d'

    dllname = xmlnode(module, 'dllname', '%s' % module_name)

    includes = [sip_cfg.sip_inc_dir,    # for sip.h
                sip_cfg.py_inc_dir]     # for python.h

    if include_paths is not None:
        assert not isinstance(include_paths, basestring)
        includes.extend(include_paths)

    add_includes(module, includes)

    if libs is not None:
        for lib in libs:
            xmlnode(module, 'sys-lib', lib)

    if libdirs is None:
        libdirs = []

    # TODO: Where is PythonXX.lib
    from distutils import sysconfig

    if os.name == 'nt':
        if DEBUG:
            pylibdir = path(sysconfig.project_base) / 'PCBuild'
        else:
            pylibdir = path(sysconfig.project_base)
    else:
        assert False

    for libdir in libdirs + [pylibdir]:
        xmlnode(module, 'lib-path', libdir)

    source_elem = xmlnode(module, 'sources', '\n'.join(build_path(s) for s in sources))

    return module

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

    if file1.size != file2.size:
        return True

    return file1.bytes() != file2.bytes()

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

            #diff(newfile, oldfile)

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
def cd(*path):
    '''
    chdirs to path, always restoring the cwd

    >>> with cd('mydir'):
    >>>     do_stuff()
    '''
    original_cwd = os.getcwd()
    try:
        os.chdir(os.path.join(*path))
        yield
    finally:
        os.chdir(original_cwd)

def diff(new, old):
    run(r'c:\cygwin\bin\diff -d -u "%s" "%s"' % (str(new), str(old)))
