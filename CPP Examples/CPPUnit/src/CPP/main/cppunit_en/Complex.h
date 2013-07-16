// My attempt for first header file.
#ifndef COMPLEX_H
#define COMPLEX_H

class Complex {
    double real;
	int imaginary;
    public:
	Complex ();
	Complex (double r, int i = 0);
	friend bool operator ==(const Complex& a, const Complex& b);
};

bool operator ==( const Complex& a, const Complex& b);
#endif
