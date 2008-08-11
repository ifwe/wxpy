'''

utils for building wxpy or wxpy extensions

'''

from __future__ import with_statement

import itertools
import os
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

