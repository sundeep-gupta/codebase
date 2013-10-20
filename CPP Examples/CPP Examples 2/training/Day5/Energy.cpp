// wap to calculate kinetic and potential energy
#include <iostream>
using namespace std;
class Energy {
protected :
    float m;
public :
    Energy(float m) : m(m) {}
    virtual double calculate() = 0;
};

class KineticEnergy : public Energy {
    float v;
public :
    KineticEnergy(float m, float v) : Energy(m), v(v) {}
    double calculate() {
        return ((double)m * v * v * 0.5);
    }
};

class PotentialEnergy : public Energy {
    float h;
public :
    PotentialEnergy(float m, float h) : Energy(m), h(h) {}
    double calculate() {
        return ((double)m * h * 9.81);
    }
};


int main() {
    Energy *en = new KineticEnergy(10.0, 3.0);
    cout << en->calculate() << endl;

    en = new PotentialEnergy(10.0, 3.0);
    cout << en->calculate() << endl;

}
