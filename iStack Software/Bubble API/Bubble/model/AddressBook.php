<?php
require_once(PB_LIB.'/Bubble/PremiumBrokers/model/Property.php');

require_once(PB_LIB.'/Bubble/PremiumBrokers/model/Email.php');
class AddressBookHandler extends Property {
    protected $presenter;
    protected $step;
    protected $password = 'demo';
    protected $cookiename = 'pbcookie';
    public function __construct() {

	/*
         * Check if I'm logged in 
         * Else redirect to login page
         * Save the request path
         */
	if (isset($_SESSION[$this->cookiename]) and $_SESSION[$this->cookiename] > time())  {
	    # Auth Successful
	    $this->presenter = 'AddressBook';	    
	} else {
	    $this->presenter = 'Login';
	}
	parent::__construct();
    }
    
    public function __default() {
	
    }

    public function add_contact() {
	$contact = array( 'firstname' => $_POST['firstname'],
			  'lastname'  => $_POST['lastname'],
			  'email'     => $_POST['email'],
			  'phone'     => $_POST['phonem'],
			  'address'   => $_POST['address']
	    );
	$rc      = $this->insert_contact($contact);
	return $rc;
    }

    public function send_mail () {
	$rc = 1;
	$contacts = $_POST['contact'];

	if (count($contacts) > 0) {
	    $contacts = $this->get_contacts_from_ids($contacts);
	    $rc = Email::send_message_to_contacts($contacts, $_POST['message']);
	}
	return $rc;
    }
    
    public function get_presenter_name() {
	return $this->presenter;
    }

    public function delete_contact() {
	$rc = 1;
	$contacts = $_POST['contact'];
	if(count($contacts) > 0) {
	    $this->delete_contacts($contacts);
	}
    }
}

?>