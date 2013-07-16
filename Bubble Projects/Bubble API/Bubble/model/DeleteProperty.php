<?php
require_once(PB_LIB.'/Bubble/PremiumBrokers/model/Property.php');
class DeletePropertyHandler extends Property {
    protected $presenter;
    protected $step;
    protected $password   = 'demo';
    protected $cookiename = 'pbcookie';
    protected $form_type;
    public function __construct() {

	/*
         * Check if I'm logged in 
         * Else redirect to login page
         * Save the request path
         */
	if (isset($_SESSION[$this->cookiename]) and $_SESSION[$this->cookiename] > time())  {
	    # Auth Successful
	    $this->presenter = 'DeleteProperty';	    
	} else {
	    $this->presenter = 'Login';
	}

	parent::__construct();
    }
    
    public function __default() {
	$this->prop_type = 'Residential';
	$this->txn_type  = 'Sell';
	$_SESSION['d_txn_type']  = $this->txn_type;
	$_SESSION['d_prop_type'] = $this->prop_type;
    }


    public function show_commercial() {

	$this->prop_type = 'Commercial';
	$_SESSION['d_prop_type'] = $this->prop_type;
	if (isset($_SESSION['d_txn_type'])) {
	    $this->txn_type = $_SESSION['d_txn_type'];
	} else {
	    $this->txn_type = 'Sell';
	    $_SESSION['d_txn_type'] = $this->txn_type;
	}
    }

    public function show_residential() {
	$this->prop_type = 'Residential';
	$_SESSION['d_prop_type'] = $this->prop_type;
	if (isset($_SESSION['d_txn_type'])) {
	    $this->txn_type = $_SESSION['d_txn_type'];
	} else {
	    $this->txn_type = 'Sell';
	    $_SESSION['d_txn_type'] = $this->txn_type;
	}
    }

    public function show_sell() {
	$this->txn_type  = 'Sell';
	$_SESSION['d_txn_type'] = $this->txn_type;
	if (isset($_SESSION['d_prop_type'])) {
	    $this->prop_type = $_SESSION['d_prop_type'];
	} else {
	    $this->prop_type = 'Residential';
	    $_SESSION['d_prop_type'] = $this->prop_type;
	}

    }
    public function show_rent() {
	$this->txn_type  = 'Rent';
	$_SESSION['d_txn_type'] = $this->txn_type;
	if (isset($_SESSION['d_prop_type'])) {
	    $this->prop_type = $_SESSION['d_prop_type'];
	} else {
	    $this->prop_type = 'Residential';
	    $_SESSION['d_prop_type'] = $this->prop_type;
	}

    }
  
    public function get_property_list() {
	if($this->prop_type == 'Residential') {
	    if($this->txn_type == 'Sell') {
	        $list = $this->get_residentials_for_sell(true);
	    } elseif ($this->txn_type == 'Rent') {
		$list = $this->get_residentials_for_rent(true);
	    }
	} elseif($this->prop_type == 'Commercial') {
	    if($this->txn_type == 'Sell') {
		$list = $this->get_commercial_for_sell(true);
	    } elseif ($this->txn_type == 'Rent') {
		$list = $this->get_commercial_for_rent(true);
	    }
	}
	return $list;

    }

    public function delete_property() {
	$prop_type = $_POST['p_category'];
	$txn_type  = $_POST['p_txn_type'];
	$props     = $_POST['property'];

        /* TODO: Could not call method from base class */
	if ($prop_type == 2) {
	    $table_name = 'pb_residential';
	} elseif($prop_type == 1) {
	    $table_name = 'pb_commercial';
	}
	$query = 'DELETE from '.$table_name.' WHERE prop_id in (';
	foreach ($props as $id) {
	    $in_list  .= ($in_list == '') ? $id : ', '.$id;
	}
	$query .= $in_list.')';
	$this->dbconn->delete($query);
	unset($_SESSION['d_prop_type'],$_SESSION['d_txn_type']);
    }
    
    public function get_txn_type()  { return $this->txn_type;  }
    public function get_prop_type() { return $this->prop_type; }
    public function get_presenter_name() { return $this->presenter; }
}

?>