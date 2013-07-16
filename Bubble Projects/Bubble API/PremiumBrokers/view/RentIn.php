<?php
require_once(LIB.'/Bubble/HTML/Div.php');
require_once(VIEW.'/HTMLPage.php');
require_once(VIEW.'/RealEstate.php');
require_once(LIB.'/Bubble/HTML/HTMLHead.php');
require_once(LIB.'/Bubble/HTML/HTMLTable.php');
require_once(PB_LIB.'/Bubble/PremiumBrokers/view/RequestPropertyForm.php');
require_once(PB_LIB.'/Bubble/PremiumBrokers/view/NoSideBar.php');
class RentInView extends HTMLPage {
    public function __construct($model) { 

	$index_page  = new RentInBody($model);
	$this->body  = new Body(null, $index_page);

	$this->head  = new HTMLHead();
	$this->head->add_stylesheet("images/bubblepb.css");
	$this->head->add_javascript('images/commonValidate.js');
	$this->head->add_javascript('images/validate.js');
	$this->head->set_title("---Premiun Brokers---");
	parent::__construct();
    }
}

class RentInBody extends NoSideBarView {
    public function __construct($model) {
	$this->main_body = new RentIn($model);
	parent::__construct( array('header' => array('active_menu' => 'Real Estate')), array('id' =>'wrap'));
    }
}


class RentIn extends Div {
    protected $model;
    function __construct($model) {
	$this->model = $model;
	parent::__construct( array('id'=>'main_full' ));

	$form_type    = $this->model->get_prop_type();
	$list         = $this->model->get_property_list();

	$form = new RequestPropertyForm('controller.php?action=RentIn&event=send_mail', 'Fill your details', $list, $form_type,
							array('controller.php?action=RentIn&event=show_commercial',
							      'controller.php?action=RentIn&event=show_residential'));
	$this->add_data($form->get_html_text());    

    }

}

?>