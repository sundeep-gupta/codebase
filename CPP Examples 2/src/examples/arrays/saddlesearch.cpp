#include <iostream>
#include <malloc.h>
using namespace std;

class SaddleSearch {
    int **matrix;
    int rows, cols;
public :
    SaddleSearch(int rows, int cols) {
        this->rows = rows;
        this->cols = cols;
        matrix = (int **) malloc( rows * sizeof(int *));
        for(int i = 0; i < rows * cols; i++) {
            if( i % cols == 0) {
                matrix[i/cols] = (int *) malloc( cols * sizeof(int));
            }
            matrix[i/cols][i%cols] = i;
        }

    }
    bool find(int num) {
        // this algo is to search the num.
        for(int ri = 0; ri < rows; ri ++) {
            for (int ci = cols - 1; ci >= 0; ci --) {
                if(matrix[ri][ci] < num) {
                    break;
                }
                if(matrix[ri][ci] == num) {
                    cout << "Number found at matrix[" << ri << "][" << ci <<"]" << endl;
                    return true;
                }
            }
        }
    }
    
};

int main() {
    SaddleSearch sc(5,4);
    sc.find(2);
    return 0;
}
