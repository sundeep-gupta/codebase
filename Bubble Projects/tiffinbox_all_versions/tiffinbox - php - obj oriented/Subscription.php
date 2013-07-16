<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
require_once 'Connection.php';

/**
 * Description of Subscription
 *
 * @author bubble
 */
class Subscription {
    //put your code here
    private $id;
    private $userid;
    private $cuisineid;
    private $active;
    private $start_date;
    private $end_date;

    public function  __construct($id = 0) {
        if($id > 0) {
            $this->set_id($id);
            $this->populate_with_id();
        }

    }

    public function get_id() { return $this->id; }
    public function get_userid() {return $this->userid; }
    public function get_cuisineid() { return $this->cuisineid; }
    public function get_start_date() { return $this->start_date; }
    public function get_end_date() { return $this->end_date; }
    public function get_active() { return $this->active;}
    public function set_end_date($end_date) { $this->end_date = $end_date; }
    public function set_start_date($start_date){$this->start_date=$start_date;}
    public function set_cuisineid($cuisineid) { $this->cuisineid = $cuisineid; }
    public function set_userid($userid) { $this->userid = $userid; }
    public function set_id($id) { $this->id = $id;}
    public function set_active($active) { $this->active = $active;}

    public function populate_with_id() {
        $query = "SELECT USERID, CUISINEID, ACTIVE, START_DATE, END_DATE FROM SUBSCRIPTION WHERE ID = ?";
        $conn = Connection::get_connection();
        $statement = $conn->prepare($query);
        $statement->bindParam(1, $this->id);
        $statement->execute();
        $result = $statement->fetch(PDO::FETCH_ASSOC);
        $this->set_userid($result['USERID']);
        $this->set_cuisineid($result['CUISINEID']);
        $this->set_active($result['ACTIVE']);
        $this->set_start_date($result['START_DATE']);
        $this->set_end_date($result['END_DATE']);
    }
    public function create() {
        // TODO : Validate the values before inserting.
        $query = "INSERT INTO SUBSCRIPTION(USERID, CUISINEID, ACTIVE, START_DATE, END_DATE) ".
        "VALUES(:userid, :cuisineid, 1, :start_date, :end_date)";
        $conn = Connection::get_connection();
        $statement = $conn->prepare($query);
        $statement->bindParam(':userid', $this->userid);
        $statement->bindParam(':cuisineid', $this->cuisineid);
        $statement->bindParam(':start_date', $this->start_date);
        $statement->bindParam(':end_date', $this->end_date);
        $statement->execute();
        echo $query . $this->userid . $this->cuisineid . $this->start_date . $this->end_date;
        // TODO: some way to populate without knowing the id.
        // Maybe we donot need this at all.
      //  $this->populate();
    }
    protected function update() {
        $query = "UPDATE SUBSCRIPTION SET END_DATE = :end_date, ACTIVE = :active WHERE ID = :id";
                $conn = Connection::get_connection();
        $statement = $conn->prepare($query);
        $statement->bindParam(':end_date', $this->end_date);
        $statement->bindParam(':active', $this->active);
        $statement->bindParam(':id', $this->id);
        $statement->execute();
       // $this->populate();
    }
    // NOTE: We do not allow deletion of subscriptions.
    public function delete() {
    }
    public function deactivate($end_date = '2010-04-25') {
        $this->set_end_date($end_date);
        $this->set_active(0);
        $this->update();
    }
}
?>
