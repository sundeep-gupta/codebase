#include <iostream>
using namespace std;
class metric {
    char type;
    int value;
public :
    metric(int value, char type = 'm') {
        switch(type) {
        case 'm' :
        case 'c' :
        case 'd' :
            break;
        default :
            throw "Invalid type " ;
        }
        this->value = value;
        this->type = type;
    }
    metric(const metric& copy) {
        this->value = copy.value;
        this->type = copy.type;
    }

    metric operator -(const metric &op2) {
        metric temp = *this;
        if(op2.type == temp.type) {
            temp.value += op2.value;
            return temp;
        }
        int m_val1 = (type == 'm')? value : ((type == 'd') ? value *10 : value / 10);
        int m_val2 = (op2.type == 'm') ? op2.value : ((op2.type == 'd')? op2.value * 10 : op2.value / 10);
        temp.value = (type == 'm')? m_val1 - m_val2
                : ( (type == 'd') ?  (m_val1 - m_val2)/10 : (m_val1 - m_val2)* 10);
        return temp;
    }

    metric operator +(const metric &op2) {
        metric temp = *this;
        if(op2.type == temp.type) {
            temp.value += op2.value;
            return temp;
        }
        int m_val1 = (type == 'm')? value : ((type == 'd') ? value *10 : value / 10);
        int m_val2 = (op2.type == 'm') ? op2.value : ((op2.type == 'd')? op2.value * 10 : op2.value / 10);
        temp.value = (type == 'm')? m_val1 + m_val2
                : ( (type == 'd') ?  (m_val1 + m_val2)/10 : (m_val1+m_val2)* 10);
        return temp;
    }
    void print() {
        cout << value << ' ' << type << endl;
    }
};

int main() {
    metric m1(20,'m'), m2(40, 'd'), m3(56, 'c');
    metric m4 = m1 + m2;
    metric m5 = m2 - m1;
    m4.print();
    m5.print();
    
}

