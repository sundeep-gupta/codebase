#include <iostream>
using namespace std;

template <class matrix_type>
matrix_type * matrix_multiply(matrix_type m1[3][3], matrix_type m2[3][3]) {
    matrix_type (*m3)[3] = new matrix_type[3][3];

    for (int i = 0; i < 3; i++) {
        for(int j = 0; j < 3; j++) {
            m3[i][j] = 0;
            for(int k = 0; k < 3; k++) {
                m3[i][j] = m3[i][j] + m1[i][k] * m2[k][j];
            }
        }
    }
    for (int i = 0; i< 3; i++){
        for(int j = 0; j < 3; j++){
            cout << m3[i][j] << "   ";
        }
        cout << endl;
    }
    return &m3;
}

int main() {
    int m1[3][3] = { {1,2,3}, {4,5,6}, {7,8,9}};
    int m2[3][3] = { {9,8,7}, {6,5,4}, {3,2,1}};
    int m3[3][3];
    matrix_multiply(m1, m2);
    

}
