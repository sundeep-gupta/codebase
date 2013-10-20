#include <iostrea>

class ATMMachine {
    static unsigned int MAXLIMIT;
    ATMMachine() {
    }
public :
    static ATMMachine& getInstance(const Account &account, int pin) {
        if (account.getPin() != pin) {
            // throw exception...
            throw 
        }
        if(instance == NULL) {
            instance = new ATMMachine();
        }
        instance.setAccount(account);
    }


};

int main() {
    Account account;
    int pin;
    try {
        ATMMachine atm = ATMMachine.getInstance(account, pin);
        atm.withdraw(1000);
        atm.showRecentTransaction();
        atm.showBalance();
    } catch(atm_auth_fail aae) {
        
    } catch(

}
