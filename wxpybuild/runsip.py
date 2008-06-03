from __future__ import with_statement

from path import path
import os.path
import shlex
import sipconfig
import subprocess
import sys

sip_cfg = sipconfig.Configuration()

class SIPGenerator(object):
    def __init__(self, build_dir, platform, features = None):
        self.build_dir = path(build_dir)
        self.platform = platform
        self.features = features

    def generate_sources(self, module_name, sources, includes):
        # filter out SIP files
        sources = sources[:]
        sipfiles = [s for s in sources if s.endswith('.sip')]
        sources  = [s for s in sources if not s.endswith('.sip')]

        sbf = sip(module_name,
                  sipfiles  = sipfiles,
                  build_dir = self.build_dir,
                  include_dirs = includes,
                  platform  = self.platform,
                  features  = self.features)

        return [self.build_dir / s for s in sbf['sources']] + sources

def gen_args_file(build_dir, args):
    argsfile = path(build_dir) / 'sipargs.txt'

    with argsfile.open('w') as f:
        f.write(args[0])
        for arg in args[1:]:
            f.write('\n' if arg.startswith('-') else ' ')
            f.write(arg)

    return argsfile


def sip(module_name, sipfiles, build_dir, include_dirs, platform = None, features = None):
    'Returns a list of sources created by this invocation of SIP.'

    build_dir = path(build_dir)
    if not build_dir.exists():
        build_dir.makedirs()

    sbf_filename = build_dir / '%s.sbf' % module_name

    args = [
        '-c', build_dir,    # generated sources go here
        '-b', sbf_filename, # SBF output file describing the module's inputs
    ]

    # define a platform for %If (MY_PLATFORM) statements
    if platform is not None:
        args.extend(['-t', platform])

    # additional directories to look for SIP files in
    for incdir in include_dirs:
        args.extend(['-I', incdir])

    if features is not None:
        args.extend(features)

    args = gen_args_file(build_dir, args)

    # spawn the sip binary
    run([sip_cfg.sip_bin,
         '-z', args,
        #'-r',          # generate trace statements
         ] + sipfiles)

    # TODO: spaces in filenames?
    return parse_sbf(sbf_filename)

def inform(cmd):
    print cmd

def parse_sbf(filename):
    '''
    Parses the SBF file emitted by SIP after it generates sources for a module.

    Returns a mapping of the following form:

    {'target':  'the module name',
     'sources': ['generated_src.cpp', 'generated_src2.cpp', ...]
     'headers': ['generated_header.h', 'generated_header2.h', ...]}
    '''

    sbfdict = {}
    for line in open(filename):
        key, sep, value = line.partition(' = ')
        if value:
            assert not key in sbfdict
            if key == 'sources':
                value = value.split()
            sbfdict[key] = value

    assert all(k in sbfdict for k in ('target', 'sources', 'headers'))
    return sbfdict

def run(args, checkret = True, expect_return_code = 0):
    '''
    Runs cmd.

    If the process returns 0, returns the contents of stdout.
    Otherwise, raises an exception showing the error code and stderr.
    '''

    if isinstance(args, basestring):
        args = shlex.split(args.replace('\\', '\\\\'))

    inform('\n%s\n' % ' '.join(args))

    try:
        process = subprocess.Popen(args)
    except WindowsError:
        print >>sys.stderr, 'Error using Popen: args were %r' % args
        raise

    stdout, stderr = process.communicate()
    retcode = process.returncode

    if checkret and retcode != expect_return_code:
        raise SystemExit
        #print >> sys.stderr, '\n'

        #out = stdout if not stderr else stderr
        #raise Exception('"%s" returned error code %d' % (args[0], retcode))

    return stdout
