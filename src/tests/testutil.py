import gc
import sip
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

