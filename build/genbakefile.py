'''

builds wxpy

1) runs SIP to generate sources
2) runs bakefile to generate project files for these sources
3) launch native build system
'''

from xml.etree.cElementTree import Element, SubElement, ElementTree
import sipconfig
import sys

# TODO:
# - pretty print XML output

def run_sip(sip):
    import sipconfig
    cfg = sipconfig.Configuration()

    cfg.sip_bin
    cfg.sip_inc_dir

def add_wxpy_module(makefile, module_name, sources):
    module = SubElement(makefile, 'module')
    module.set('id', module_name)
    module.set('template', 'wxpy_build_settings')

    dllname = SubElement(module, 'dllname')
    dllname.text = module_name

    source_elem = SubElement(module, 'sources')
    source_elem.text = '\n'.join(sources)

    return module

def parse_sbf(filename):
    sbfdict = {}
    for line in open(filename):
        key, sep, value = line.partition(' = ')
        if value:
            assert not key in sbfdict
            sbfdict[key] = value

    assert all(k in sbfdict for k in ('target', 'sources', 'headers'))
    return sbfdict

def generate_wxpy_bakefile(output_filename, sbf_files):
    makefile = Element('makefile')

    include = SubElement(makefile, 'include')
    include.set('file', 'wxpy-settings.bkl')

    for filename in sbf_files:
        sbf = parse_sbf(filename)
        add_wxpy_module(makefile, sbf['target'], sbf['sources'])

    ElementTree(makefile).write(output_filename, 'utf-8')

