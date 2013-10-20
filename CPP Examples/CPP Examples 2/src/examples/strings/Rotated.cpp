#include <iostream>
#include <string>
using namespace std;

/*
"Given a long bit string M and a small bit string N
Make the bits between p & q in M same as N (q-p = strlen(N))"
*/
string replaceString(string dest, string src, int pos) {
    if(dest.length() < pos + src.length() ){
        return "";
    }
    return dest.substr(0,pos).append(src).append(dest.substr(pos + src.length()));
}


/*
Two input strings is given, find out whether 2nd string is rotated of 1st string. e.g. string1="abcd", string2="cdab" should return true.
string1="abcd", string2="cdba" should return false.
*/
bool isRotatedVersion(string s1, string s2) {
    if(s1 == s2) {
        return true;
    }
    if (s1.length() != s2.length()) {
        return false;
    }
    for(int i = 1; i < s1.length(); i++){
        if (s2.compare( s1.substr(i) + s1.substr(0,i))) {
            return true;
        }
    }
}

int getFirstRepeatedCharPos(string s) {
    int matrix[256];
    for(int i = 0; i < 256; i++) matrix[i] = 0;
    for(int i = 0; i < s.length(); i++) {
        if(matrix[s[i]] == 1) {
            return i;
        }
        matrix[s[i]] = 1;
    }
}
/*
How will you efficiently bitwise reverse a very long character string efficiently(Dont use the typical bitwise swapping)
 */
char * bitwiseReverse(char *str) {
//????

}
int main() {
    string s1("Sundeep"), s2("undeep");
    cout << isRotatedVersion(s1, s2) <<endl;
    cout << getFirstRepeatedCharPos("Sundeabaep") << endl;
    cout << replaceString("Sundeep", "Pra", 0) << endl;
}


