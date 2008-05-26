'''
Autogenerate some code from "list.sip.template" to make up
for weak SIP template support.
'''

from __future__ import with_statement
import os.path

types = [
    'wxSizerItem',
]

wrapper = '''\
//
// Autogenerated. See genlisttypes.py
//

%s
'''

header = '''\
//
// Autogenerated from list.sip.template. See genlisttypes.py.
'''


def gentype(typename):
    with open('list.sip.template') as f:
        return header + f.read().replace('TYPE', typename)

def filename(typename):
    if typename.startswith('wx'):
        typename = typename[2:]

    return typename.lower()

def write_if_different(filename, content):
    orig = None
    if os.path.isfile(filename):
        with open(filename, 'r') as f:
            orig = f.read()

    if orig != content:
        print 'writing %s.sip' % filename
        with open(filename + '.sip', 'w') as f:
            f.write(content)

def generate():
    orig_dir = os.getcwd()
    os.chdir('src')
    try:
        filenames = []

        for t in types:
            type_filename = filename(t)
            filenames.append(type_filename)
            write_if_different(type_filename, gentype(t))

        wrapper_txt = wrapper % '\n'.join('%%Include %s.sip' % fn for fn in filenames)

        with open('lists.sip', 'w') as f:
            f.write(wrapper_txt)
    finally:
        os.chdir(orig_dir)