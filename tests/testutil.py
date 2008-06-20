import gc
try:
    import sip
except ImportError:
    SIP = False
else:
    SIP = True
import sys
import weakref

def assert_pyowned(factory):
    'Asserts that an object returned by "factory" is owned by Python.'

    assert_ownership(factory, True)

def assert_cppowned(factory):
    'Asserts that an object returned by "factory" is owned by C++.'

    assert_ownership(factory, False)

def assert_ownership(factory, pyowned = True):
    '''
    Given callable "factory" which returns an object, asserts that the
    ownership lies with Python if pyowned is True, else with C++.
    '''
    # create both a strong and a weak reference to the object
    # returned by 'factory'
    obj = factory()
    weak_obj = weakref.ref(obj)

    # use sip.ispyowned(obj) to check ownership trivially
    if SIP:
        assert pyowned == sip.ispyowned(obj)

    # delete the strong reference and collect any garbage
    del obj
    gc.collect()

    obj = weak_obj()
    if pyowned:
        # make sure the weak reference is dead
        assert obj is None
    else:
        # make sure the weak reference is alive
        assert obj is not None

def check_collected(func):
    obj = func()
    assert obj is not None, "function given to check_collected must return a value"

    if isinstance(obj, tuple):
        # don't use [a for a ...] syntax here, since it leaks a "magic" local
        # like _[1] and the last item in the list won't be collected
        weakobjs = list(weakref.ref(o) for o in obj)
    else:
        weakobjs = [weakref.ref(obj)]

    del obj

    gc.collect()
    for weakobj in weakobjs:
        if weakobj() is not None:
            refs = '\n'.join('    %r' % r for r in gc.get_referrers(weakobj()))
            raise AssertionError('In function %r, %s has %d references:\n%s' %
                                 (func.__name__, repr(weakobj()), sys.getrefcount(weakobj()), refs))
