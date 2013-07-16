/* This is example for binary operator overloading
 * In this example we override the '+' operator
 */
#include <iostream>
using namespace std;

class Account {
private :
    float m_balance;
public :
    Account(float balance) : m_balance(balance) {}

    /*
     * + operator overloaded for 'Account' argument type.
     */
    Account operator +(const Account& account) {
        Account tmp = Account(this->m_balance);
        tmp = tmp + account.m_balance;
        return tmp;
    }

    /* + operator overloaded for float as argument type */
    Account operator + (const float val) {
        return Account(this->m_balance + val);
    }

    /* Print the val */
    void print() {
        cout << this->m_balance <<endl;
    }
};

int main() {
    Account a(100.0), b(100.0);
    a.print();
    a = a + b;
    a.print();
}
