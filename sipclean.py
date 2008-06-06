from re import compile
import re

repls = [
	('comments', (compile('\s+//.*'), '')),
	('wxunused', (compile('WXUNUSED\(\s*(\w+)\s*\)'), '$1')),
	('inline',   (compile('inline'), ''))
]

def bigrepl(s):
    for name, (pattern, repl) in repls:
        s, num_subs = pattern.subn(repl, s)
        
    return s
    
def test_repl():
    s = \
    '''
    // test
    WXUNUSED(4)
    '''
    
    s2 = \
    '''
    
    4
    '''
    assert bigrepl(s) == s2
    

def matchhelp(pattern, string, repl='_._'):

    r = re.compile(pattern)
    m = r.search(string)

    if m:
        print('a match!')
        i = 0
        while m:
            m_start = m.start()
            m_end = m.end()

            i += 1
            print( ('%d) start: %d, end: %d, str: %s') %
                   (i, m_start, m_end, string[m_start:m_end]) )

            if m.groups():           # capturing groups
                print('   groups: ' + str(m.groups()))

            if m_end == len(string): # infinite loop if
                break                #    m_start == m_end == len(string)
            elif m_start == m_end:   # zero-width match;
                m_end += 1           #    keep things moving along

            m = r.search(string, m_end)

        print( ('global replace (%s):\n%s') %
               (repl, re.sub(pattern, repl, string)) )

    else:
        print('not a match')
