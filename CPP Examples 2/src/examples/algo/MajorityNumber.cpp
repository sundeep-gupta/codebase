#include <iostream>


// How to find an integer that repeats more than (>)n/2 times.
// in a given array of size n..in O(1) time complexity..
/*The algorithm approaches the problem in two steps, in the first step we will call the method FindElement that takes an array of integers as an input and returns an element that is “most likely” to be Majority. In the second step, the algorithm will call FindMajority which takes the same array as an input along with the most probable element we determined earlier and will return the element if it turns out to be Majority, or null if its not.
The FindElement algorithm works as follows:
1-declare two variables, we’ll call the first one count and the second one canbeMajority to store the candidate Majority.
2-assume that the first number in the array is Majority and assign its value to canbeMajority.
3-traverse the input array from start to end while applying the following conditions:
If the next element in the array is equal to canbeMajority, then count is incremented by 1.
If the next element in the array is not equal to canbeMajority, then count is decremented by 1.
If at the next element, the count is equal to zero, then count is set to one and this element is considered as canbeMajority
*/
int getMajorityNumber(int[] arr, int size) {
	int canBeMajor = -1;
	int count = 0;
	for(int i = 0 ;i < size; i++) {
		if(count == 0) {
			canBeMajor = arr[i];
			count = 1;
		} else if(canBeMajor == arr[i]) {
			count++;
		} else {
			count--;
		}
	}
	count = 0;
	for(int i = 0; i < size; i++) {
		if (arr[i] == canBeMajor) {
			count++;
			if (count > size / 2) {
				return canBeMajor;
			}
		}
	}
	return -1;

}

int main() {
	int arr[]= {1,1,4,1,4,6,1};
	int size = 7;
	int number = getMajorityNumber(arr, size);
	cout << "Majority Number is " << number << endl;
	return 0;
}
