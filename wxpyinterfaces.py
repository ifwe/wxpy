from path import path

SIP_DIR = path('src')

interface_names = '''
wx
'''.strip().split()

interface_files = [str(SIP_DIR / ''.join([name, '.sip'])) for name in interface_names]