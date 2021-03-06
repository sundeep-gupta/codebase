<?php
require_once(VIEW.'/HTMLPage.php');
require_once(VIEW.'/Template.php');
require_once(LIB.'/Bubble/HTML/Div.php');


class BrokingView extends HTMLPage{
    protected $template_body;
    protected $html_head ;
    protected $body ;
    protected $model;
    public function __construct($model) { 
	$this->model = $model;
	$insurance_page  = new BrokingBody();
	$this->body  = new Body(null, $insurance_page);
	$this->head  = new HTMLHead();
	$this->head->add_stylesheet("images/bubblepb.css");
	$this->head->set_title("---Premiun Brokers---");
	parent::__construct();
    }
    
}

class BrokingBody extends TemplateView {
    public function __construct() {
	$this->main_body = new Broking();
	parent::__construct( array('header' => array('active_menu' => 'Broking')), array('id' =>'wrap'));
    }
} 

class Broking extends Div{
    function __construct($id = 'main') {
	parent::__construct( array('id' => $id));

	$data = '<h1>Financial <span class="green">Services</span> </h1>
  
  <p class="style1">At Premium brokers we offer the following services </p>
<ul>
	<li class="style1">Online BSE &amp; NSE executions (through BOLT AND NEAT 
	Terminal) </li>
	<li class="style1">Access to investment advice &amp; research </li>
	<li class="style1">Personalize advice </li>
	<li class="style1">Live Market info </li>
	<li class="style1">Depository services Demat &amp; Remat transactions. </li>
	<li class="style1">Commodities Trading </li>
	<li class="style1">IPO &amp; Mutual Fund Distribution </li>
	<li class="style1">Technical advice on the mkt and stocks</li>
</ul>
';
	$this->add_data($data);
    }
}

?>
