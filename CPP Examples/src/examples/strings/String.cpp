#include <iostream>
#include <String.h>
using namespace std;

String::String() {
    s = NULL;
    length = 0;
}

String::String(const char* s) {
    if(s == NULL) {
        this->s = NULL;
        length = 0;
        return;
    } 
    for(length = 0; s[length]; length++);
    this->s = new char[length + 1];
    for(int i = 0; i < length; this->s[i] = s[i], i++);
    this->s[length]  = '\0';
}

String::String(const String &copy) {
    length = copy.length;
    this->s = new char[length + 1];
    for(int i = 0; i < length; this->s[i] = copy.s[i], i++);
    s[length] = '\0';
}
int String::indexOf(char c) {
    for(int i = 0; s[i]; i++) {
        if(s[i] == c) {
            return i;
        }
    }
    return -1;
}
char String::getCharAt(int index) {
    if(index >= length) 
        return 0;
    return s[index];
}

String String::operator +(const String& op2) {
    /* create a temp str */
    char *tmp = new char[length + op2.length + 1];
    int i = 0;
    for(; s[i] ; tmp[i] = s[i], i++);
    for(; op2.s[i - length]; tmp[i] = op2.s[i - length], i++);
    tmp[i] = '\0';
    return *(new String(tmp));

}

String String::operator =(const String& src) {
    this->length  = src.length;
    delete[] s;
    s = new char[length + 1];
    for(int i = 0; src.s[i]; s[i] = src.s[i], s++);
        
    return *this;
}

ostream& operator << (ostream &out, const String &s) {
    cout << s.s;
    return cout;
}

int String::getOutOfOrderIndex() {
    /* First check if the str is of length > 2 
     * and determine the order 
     */
    char *str = this->s;
    if (length <= 2) {
        return -1;
    }
    bool order = str[0] > str[1]; 
    for(int i = 2; i < length; i++) {
        /* As long as we are in order do not return */
        if ((str[i -1] > str[i]) != order) {
            return i;
        }
    }
    return length;
}

String String::reverse() {
    char* rev = new char[length];
    int i = 0;
    while(s[i]) {
        rev[ length - i - 1] = s[i];
        i++;
    }
    return String(rev);
}


