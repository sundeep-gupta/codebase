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
	if ($this->right_menu == null) {
	    $this->right_menu = new RealEstateMenu();
	}
	parent::__construct( array('header' => array('active_menu' => 'Real Estate')), array('id' =>'wrap'));
    }
}

class RealEstate extends Div{
    function __construct($id = 'main') {
	parent::__construct( array('id' => $id));
	
	$data = '
<h1>Real <span class="green">Estate</span> </h1>


<p class="style1">We serve as a one-stop shop for those looking to own, occupy, 
invest, lease or sell property. We cater to a wide array of real estate needs 
across all segments in the real estate industry. <br />
<br />
Services Offered:</p>
<ul>
	<li class="style1">Brokerage Services</li>
	<li class="style1">Advice on investments in property, with lucrative, fixed 
	and safe returns</li>
	<li class="style1">Investment consultancy</li>
	<li class="style1">Property Portfolio Management Services</li>
	<li class="style1">Commercial Property Management</li>
	<li class="style1">Residential Property Management</li>
	<li class="style1">Property maintenance</li>
	<li class="style1">Tenancy management</li>
	<li class="style1">Lease negotiations and approval</li>
	<li class="style1">Disposition strategies / sale administration</li>
	<li class="style1">Legal advisory services on real estate transactions<BR>
	</li>
</ul>


					';
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
		';  
	$this->add_data($data);
    }
}

?>
