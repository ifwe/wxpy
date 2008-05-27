from xml.etree.cElementTree import Element, SubElement, ElementTree
from build.runsip import SIPGenerator
from build.path import path
from time import time

import itertools
import shutil
import os
import sipconfig
import sys
from build.runsip import run

wxpy_modules = [
    ('wxcore', ['src/wx.sip']),
    ('wxhtml', ['src/html.sip']),
]

PROJECT_DIR       = path('build')
GENERATED_SRC_DIR = path('src/generated')
VERBOSE = True
sip_cfg = sipconfig.Configuration()


def wx_path():
    opts = {}
    execfile('wxpy.cfg', opts)
    wxdir = path(opts['WXWIN'])
    if not wxdir.isdir():
        raise AssertionError('cannot find WXWIN at %s' % wxdir)

    return wxdir

WXWIN = wx_path()

def runsip(features):
    sipgen = SIPGenerator(GENERATED_SRC_DIR, 'WXMSW', features)
    makefile = Element('makefile')

#    subelem(makefile, 'include', file = 'wxpy-settings.bkl')
    include = SubElement(makefile, 'include')
    include.set('file', 'wxpy-settings.bkl')

    for module_name, sources in wxpy_modules:
        sip_sources = sipgen.generate_sources(module_name, sources, ['src'])
        add_wxpy_module(makefile, module_name, sip_sources)

    return makefile

def bakefile(makefile):
    os.chdir(PROJECT_DIR)

    ElementTree(makefile).write('wxpy.bkl', 'utf-8')

    os.environ.update(
        WXWIN = WXWIN,
        BAKEFILE_PATHS = WXWIN / 'build/bakefiles/wxpresets'
    )

    run('bakefile_gen')

    globals()['build_' + os.name]()

def build_nt():
    vcbuild_opts = [
        'wxpy.sln',
        '/MP',       # TODO: multicore compilation doesn't seem to be working :[
        '/time',
    ]

    if 'rebuild' in sys.argv:
        vcbuild_opts.append('/rebuild')

    run('vcbuild %s Multilib|Win32' % ' '.join(vcbuild_opts))

    output_dir = PROJECT_DIR / 'obj-msvs2005prj'



def build_path(p):
    'Fix a path so that it is relative to the build directory.'

    p = path(p)
    return PROJECT_DIR.relpathto(p.parent) / p.name

def add_includes(module, inc_paths):
    return [subelem(module, 'include', p) for p in inc_paths]

def add_wxpy_module(makefile, module_name, sources):
    module = subelem(makefile, 'module',
                     id = module_name,
                     template = 'wxpy_extension')

    dllname = subelem(module, 'dllname', '_%s' % module_name)

    add_includes(module, [sip_cfg.sip_inc_dir,
                          sip_cfg.py_inc_dir])

    subelem(module, 'lib-path', sip_cfg.py_lib_dir)

    source_elem = subelem(module, 'sources', '\n'.join(build_path(s) for s in sources))

    return module

def subelem(root, name, text = '', **attrs):
    elem = SubElement(root, name)
    if text:
        elem.text = text

    for k, v in attrs.iteritems():
        elem.set(k, v)

    return elem

def main():
    import genlisttypes
    genlisttypes.generate()

    import wxpyfeatures
    features = wxpyfeatures.emit_features_file(WXWIN, 'src/generated/features.sip')
    feature_args = itertools.chain(*(('-x', feature)
                                     for feature, enabled in features.iteritems() if not enabled))


    feats = list(feature_args)
    sources = runsip(feats)
    manage_cache(GENERATED_SRC_DIR)
    bakefile(sources)


def different(file1, file2, start = 0):
    if not file1.exists() or not file2.exists():
        return True

    if file1.size != file2.size:
        return True

    return file1.bytes() != file2.bytes()

def manage_cache(gendir):
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
            shutil.copy2(newfile, oldfile)
            if VERBOSE:
                sipconfig.inform("--> changed: %s" % newfile.name)
        else:
            #sipconfig.inform("--> same:    %s" % newfile.name)
            shutil.copystat(oldfile, newfile)

    sipconfig.inform('%d file%s changed.' %
                     (changed_count, 's' if changed_count != 1 else ''))


if __name__ == '__main__':
    main()