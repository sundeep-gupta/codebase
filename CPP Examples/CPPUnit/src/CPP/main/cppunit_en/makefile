# CppUnit-Tutorial
# file: makefile
# next line has to be changed to the installation-path of CppUnit
CPPUNIT_PATH=/opt/cppunit

ftest: ftest.o fractiontest.o Fraction.o Complex.o ComplexNumberTest.o LinkListReverse.o LinkListReverseTestSuite.o
	gcc -o ftest ftest.o fractiontest.o Fraction.o ComplexNumberTest.o Complex.o LinkListReverse.o LinkListReverseTestSuite.o -L${CPPUNIT_PATH}/lib -lstdc++ -lcppunit -ldl

Fraction.o: Fraction.cc Fraction.h
	gcc -c Fraction.cc

fractiontest.o: fractiontest.cc
	gcc -c fractiontest.cc -I${CPPUNIT_PATH}/include

ftest.o: ftest.cc
	gcc -c ftest.cc -I${CPPUNIT_PATH}/include

Complex.o: Complex.cc
	gcc -c Complex.cc -I${CPPUNIT_PATH}/include

ComplexNumberTest.o: ComplexNumberTest.cc
	gcc -c ComplexNumberTest.cc -I${CPPUNIT_PATH}/include

LinkListReverse.o: LinkListReverse.cc
	gcc -c LinkListReverse.cc -I${CPPUNIT_PATH}/include

LinkListReverseTestSuite.o: LinkListReverseTestSuite.cc
	gcc -c LinkListReverseTestSuite.cc -I${CPPUNIT_PATH}/include


clean:
	rm -f *.o ftest
