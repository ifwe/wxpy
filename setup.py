from __future__ import with_statement

import itertools
import os
import re
import shutil
import sys

from distutils.core import setup, Extension
import sipconfig
import sipdistutils
from path import path

import wxpyconfig
import wxpyinterfaces
import wxpyfeatures

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
            shutil.copystat(oldfile, newfile)

def build():
    cxxflags = [f for f in wxpyconfig.cxxflags if not f.startswith('-O')]
    #cxxflags.append('-O3')
    
    wxpy_ext = Extension("wx", 
        wxpyinterfaces.interface_files,
        extra_compile_args = wxpyconfig.cxxflags + ['-g'],
        extra_link_args = wxpyconfig.lflags,
    )
    
    features = wxpyfeatures.emit_features_file(wxpyinterfaces.SIP_DIR / 'features.sip')

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
            feature_args = itertools.chain(*(('-x', feature) 
                for feature, enabled in features.iteritems() if not enabled))
                
            argsfile = self.generate_args_file([
                "-c", self.build_temp, 
                "-b", sbf,
                '-t', wxpyconfig.sip_platform] + list(feature_args))

            self.spawn([sip_bin, '-z', argsfile, source])

        def swig_sources (self, sources, extension=None):
            sources = sipdistutils.build_ext.swig_sources(self, sources, extension)
            
            sipconfig.inform('build_temp is %s' % self.build_temp)
            manage_cache(self.build_temp)
            return sources

    setup(
        name = 'wxpy',
        version = '1.0',
        ext_modules = [wxpy_ext],
        cmdclass = {'build_ext': wxpy_build_ext},
    )

if __name__ == '__main__':
    build()