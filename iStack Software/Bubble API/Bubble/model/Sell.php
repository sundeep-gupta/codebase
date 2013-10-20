<?php
require_once(PB_LIB.'/Bubble/PremiumBrokers/model/Property.php');
require_once(PB_LIB.'/Bubble/PremiumBrokers/model/Email.php');
require_once(PB_LIB.'/Bubble/PremiumBrokers/model/Session.php');

class SellHandler extends Property {
    protected $presenter;
    protected $step;
    protected $form_type;

    public function __construct() {
	$this->presenter = 'Sell';
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

    public function submit_sell_info() {
	$category = $_POST['p_category'];

	if ($category == '2') {
    
	    $contact_id      = $this->insert_contact($_SESSION);
	    $row             = $this->read_residential_form();
	    $row['contact']  = $contact_id;
	    $row['txn_type'] = $this->get_transaction_id('Sell');;
	    $result          = $this->insert_residential_details($row); 
	    $contact         = $this->get_contact_from_id($row['contact']);
	    $row             = $this->get_descriptive_residential( $row);
	} elseif ($category == '1') {

	    $contact_id      = $this->insert_contact($_SESSION);
	    $row             = $this->read_commercial_form();
	    $row['contact']  = $contact_id;
	    $row['txn_type'] = $this->get_transaction_id('Sell');;
	    $result          = $this->insert_commercial_details($row);
	    $contact         = $this->get_contact_from_id($row['contact']);
	    $row             = $this->get_descriptive_residential($row);
	}

	if( ! $result) {
	    $_SESSION['db_message'] = 'Unable to save your details due to technical problems';
	} else {
	    $_SESSION['db_message'] = 'Your details has been successfully saved.';
	}

	/* Send E-Mail to PB */
	Email::property_added_for_sell($row, $contact);
	Session::unset_contact();
	header("Location: controller.php?action=RealEstate");

    }
    
    public function get_form_type() {
	return $this->form_type;
    }

    public function get_presenter_name() {
	return $this->presenter;
    }

    public function get_step() {
	return $this->step;
    }
  
}

?>