class Foo
{
%TypeHeaderCode
    class Foo
    {
    public:
        Foo() {}
        void bar() {}
        int pyth(const wxSize& size)
        {
            return size.x * size.x + size.y * size.y;
        }
    };
%End

public:
    Foo();
    virtual void bar() /NewThread/;
    int pyth(const wxSize&);
};