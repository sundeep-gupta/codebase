<?php
# Load PEAR::DB module

require_once("DB.php");

class Database {
    protected $connect_str;
    protected $connection;
    protected $queries;
    /*
     * Constructor method
     */
    function __construct($connect_str) {       
	$this->connect_str = $connect_str;
	$this->connection  = &DB::connect($connect_str);
	if (DB::isError($this->connection)) {
	    /*Throw Exception here to be handled by user */
	    // $conn->getMessage();
	}	
#        load_queries();
    }
    /*
     * method to maintain a list of queries.
     */
    function add_query($query_name,$query) {
	if (!isset($this->queries[$query_name])) {
	    $this->queries[$query_name] = $query;
	}
    }

    function execute($query_name, $params) {
	# Run the query 	
	if ($this->queries[$query_name]) {
#	    echo $this->queries[$query_name];
	    $result =  $this->connection->query($this->queries[$query_name]);
	    if (DB::isError($result)) {
		/* Throw exception here */
		// $result->getMessage();
	       
	    } else {
#		echo 'result success';
#		echo $result->numRows();
		return $result;
	    }
	}
    }
    function  load_queries() {
	$this->queries = (
	                  ''
	                  );
	return;
    }
}
?>