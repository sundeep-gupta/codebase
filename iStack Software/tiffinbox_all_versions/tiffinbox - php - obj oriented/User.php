<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
require_once 'Connection.php';
/**
 * Description of User
 *
 * @author bubble
 */
class User {
    private $userid;
    private $name;
    private $email;
    private $phone;
    private $street1;
    private $street2;
    private $area;
    private $city;
    private $state;

    //put your code here
    public function  __construct($userid = 0) {
        if($userid > 0) {
            $this->set_userid($userid);
            $this->populate_with_id();
        }
    }
    public function create() {
        // TODO : Write code to create the user.
        $query = "INSERT INTO USER (NAME, EMAIL, PHONE, STREET1, STREET2, AREA, CITY, STATE) ".
                     "VALUES (:name, :email, :phone, :street1, :street2, :area, :city, :state)";
        
        try {
            $conn = Connection::get_connection();
            $conn->beginTransaction();
            $statement = $conn->prepare($query);
            $statement->bindParam(":name", $this->name);
            $statement->bindParam(':email', $this->email);
            $statement->bindParam(':phone', $this->phone);
            $statement->bindParam(':street1', $this->street1);
            $statement->bindParam(':street2', $this->street2);
            $statement->bindParam(':area', $this->area);
            $statement->bindParam(':city', $this->city);
            $statement->bindParam(':state', $this->state);
            $statement->execute();
            $this->populate();
            // ALSO CREATE ACCOUNT WITH ZERO BALANCE
            if($this->userid > 0) {
                $query  = "INSERT INTO ACCOUNT (ID, BALANCE) VALUES(?, 0)";
                $statement = $conn->prepare($query);
                $statement->bindParam(1, $this->userid);
                $statement->execute();
            }
            $conn->commit();
        } catch (PDOException $pdoe) {
            $conn->rollBack();
            throw $pdoe;
        } 
    }
    public function delete() {
        $query = "DELETE USER WHERE USERID = ?";
        try {
            $conn = Connection::get_connection();
            $statement = $conn->prepare($query);
            $statement->bindParam(1, $this->userid);
            $statement->execute();
        } catch (PDOException $pdoe) {
            // For nw just rethrow the exception.
            throw $pdoe;
        }
    }
    public function update() {
        $query = "UPDATE USER SET EMAIL = :email, PHONE = :phone, STREET1 = :street1, STREET2 = :street2, ".
        "AREA = :area, CITY = :city, STATE = :state ".
        "WHERE USERID = :userid";
        try {
            $conn = Connection::get_connection();
            $statement = $conn->prepare($query);
            $statement->bindParam(':email', $this->email);
            $statement->bindParam(':phone', $this->phone);
            $statement->bindParam(':street1', $this->street1);
            $statement->bindParam(':street2', $this->street2);
            $statement->bindParam(':area', $this->area);
            $statement->bindParam(':city', $this->city);
            $statement->bindParam(':state', $this->state);
            $statement->bindParam(':userid', $this->userid);
            $statement->execute();
            $this->populate();
        } catch (PDOException $pdoe) {
            // For now just rethrow.
            throw $pdoe;
        }
    }
    protected function populate() {
        $query = "SELECT USERID, NAME, PHONE, STREET1, STREET2, AREA, CITY, STATE, PASSWORD ".
                 "FROM USER WHERE EMAIL = ?";

        try {
            $conn = Connection::get_connection();
            $statement = $conn->prepare($query);
            $statement->bindParam(1, $this->email);
            $statement->execute();
            if($statement->rowCount() == 1) {
                $result = $statement->fetch(PDO::FETCH_ASSOC);
                $this->set_userid($result['USERID']);
                $this->set_name($result['NAME']);
                $this->set_address( array ($result['STREET1'], $result['STREET2'],
                                $result['AREA'], $result['CITY'], $result['STATE']));
                $this->set_password($result['PASSWORD']);
            }
        } catch (PDOException $pdoe) {
            // For now just rethrow.
            throw $pdoe;
        }
    }
    protected function populate_with_id() {
        $query = "SELECT EMAIL, NAME, PHONE, STREET1, STREET2, AREA, CITY, STATE, PASSWORD ".
                 "FROM USER WHERE USERID = ?";
        try {
            $conn = Connection::get_connection();
            if ($conn == null) {
                throw new BackendException('Failed to get database connection');
            }
            $statement = $conn->prepare($query);
            $statement->bindParam(1, $this->userid);
            $statement->execute();
            if($statement->rowCount() == 1) {
                $result = $statement->fetch(PDO::FETCH_ASSOC);
                $this->set_email($result['EMAIL']);
                $this->set_name($result['NAME']);
                $this->set_address( array ($result['STREET1'], $result['STREET2'],
                                $result['AREA'], $result['CITY'], $result['STATE']));
                $this->set_password($result['PASSWORD']);
            }
        } catch (PDOException $pdoe) {
            throw $pdoe;
        }
    }
    public function exists() {
        $this->populate();
        if ($this->userid > 0) {
            return true;
        }
        return false;
    }

    public function get_userid() { return $this->userid; }
    public function get_name() { return $this->name; }
    public function get_email() { return $this->email; }
    public function get_phone() { return $this->phone; }
    public function get_address() {
        return array($this->street1, $this->street2, $this->area, $this->city, $this->state);
    }
    public function get_area() { return $this->area; }
    public function get_city() { return $this->city; }

    public function set_userid($userid) { $this->userid = $userid; }
    public function set_name($name) { $this->name = $name; }
    public function set_email($email) { $this->email = $email; }
    public function set_phone($phone) { $this->phone = $phone; }
    public function set_password($password) {$this->password = $password;}
    public function set_address($address) {
        $this->street1 = $address[0];
        $this->street2 = $address[1];
        $this->area = $address[2];
        $this->city = $address[3];
        $this->state = $address[4];
    }
}
?>
