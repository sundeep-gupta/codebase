#include <iostream>
class myklas {
    int a, b;
public :
    friend int sum(myklas mc);
    myklas():a(5),b(50){}
};
int sum(myklas mc) {
    return mc.a + mc.b;
}
int main() {
    const char *str = "Sundeep";
    myklas mc;
    std::cout << sum(mc);
}

