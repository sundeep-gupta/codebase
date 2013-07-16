#include "Complex.h"

bool operator ==( const Complex& a, const Complex& b) {
    return a.real == b.real && a.imaginary == b.imaginary;
}

Complex :: Complex (double r, int i) {
	    real = r;
	    imaginary = i;
	}