<?php
require_once(LIB.'/Bubble/DB/MySQLi.php');
class DatabaseHandler {
    protected $step;
    protected $dbconn;
    protected $queries;
    public function __construct() {
	$this->dbconn    = new BBMySQL(DB_HOST, DB_USER, DB_PASS, DB_NAME);
	$this->queries = array( 'Q_CATS_MAIN' => 'SELECT cat_name, cat_id FROM std_categories '.
											 'WHERE parent_id=0 ORDER BY cat_name ASC',
							'Q_USER_EXIST' => 'SELECT user_name FROM std_temp_users WHERE user_name = ? OR email = ?',				 
	    );
    }

	public function get_cats_main() {
	    $result = $this->dbconn->execute_query($this->queries['Q_CATS_MAIN']);
		return $result;
	} 

	public function user_exists($user, $email) {
		$result = $this->dbconn->prepared_query($this->queries['Q_USER_EXIST'],
			array('type' => 'ss',
				  'values' => array($user, $email)
				));
		if(count($result) > 0) {
			return false;
		}
		return true;
	}

	public function insert_new_user() {
	$query = "INSERT INTO std_temp_users(user_name, password, email, sign_up_date, prelim_rand) VALUES('$new_user_name', '$password1', '$email', ".time().", '$the_rand')";

	}

	public function __destruct() {
		$this->dbconn = NULL;
	}

}	


?>
