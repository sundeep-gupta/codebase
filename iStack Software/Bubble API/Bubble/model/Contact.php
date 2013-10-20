<?php
require_once(PB_LIB.'/Bubble/PremiumBrokers/model/Email.php');
require_once(PB_LIB.'/Bubble/PremiumBrokers/model/Property.php');

class ContactHandler extends Property{
    protected $presenter;
    protected $step;
    public function __construct() {
	$this->presenter = 'Contact';
	parent::__construct();
    }
    
    public function __default() {
    }

    public function get_presenter_name() {
	return $this->presenter;
    }
    public function submit() {
	
	EMail::contact_us($_POST['firstname'], $_POST['email'], 
			  $_POST['phonem'], $_POST['phonel'], $_POST['subject'], $_POST['message']);

	$contact = array ('firstname' => $_POST['firstname'],
			  'lastname' => $_POST['lastname'],
			  'email' => $_POST['email'],
			  'phone' => $_POST['phonem'],
			  );
	$this->insert_contact($contact);

    }
}







?>