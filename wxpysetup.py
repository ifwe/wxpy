'''

utils for building wxpy or wxpy extensions

'''

from __future__ import with_statement

import itertools
import shutil
import sipconfig
import sipdistutils
import sys
import wxpyconfig
import wxpyfeatures

from distutils.core import Extension
from path import path

VERBOSE = True

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
    cache.ensure_exists()

    if 'clean' in sys.argv:
        cache.rmtree()

    for newfile in gendir.files('*.cpp') + gendir.files('*.h'):
        oldfile = cache / newfile.name
        if different(newfile, oldfile):
            shutil.copy2(newfile, oldfile)
            if VERBOSE:
                sipconfig.inform("--> changed: %s" % newfile.name)
        else:
            #sipconfig.inform("--> same:    %s" % newfile.name)
            shutil.copystat(oldfile, newfile)


class wxpy_build_ext(sipdistutils.build_ext):
    def generate_args_file(self, args):
        argsfile = path(self.build_temp) / 'sipargs.txt'

        argtext = []
        for opt, arg in zip(args[::2], args[1::2]):
            argtext.append(' '.join([opt, arg]))
        argtext = '\n'.join(argtext)

        if not argsfile.exists() or argsfile.text() != argtext:
            argsfile.write_bytes(argtext)

        return str(argsfile)

    def _sip_compile(self, sip_bin, source, sbf):
        features = wxpyfeatures.emit_features_file('src/features.sip')
        feature_args = itertools.chain(*(('-x', feature)
            for feature, enabled in features.iteritems() if not enabled))

        argsfile = self.generate_args_file([
            "-c", self.build_temp,
            '-I', wxpyconfig.wxpy_dir / 'src',
            "-b", sbf,
            '-t', wxpyconfig.sip_platform] +
            list(feature_args) +
            list(getattr(self, 'extra_sip_includes', []))
        )

        self.spawn([sip_bin, '-z', argsfile, source])

    def swig_sources (self, sources, extension=None):
        sources = sipdistutils.build_ext.swig_sources(self, sources, extension)

        sipconfig.inform('build_temp is %s' % self.build_temp)
        manage_cache(self.build_temp)
        return sources

def make_sip_ext(name, iface_files, include = None):
    cxxflags = [f for f in wxpyconfig.cxxflags if not f.startswith('-O')]
    cargs = list(wxpyconfig.cxxflags) + ['-DWXPY=1']

    includes = []
    if include is not None:
        if isinstance(include, basestring): include = [include]
        for inc in include:
            includes.extend(['-I', inc])
            cargs.append('-I%s'  % inc)

    largs = list(wxpyconfig.lflags)

    ext = Extension(name, iface_files, extra_compile_args = cargs, extra_link_args = largs)
    ext.extra_sip_includes = includes
    return ext
