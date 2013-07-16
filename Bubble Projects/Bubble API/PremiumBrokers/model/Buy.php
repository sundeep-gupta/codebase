<?php
require_once(PB_LIB.'/Bubble/PremiumBrokers/model/Property.php');
class BuyHandler extends Property{
    protected $presenter ;
    protected $prop_type;
    public function __construct() {
	$this->presenter = 'Buy';
	parent::__construct();
    }

    public function __default() {
	$this->show_residential();
    }

    public function show_commercial() {
	$this->prop_type = 'Commercial';
	$_SESSION['b_prop_type'] = $this->prop_type;
    }

    public function show_residential() {
	$this->prop_type = 'Residential';
	$_SESSION['b_prop_type'] = $this->prop_type;
    }

    
    public function get_presenter_name() {
	return $this->presenter;
    }

    public function get_prop_type() {
	return $this->prop_type;
    }
  
    public function get_property_list() {
	if($this->prop_type == 'Residential') {
	    $list = $this->get_residentials_for_sell();
	} elseif($this->prop_type == 'Commercial') {
	    $list = $this->get_commercial_for_sell();
	}
	return $list;
    }
    public function send_mail () {
	/* Write code to send email */
	$this->prop_type = $_SESSION['b_prop_type'];
	/* Insert the user into the records */
	$contact = array ('firstname' => $_POST['firstname'],
			  'lastname' => $_POST['lastname'],
			  'email'    => $_POST['email'],
			  'phone'    => $_POST['phonem'],
			  'address'  => $_POST['address'],
			  );
	$contact_id = $this->insert_contact($contact);
	/* Write code to send email */
	$props = $_POST['property'];
	if (count($props) > 0) {
	    $properties = $this->get_properties_from_id($props,$_POST['p_catagory']);
	    $rc = Email::buy($properties,$contact);

	    if( ! $rc) {
		$_SESSION['db_message'] = 'Unable to email your details due to technical problems';
	    } else {
		$_SESSION['db_message'] = 'Your details has been successfully mailed. We will get back to you soon.';
	    }

	}       
	unset($_SESSION['b_prop_type']);

	header("Location: controller.php?action=RealEstate");

    }
}

?>