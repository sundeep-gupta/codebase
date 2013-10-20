<?php
require_once(VIEW.'/HTMLPage.php');
require_once(VIEW.'/Template.php');
require_once(LIB.'/Bubble/HTML/Div.php');


class AdvisoryView extends HTMLPage{
    protected $template_body;
    protected $html_head ;
    protected $body ;
    protected $model;
    public function __construct($model) { 
	$this->model = $model;
	$insurance_page  = new AdvisoryBody();
	$this->body  = new Body(null, $insurance_page);
	$this->head  = new HTMLHead();
	$this->head->add_stylesheet("images/bubblepb.css");
	$this->head->set_title("---Premiun Brokers---");
	parent::__construct();
    }
    
}

class AdvisoryBody extends TemplateView {
    public function __construct() {
	$this->main_body = new Advisory();
	parent::__construct( array('header' => array('active_menu' => 'Advisory')), array('id' =>'wrap'));
    }
} 

class Advisory extends Div{
    function __construct($id = 'main') {
	parent::__construct( array('id' => $id));
	$data  = '

<h1>Advisory</h1>
<p class="style1" text-align: justify; background: white">
<strong>To derive optimum returns from equity as an asset class 
requires professional guidance &amp; advice. Our bottoms up investment approach for 
medium to long term tenure helps us balance the volatility and maximize returns.</p>
<p class="style1">Features: </p>
<ul>
	<li class="style1">A premium service for clients who need professional 
	guidance on long term investments </li>
	<li class="style1">Proper risk profiling will be done before investing 
	decision are made</li>
	<li class="style1">Regular update of your portfolio</li>
	<li class="style1">Quarterly review of the portfolio </li>
</ul>
	';
	$this->add_data($data);
    }
}

?>
