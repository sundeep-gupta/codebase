<?php
require_once(VIEW.'/HTMLPage.php');
require_once(VIEW.'/Template.php');
require_once(LIB.'/Bubble/HTML/Div.php');


class RealEstateView extends HTMLPage{
    protected $template_body;
    protected $html_head ;
    protected $body ;
    protected $model;
    public function __construct($model) { 
	$this->model = $model;
	$insurance_page  = new RealEstateBody();
	$this->body  = new Body(null, $insurance_page);
	$this->head  = new HTMLHead();
	$this->head->add_stylesheet("images/bubblepb.css");
	$this->head->set_title("---Premiun Brokers---");
	parent::__construct();
    }
    
}

class RealEstateBody extends TemplateView {
    public function __construct() {
	if ($this->main_body == null) {
	    $this->main_body = new RealEstate();
	}
	if ($this->left_menu == null) {
	    $this->left_menu = new RealEstateMenu();
	}
	parent::__construct( array('id' =>'wrap'));
    }
}

class RealEstate extends Div{
    function __construct($id = 'main') {
	parent::__construct( array('id' => $id));
	$data  = '<img border="0" src="images/UnderConstruction.bmp" width="435" height="356">';
	$this->add_data($data);
    }
}

class RealEstateMenu extends Div{
    public function __construct($id = 'sidebar') {
	parent::__construct( array('id'=>$id));
	$data = '<ul class="sidemenu">
				<li><a href="controller.php?action=Buy">Buy Property</a></li>
				<li><a href="controller.php?action=Sell">Sell Property</a></li>
				<li><a href="controller.php?action=RentIn">Rent / Lease In</a></li>
				<li><a href="controller.php?action=RentOut">Rent / Lease Out</a></li>
				<li><a href="controller.php?action=Requirement">My Requirements</a></li>
						
			</ul>		
			<h1>Wise Words</h1>
			<p>"Men are disturbed, not by the things that happen,
			but by their opinion of the things that happen."</p> 
			<p class="align-right">- Epictetus</p>';
	$this->add_data($data);
    }
}

?>