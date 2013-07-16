<?php
#define('VIEW','D:/Bubble/PremiumBrokers/view');
#define('LIB','D:/php-lib');
require_once(VIEW.'/HTMLPage.php');
require_once(VIEW.'/Template.php');
#require_once(LIB.'/Bubble/HTML/Body.php');
#require_once(LIB.'/Bubble/HTML/HTMLHead.php');


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
	$data = '<h1>Welcome to <span class="green">Premium Brokers web portal</span></h1>
<p class="style1" text-align: justify; background: white">
<strong>Established in Feb 2006 by Dhiren Shah, Preetam Lunawat and Anand Shah is a partnership concern to provide financial services, share broking, wealth management, insurance and real estate related services. <br/><br/>
Currently managing more than 200+ clients, we focus on providing customized investment advisory services and portfolio management.
<br/><br/>Premium Brokers has tied up with Kotak Securities Pvt Ltd., for providing equities, derivatives and commodity trading services.</p>
';

	$this->add_data($data);
    }
}
?>
