#ifndef _String_h_
#define _String_h_ 1
#include <iostream>
using namespace std;
class String {
    char *s;
    int length;
public :
    String() ;
    String(const char* s) ;
    String(const String &copy);
    int indexOf(char c);
    char getCharAt(int index);
    String operator +(const String& op2);
    String operator =(const String& src) ;
    int getOutOfOrderIndex();

/*
write a function which sorts an array of strings based on their reversed representation.
(Reversed representation means a string in reverse order: foobar => raboof)
Example: [""xxxB"", ""yyyC"", ""zzzA""] => [""zzzA"", ""xxxB"", ""yyyC""]
Note: The strings are not reversed in the result. They're just sorted based on their reversed representation."
*/
    String reverse();
    friend ostream& operator << (ostream &out, const String &s);
};

#endif 
