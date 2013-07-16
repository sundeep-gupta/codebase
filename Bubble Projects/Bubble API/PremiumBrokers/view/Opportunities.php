<?php
require_once(VIEW.'/HTMLPage.php');
require_once(VIEW.'/Template.php');
require_once(LIB.'/Bubble/HTML/Div.php');


class OpportunitiesView extends HTMLPage{
    protected $template_body;
    protected $html_head ;
    protected $body ;
    protected $model;
    public function __construct($model) { 
	$this->model = $model;
	$insurance_page  = new OpportunitiesBody();
	$this->body  = new Body(null, $insurance_page);
	$this->head  = new HTMLHead();
	$this->head->add_stylesheet("images/bubblepb.css");
	$this->head->set_title("---Premiun Brokers---");
	parent::__construct();
    }
    
}

class OpportunitiesBody extends TemplateView {
    public function __construct() {
	$this->main_body = new Opportunities();
	parent::__construct( array('header' => array('active_menu' => 'Partner us')), array('id' =>'wrap'));
    }
} 

class Opportunities extends Div{
    function __construct($id = 'main') {
	parent::__construct( array('id' => $id));
	$data  = '<h1>Partner <span class="green">us</span> </h1>
  
  <p class="style1" text-align: justify; background: white"><strong>
Require business associates in and around Pune for setting up equity and derivatives trading terminals. <br />
<br />
With us you can grow and capitalize on the huge potential in this growing 
Financial markets by using our Experience and State of the Art infrastructure at 
various locations. <br />
<br />
Sub brokers and Remissiers can get good profit sharing arrangements without any 
cost. <br />
<br />
To Know more contact : <a href="mailto:partners@premiumbrokers.co.in">partners@premiumbrokers.co.in</a></p>

';
	$this->add_data($data);
    }
}

?>
