<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
require_once('Connection.php');
/**
 * Description of Cuisine
 *
 * @author bubble
 */
class Cuisine {
    private $name;
    private $price;
    private $id;
    private $desc;
    //put your code here
    public function  __construct() {

    }
    public function create() {
        // TODO write code to create the cuisine.
        $conn = Connection::get_connection();
        if ($conn == null) {
            throw new BackendException('Failed to get database connection');
        }

        $query = "INSERT INTO CUISINE (NAME, DESCRIPTION, PRICE) VALUES (:name, :description, :price)";
        $statement = $conn->prepare($query);
        $statement->bindParam(':name', $this->name);
        $statement->bindParam(':description', $this->desc);
        $statement->bindParam(':price', $this->price);
        $statement->execute();
        $this->populate();
    }
    public function populate() {
        $conn = Connection::get_connection();
        if ($conn == null) {
            throw new BackendException('Failed to get database connection');
        }

        $query = "SELECT ID, DESCRIPTION, PRICE FROM CUISINE WHERE NAME = ?";

        $statement = $conn->prepare($query);
        $statement->bindParam(1, $this->name);
        $statement->execute();
        if ($statement->rowCount() == 1) {
            $result = $statement->fetch(PDO::FETCH_ASSOC);
            $this->set_desc($result['DESCRIPTION']);
            $this->set_price($result['PRICE']);
            $this->set_id($result['ID']);
        }
        return false;
    }
    public function exists() {
        // TODO Handle the case where $name is not set.
        $this->populate();
        if($this->id > 0)  {
            return true;
        }
        return false;

    }
    public function delete() {
        // TODO : write code to delete the record.
        $conn = Connection::get_connection();
        if ($conn == null) {
            throw new BackendException('Failed to get database connection');
        }

        $query = "DELETE FROM CUISINE WHERE NAME = ?";
        $statement = $conn->prepare($query);
        $statement->bindParam(1, $this->name);
        $statement->execute();
    }
    public function get_id() { return $this->id; }
    public function get_name() { return $this->name; }
    public function get_price() { return $this->price; }
    public function set_id($id) {$this->id = $id; }
    public function set_name($name) { $this->name = $name; }
    public function set_price($price) { $this->price = $price; }
    public function set_desc($desc) { $this->desc = $desc; }
    public function get_desc() { return $this->desc;}
}
?>
