<?php
/**
 *  A simple class for querying MySQL
 */
class DataAccess {

    // single instance of self shared among all instances
    private static $instance = null;
    // db connection config vars
    private $user = "phpuser";
    private $pass = "!phpuser";
    private $dbName = "weblogHOL";
    private $dbHost = "localhost";
    private $con = null;
    private $query; // Query resource

    // private constructor
    private function __construct() {
        $this->con = mysql_connect($this->dbHost, $this->user, $this->pass)
            or die ("Could not connect to db: " . mysql_error());
        mysql_select_db($this->dbName, $this->con)
            or die ("Could not select db: " . mysql_error());
    }

    //This method must be static, and must return an instance of the object if the object
    //does not already exist.
    public static function getInstance() {
        if (!self::$instance instanceof self) {
            self::$instance = new self;
        }
        return self::$instance;
    }

    // The clone and wakeup methods prevents external instantiation of copies of the Singleton class,
    // thus eliminating the possibility of duplicate objects.
    public function __clone() {
        trigger_error('Clone is not allowed.', E_USER_ERROR);
    }
    public function __wakeup() {
        trigger_error('Deserializing is not allowed.', E_USER_ERROR);
    }
    
    //! An accessor
    /**
    * Fetches a query resources and stores it in a local member
    * @param $sql string the database query to run
    * @return void
    */
    function fetch($sql) {
        return(mysql_query($sql,$this->con)); // Perform query here
    }

    //! An accessor
    /**
    * Returns an associative array of a query row
    * @return mixed
    */
    function getRow ($query) {
        if ( $row=mysql_fetch_array($query,MYSQL_ASSOC) )
        return $row;
        else
        return false;
    }
}
?>