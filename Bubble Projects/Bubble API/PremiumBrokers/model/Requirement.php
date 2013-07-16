<?php
require_once(PB_LIB.'/Bubble/PremiumBrokers/model/Property.php');
require_once(PB_LIB.'/Bubble/PremiumBrokers/model/Email.php');
require_once(PB_LIB.'/Bubble/PremiumBrokers/model/Session.php');

class RequirementHandler extends Property {
    protected $presenter;
    protected $step;
    protected $form_type;

    public function __construct() {
	$this->presenter = 'Requirement';
	parent::__construct();
    }
    
    public function __default() {
	$this->step = 1;
    }

    public function property_form() {
	Session::set_contact();
	$this->property_form_residential();
    }

    public function property_form_residential() {
	$this->step = 2;
	$this->form_type = 'Residential';
    }

    public function property_form_commercial() {
	$this->step = 2;
	$this->form_type = 'Commercial';
    }

    public function send() {
	$category   = $_POST['p_category'];
	$contact_id = $this->insert_contact($_SESSION);
	$contact    = $this->get_contact_from_id($contact_id);

	/* SEND only E-Mail */
	if ($category == '2') {
	    $row = $this->read_residential_form();
	    $row = $this->get_descriptive_residential( $row);
	} elseif ($category == '1') {
	    $row = $this->read_commercial_form();
	    $row = $this->get_descriptive_residential( $row);
	}
	/* Send E-Mail to PB */
	Email::property_required($row, $contact);
	Session::unset_contact();
	$_SESSION['db_message'] = "Your requirements has been successfully sent. We will contact you soon.";
	header("Location: controller.php?action=RealEstate");
    }
    
    public function get_form_type()      { return $this->form_type; }
    public function get_presenter_name() { return $this->presenter; }
    public function get_step()           { return $this->step; }
  
}

?>