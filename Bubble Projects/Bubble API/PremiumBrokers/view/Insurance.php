<?php
require_once(VIEW.'/HTMLPage.php');
require_once(VIEW.'/Template.php');
require_once(LIB.'/Bubble/HTML/Div.php');


class InsuranceView extends HTMLPage{
    protected $template_body;
    protected $html_head ;
    protected $body ;
    protected $model;
    public function __construct($model) { 
	$this->model = $model;
	$insurance_page  = new InsuranceBody();
	$this->body  = new Body(null, $insurance_page);
	$this->head  = new HTMLHead();
	$this->head->add_stylesheet("images/bubblepb.css");
	$this->head->set_title("---Premiun Brokers---");
	parent::__construct();
    }
    
}

class InsuranceBody extends TemplateView {
    public function __construct() {
	$this->main_body = new Insurance();
	parent::__construct( array('header' => array('active_menu' => 'Insurance')), array('id' =>'wrap')); 
    }
}

class Insurance extends Div{
    function __construct($id = 'main') {
	parent::__construct( array('id' => $id));
	$data  = '<h1>Insurance services</h1>
  <p class="style1" text-align: justify; background: white">
<strong>We have tied up with 
Priority Circle Prudential ICICI, LIC, HDFC and Kotak for General and Life Insurance.</p>
<p class="style1" >We offer following services:
</p>
<ul>
	<li>
	<p class="style1" text-align: justify; background: white">
	Study and analyze the risk exposure and recommend insurance cover</p>	
	</li>
	
	<li>
	<p class="style1" text-align: justify; background: white">
	Review current policies and offer recommendations for changing the terms of insurance cover to suit client\'s exposure / requirements </p>	
	</li>

	<li>
	<p class="style1" text-align: justify; background: white">Ensure timely payment of 
the premiums and timely renewals </p>
	</li>
	<li>
	<p class="style1" text-align: justify; background: white">Maintain records of the Clients\' 
insurance portfolio and review the same from time to time </p>
	</li>
	<li>
	<p class="style1" text-align: justify; background: white">In the event of 
claims, provide assistance in presentation and follow-up of claims</p>
	</li>
</ul>
';
	$this->add_data($data);
    }
}

?>