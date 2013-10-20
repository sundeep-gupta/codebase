/*
write a function which sorts an array of strings based on their reversed representation.
(Reversed representation means a string in reverse order: foobar => raboof)
Example: [""xxxB"", ""yyyC"", ""zzzA""] => [""zzzA"", ""xxxB"", ""yyyC""]
Note: The strings are not reversed in the result. They're just sorted based on their reversed representation."
*/

#include <iostream>
#include <string.h>
using namespace std;

char* reverse(const char* str) {
    int sz = strlen(str);
    char* rev = new char[strlen(str)];
    int i = 0;
    while(str[i]) {
        cout << str[i];
        rev[sz-i - 1] = str[i];
        i++;
    }
    cout << endl;
    return rev;
}

int main() {
    char **str_array = {
        "xxxB", "yyyC", "zzzA"
    };
    for(int i = 0; i < 3; i++ ){
        
    }
    cout << reverse("Sundeep") << endl;

}


