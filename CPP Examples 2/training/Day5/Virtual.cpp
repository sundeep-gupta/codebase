#include <iostream>
#include <iostream>
using namespace std;
class Shape {
    static int count;
public: 
    Shape() { cout<< "Shape constr" << endl; count++;}
    virtual void Draw() { cout << "Draw Shape" << endl; }
    static int getObjectCount() { return count; }
};
int Shape::count = 0;
class Rectangle : public Shape {
public: 
    Rectangle() { cout<< "Rectangle constr" << endl;}
    void Draw() { cout << "Draw Rectangle" << endl; }
};
class Circle : public Shape {
public: 
    Circle() { cout<< "Circle constr" << endl;}
    void Draw() { cout << "Circle Draw Constr" << endl; }
};
class Ellipse :public Circle {
public: 
    Ellipse() { cout<< "Ellipse constr" << endl;}
    void Draw() { cout << "Draw Ellipse" << endl; }
};
int main() {
    Shape *obj[] =  {
        new Shape(),
        new Rectangle(),
        new Circle(),
        new Ellipse(),
        new Ellipse()

    };

    cout << Shape::getObjectCount() << endl;
    for(int i = 0; i< Shape::getObjectCount(); i++) {
        obj[i]->Draw();
    }
    for(int i = 0; i < Shape::getObjectCount(); i++) {
        delete obj[i];
        obj[i] = NULL;
    }
    

}
