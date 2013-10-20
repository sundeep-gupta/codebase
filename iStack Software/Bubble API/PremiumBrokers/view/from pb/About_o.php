<?php
require_once(VIEW.'/HTMLPage.php');
require_once(VIEW.'/Template.php');
require_once(LIB.'/Bubble/HTML/Div.php');


class AboutView extends HTMLPage{
    protected $template_body;
    protected $html_head ;
    protected $body ;
    protected $model;
    public function __construct($model) { 
	$this->model = $model;
	$insurance_page  = new AboutBody();
	$this->body  = new Body(null, $insurance_page);
	$this->head  = new HTMLHead();
	$this->head->add_stylesheet("images/bubblepb.css");
	$this->head->set_title("---Premiun Brokers---");
	parent::__construct();
    }
    
}

class AboutBody extends TemplateView {
    public function __construct() {
	$this->main_body = new About();
	parent::__construct( array('header' => array('active_menu' => 'About')), array('id' =>'wrap')); 
    }
}

class About extends Div{
    function __construct($id = 'main') {
	parent::__construct( array('id' => $id));
	$data  = '<img border="0" src="images/UnderConstruction.bmp" width="435" height="356">';
	$data = '<h1>About <span class="green">Premium Brokers</span></h1>
			
			  <p><font face="Palatino Linotype" size="2">Established in Feb 
2006 by a group of Finance experts, Premium Brokers is a diversified financial 
services firm. Service offered include Share broking, Investment consulting, 
Real Estates, Training and allied services. <br><br></font><font face="Palatino Linotype" size="2">The strengths of Premium Brokers 
are,<br><br><strong>Core Competency</strong> - Customized services and 
investment advice to achieve your financial 
objectives.<br><br><strong>Infrastructure</strong> - Strategically located 
office with state of the art facilities required for stock trading, training and 
other services.  Special HNI desks for 
trading.<br><br><strong>Alliances</strong> - Alliance with major vendors to 
provide state of art backbone for trading &amp; Insurance 
services <br><br>The core team consists of experts in Finance domain with 
rich experience in capital markets and real estates.<br><br>-></font><font size="2"><font face="Palatino Linotype"><strong>Preetam Lunawat  

<br></strong>-><strong>Dhiren Shah</strong> <br>-><strong>Nahid 
Shaikh</strong></font></font>                                </p>';
	$this->add_data($data);
    }
}

?>