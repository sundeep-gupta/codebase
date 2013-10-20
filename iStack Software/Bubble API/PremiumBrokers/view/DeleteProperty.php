<?
require_once(LIB.'/Bubble/HTML/Div.php');
require_once(VIEW.'/HTMLPage.php');
require_once(VIEW.'/RealEstate.php');
require_once(LIB.'/Bubble/HTML/HTMLHead.php');
require_once(LIB.'/Bubble/HTML/HTMLTable.php');
require_once(PB_LIB.'/Bubble/PremiumBrokers/view/DeletePropertyForm.php');
require_once(PB_LIB.'/Bubble/PremiumBrokers/view/NoSideBar.php');

class DeletePropertyView extends HTMLPage {
    public function __construct($model) { 

	$index_page  = new DeletePropertyBody($model);
	$this->body  = new Body(null, $index_page);

	$this->head  = new HTMLHead();
	$this->head->add_stylesheet("images/bubblepb.css");
	$this->head->add_javascript("images/commonValidate.js");
	$this->head->add_javascript("images/validate.js");
	$this->head->set_title("---Premiun Brokers---");
	parent::__construct();
    }
}

class DeletePropertyBody extends NoSideBarView {
    public function __construct($model) {
	$this->main_body = new DeleteProperty($model);
#	$this->right_menu = new RealEstateMenu();
	parent::__construct( array('header' => array('active_menu' => 'Home')), array('id' =>'wrap'));
    }
}


class DeleteProperty extends Div {
    protected $model;
    function __construct($model) {
	$this->model = $model;
	parent::__construct( array('id'=>'main_full' ));

	$form_type = $this->model->get_prop_type();
	$txn_type  = $this->model->get_txn_type(); 
	$list      = $this->model->get_property_list();

	$form = new DeletePropertyForm('controller.php?action=DeleteProperty&event=delete_property', 'Delete Property', 
				       $list, $txn_type, $form_type);
	$this->add_data($form->get_html_text());    
    }

}

?>