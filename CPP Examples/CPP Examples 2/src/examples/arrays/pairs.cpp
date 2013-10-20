/*
Given array of n integers and given a number X, find all the unique pairs of elemens (a,b), whoose some is equal to X.
 */
#include <iostream>
using namespace std;
void findPairs() {
    int array[] = {2, 3, 6, 7, 3, 5, 3, 5, 6, 9, 4};
    int sum = 11;
    bool map[sum + 1];
    for(int i =0; i<= sum; i++) map[i] = false;
    for(int i = 0; i < sizeof(array)/sizeof(int) ; i++) {
        // if number is > sum skip
        if(array[i] > sum)
            continue;
        cout << "setting " << array[i] << endl;
        map[array[i]] = true;
    }
    for(int i = 0; i <= sum/2; i++) {
        if (map[i] && map[sum - i ]) {
            cout << "(" << i << ", " << sum - i << ")" << endl;
        }
    }
}

int main() {
    findPairs();
}
