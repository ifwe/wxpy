class Foo
{
%TypeHeaderCode
    class Foo
    {
    public:
        Foo() {}
        int bar() { return 42; }
    };
%End

public:
    Foo();
    virtual int bar();
};
