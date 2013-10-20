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
	$data  = '<h1>Insurance services by <span class="green">Premium Brokers</span></h1>
  <p class="MsoNormal" style="MARGIN: 0in 0in 0pt">Premium Brokers has tied up with 
Priority Circle Prudential ICICI for General &amp; Life Insurance</p>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt"></p>
<p class="MsoNormal" style="MARGIN: 0in 0in 0pt">We offer following 
services,

Study and analyze the risk exposure and recommend insurance cover  Review 
current policies and offer recommendations for changing the terms of insurance 
cover to suit client\'s exposure / requirements <br>- Ensure timely payment of 
the premiums and timely renewals <br>- Maintain records of the Clients\' 
insurance portfolio and review the same from time to time <br>- In the event of 
claims, provide assistance in presentation and follow-up of claims</p>';
	$this->add_data($data);
    }
}

?>