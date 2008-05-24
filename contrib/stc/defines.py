'''
#define wxSTC_YAML_DOCUMENT 6

becomes

enum { wxSTC_YAML_DOCUMENT = 6 };
'''


from __future__ import with_statement

def transform():
    lines = open('stc.sip').readlines()

    for n, line in enumerate(lines[:-1]):
        if line.startswith('#define wxSTC_'):
            name, value = line[8:].strip().split()
            try:
                int(value)
            except ValueError:
                assert value.startswith('0x')

            assert name.startswith('wxSTC')

            lines[n] = 'enum { %s = %s };\n' % (name, value)


    open('stc.sip', 'w').writelines(lines)

if __name__ == '__main__':
    transform()