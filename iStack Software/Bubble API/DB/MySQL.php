<?php
class MySQL {
    protected $connection;
    protected $dbhost;
    protected $dbuser;
    protected $dbpass;
    protected $dbname;
    protected $queries;

    public function __construct($dbhost,$dbuser,$dbpass,$dbname, 
				$queries = array()) {
	$this->dbhost = $dbhost;
	$this->dbuser = $dbuser;
	$this->dbpass = $dbpass;
	$this->dbname = $dbname;
	$this->queries = $queries;
    }
    public function connect() {
	$this->connection = mysql_connect($this->dbhost, $this->dbuser, 
					  $this->dbpass);

	mysql_select_db($this->dbname);
    }

    public function add_query($q_name, $query) {
	$this->queries[$q_name] = $query;
    }

    /* RETURN False for fail or array if pass */
    public function execute_query($query) {
	/* Good if we can have prepared statements here */
	$result = array();
	$resultset = mysql_query($query, $this->connection);
	if (! $resultset ) {
	    return false;
	}
	if ( mysql_num_rows($resultset) > 0 ) {
	    while ($row = mysql_fetch_array($resultset, MYSQL_ASSOC)) {
		array_push($result, $row);
	    }
	}
	return $result;
    }

    public function insert($query) {
	/* Good if we can have prepared statements here */
	return mysql_query($query);
    }
    
    public function delete($q_name) {
	/* Good if we can have prepared statements here */
	return mysql_query($q_name);
    }
    
    public function update($q_name) {
	/* Good if we can have prepared statements here */
    }

    public function disconnect() {
	mysql_close($this->connection);
    }
}



?>