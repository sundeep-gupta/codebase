<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of Account
 *
 * @author bubble
 */
class Account {
    private $id;
    private $balance;
    //put your code here
    public function  __construct($id) {
        $this->id = $id;
        $this->populate();
    }
    protected function populate() {
        $query = "SELECT BALANCE FROM ACCOUNT WHERE ID = ?";
         $conn = Connection::get_connection();
        if ($conn == null) {
            throw new BackendException('Failed to get database connection');
        }
        $statement = $conn->prepare($query);
        $statement->bindParam(1, $this->id);
        $statement->execute();
        $result = $statement->fetch(PDO::FETCH_ASSOC);
        $this->set_balance($result['BALANCE']);
    }
    public function set_balance($balance) { $this->balance = $balance ; }
    public function get_balance() { return $this->balance; }
}
?>
