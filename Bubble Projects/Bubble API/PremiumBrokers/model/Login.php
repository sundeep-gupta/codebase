<?php
class LoginHandler {
    protected $presenter;
    protected $step;
    protected $password   = ADMIN_PASS;
    protected $cookiename = 'pbcookie';
    protected $expirytime ;

    public function __construct() {

	/*
         * Check if Password is correct
         * Else redirect to login page
         * Save the request path
         */
	$this->expirytime = time() + 3600;
	$this->presenter = 'Login';
    }
    
    public function __default() {

    }
    
    public function Authenticate() {
	
	if (isset($_POST['sub'])) {			
	    $submitted_pass=md5($_POST['password']);	
	    if ($submitted_pass <> md5($this->password) ){	
		# Show err msg for incorrect psswd
		$this->presenter = 'Login';
		$this->root_presenter = $_POST['presenter'];
	    } else {		
		$_SESSION[$this->cookiename] = $this->expirytime;
		header('Location: '.$_POST['presenter']);
	    }
	} else {
	    $this->presenter = 'Login';
	}

    }

    public function get_presenter_name() {
	return $this->presenter;
    }
}







?>