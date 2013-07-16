<?php
require_once(VIEW.'/HTMLPage.php');
require_once(VIEW.'/RealEstate.php');
require_once(LIB.'/Bubble/HTML/Div.php');
require_once(PB_LIB.'/Bubble/PremiumBrokers/view/AddressBookForm.php');
require_once(PB_LIB.'/Bubble/PremiumBrokers/view/CommercialPropertyForm.php');
require_once(PB_LIB.'/Bubble/PremiumBrokers/view/ResidentialPropertyForm.php');
class SellView extends HTMLPage {
    public function __construct($model) { 
	$index_page  = new SellBody($model);
	$this->body  = new Body(null, $index_page);
	$this->head  = new HTMLHead();
	$this->head->add_stylesheet("images/bubblepb.css");
	$this->head->add_javascript("images/commonValidate.js");
	$this->head->add_javascript("images/validate.js");
	$this->head->set_title("---Premiun Brokers---");
	parent::__construct();
    }
}

class SellBody extends RealEstateBody {
    public function __construct($model) {
	$this->main_body = new Sell($model);
	parent::__construct( array('id' =>'wrap'));
    }
}




class Sell extends Div{
    protected $model;
    function __construct($model) {
	parent::__construct( array('id'=> 'main'));

	$this->model = $model;
	$step = $this->model->get_step();
	$data = '';
	if ($step == 1) {
	    $form = new AddressBookForm('controller.php?action=Sell&event=property_form', 'Sell Property (Step 1 of 2)');
	    $data .= $form->get_html_text();
	} elseif ($step == 2) {
	    $form_type = $this->model->get_form_type();
	    if ($form_type == 'Commercial') {
		$type     = $this->model->get_property_type($form_type);
		$internet = $this->model->get_internet($form_type);
		$lift     = $this->model->get_lift();
		$form     = new CommercialPropertyForm('controller.php?action=Sell&event=submit_sell_info',
						       'Sell Property (Step 2 of 2)', $type,$internet, $lift,
							array('controller.php?action=Sell&event=property_form_commercial',
							      'controller.php?action=Sell&event=property_form_residential'));

	    } elseif($form_type == 'Residential') {
		$type      = $this->model->get_property_type($form_type);
		$status    = $this->model->get_status();
		$furnished = $this->model->get_furnished();
		$lift      = $this->model->get_lift();
		$form     = new ResidentialPropertyForm('controller.php?action=Sell&event=submit_sell_info',
							'Sell Property (Step 2 of 2)', $type,$status, $furnished, $lift,
							array('controller.php?action=Sell&event=property_form_commercial',
							      'controller.php?action=Sell&event=property_form_residential'));
	    }
	    $data    .= $form->get_html_text();
	} elseif ($step == 3) {
	    $data = '<p>'.$_SESSION['firstname'].' Your form submitted successfully </p>';
	} 
	
	$this->add_data($data);    
    }
}
?>