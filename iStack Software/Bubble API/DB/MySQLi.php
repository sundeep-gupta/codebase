<?php
class MySQLi {
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
		$this->connection = new mysqli($this->dbhost, $this->dbuser, 
								  $this->dbpass,$this->dbname);
		if(mysqli_connect_errno()) {
			echo 'Connection Failed';
		}
								  
		$this->queries = $queries;
    }

    public function add_query($q_name, $query) {
		$this->queries[$q_name] = $query;
    }

    /* RETURN False for fail or array if pass */
    public function execute_query($query) {
		/* Good if we can have prepared statements here */
		$result = array();
		$resultset = $this->connection->query($query);
		if (! $resultset ) {
		    return false;
		}
		if ( $resultset->num_rows > 0 ) {
		    while ($row = $resultset->fetch_assoc()) {
				array_push($result, $row);
		    }	
		}
		return $result;
	}	

	public function prepared_query($query, $bind_params) {
		$statement = $this->connection->prepare($query);
		$statement->bind_param($bind_params['type'], $bind_params['values']);
		$resultset = $statement->execute();
		
		if (! $resultset ) {
		    return false;
		}

		$result = array();
		if ( $resultset->num_rows > 0 ) {
		    while ($row = $resultset->fetch_assoc()) {
				array_push($result, $row);
		    }	
		}
		return $result;

	}

    public function insert($query) {
		/* Good if we can have prepared statements here */
		return $this->connection->query($query);
    }
    
    public function delete($q_name) {
	/* Good if we can have prepared statements here */
		return $this->connection->query($query);
    }
    
    public function update($q_name) {
	/* Good if we can have prepared statements here */
		return $this->connection->query($query);
	}

    public function __destruct() {
		$this->connection->close();
    }
}



?>
