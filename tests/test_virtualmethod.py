from wx import Foo
import new
import gc
from testutil import check_collected

def test_virtualmethod():

    f = Foo()
    res = f.bar()
    assert res == 42, 'got %s' % res

    class MyFoo(Foo):
        def bar(self):
            return 7

    @check_collected
    def check_virt():
        myfoo = MyFoo()
        assert myfoo.bar() == 7

        myfoo2 = MyFoo()
        assert myfoo2.bar() == 7

        return myfoo, myfoo2

    class MyFlub(Foo):
        pass

    @check_collected
    def check_patched():
        flub = MyFlub()

        return_two = lambda self: 2
        return_three = lambda self: 3

        flub.bar = new.instancemethod(return_two, flub, MyFlub)
        assert flub.bar() == 2

        flub.bar = new.instancemethod(return_three, flub, MyFlub)
        assert flub.bar() == 3

        return flub, return_two, return_three
        

def main():
    test_virtualmethod()

if __name__ == '__main__':
    main()
