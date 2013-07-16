<?php

require (LIB.'/Bubble/DB/Database.php');
require (LIB.'/Bubble/Advertise/modules/User.php');

class IndexHandler {
    
    protected $presenter;
    protected $dbConn;

    function __construct() {

	$this->dbConn = new Database($dbHost, $dbUser, $dbPass, $dbName);      
	$this->presenter = 'IndexView';
    }
    
    function __default() {
	
	#
	# 1. Get the uid from session 
        # 2. Validate the user (its session)
	# 
	#
	
	if (isset($_SESSION['uid'])) {
	    $user = $_SESSION['uid'];
	} else {
	    $user = '';
	}
	$user = new User($userName);
#	$user->authenticate($password);

	#
	# Now run the basic query to get the Left hand menu
	# 
	$query = 'SELECT cat_name, cat_id  FROM std_categories WHERE parent_id=0 ORDER BY cat_name ASC' ;
	$this->dbConn->add_query('BB_AD_GET_CAT_LIST',$query);

	#
	# Returns a POJO Array as result set... TODO: Design your framework to do so.
	#
	$result = $this->dbConn->execute('BB_AD_GET_CAT_LIST',null);

	if (cnfg('show_num_items')) {
	    foreach ($result as $category) {
		# 
		# Execute the query to get the list of ads in that category
		#
		$query = 'SELECT ...';
		$this->dbConn->add_query('BB_GET_CAT_AD_COUNT',$query);
		$num_count = $this->dbConn->execute_single_row_query('BB_GET_CAT_AD_COUNT');
		$category->set_ad_count($num_count);
	    }
	}
	
	#
	# Return the $result as a array of POJO objects
	#
	return $result;
    }

    public function getPresenterName() {
	return $this->presenter;
    }

} 


?>