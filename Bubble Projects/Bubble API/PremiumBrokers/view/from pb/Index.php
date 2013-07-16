<?php
require_once(VIEW.'/HTMLPage.php');
require_once(VIEW.'/Template.php');


class IndexView extends HTMLPage{
    protected $template_body;
    protected $html_head ;
    protected $body ;
    protected $model;
    public function __construct($model) { 
	$this->model = $model;
	$index_page  = new IndexBody();
	$this->body  = new Body(null, $index_page);
	$this->head  = new HTMLHead();
	$this->head->add_stylesheet("images/bubblepb.css");
	$this->head->set_title("---Premiun Brokers---");
	parent::__construct();
    }
    
}

class IndexBody extends TemplateView {
    public function __construct() {
	$this->main_body = new Index();
	parent::__construct( array('header' => array('active_menu' => 'Home')), 
			     array('id' =>'wrap'));
    }
}

class Index extends Div{
    function __construct($id = 'main') {
	parent::__construct( array('id' => $id));
	$data = '<h1>Welcome to <span class="green">Premium Brokers web portal</span></h1>'.
'<p><font face="Palatino Linotype" size="2">At Premium Brokers 
we are successfully managing more than 100 clients in a short span of 1 1/2 years. 
These include a wide variety of retail individuals, non-individuals and HNIs. 
</font>                                </p>
<p><font face="Palatino Linotype" size="2">We provide customized Investment 
advisory and training services to the investors for creating, growing &amp; 
maintaining their wealth by offering diversified investment options like Equity, 
Real estates, bullions &amp; other financial products. <br> <br>We follow 
bottom up medium to long term investment strategy to try and nullify the 
volatility of the markets to give a continuous and steady return.</font> 
</p>';

	$this->add_data($data);
    }
}
?>