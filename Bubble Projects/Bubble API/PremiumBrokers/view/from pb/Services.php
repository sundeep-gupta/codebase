<?php
require_once(VIEW.'/HTMLPage.php');
require_once(VIEW.'/Template.php');
require_once(LIB.'/Bubble/HTML/Div.php');


class ServicesView extends HTMLPage{
    protected $template_body;
    protected $html_head ;
    protected $body ;
    protected $model;
    public function __construct($model) { 
	$this->model = $model;
	$insurance_page  = new ServicesBody();
	$this->body  = new Body(null, $insurance_page);
	$this->head  = new HTMLHead();
	$this->head->add_stylesheet("images/bubblepb.css");
	$this->head->set_title("---Premiun Brokers---");
	parent::__construct();
    }
    
}

class ServicesBody extends TemplateView {
    public function __construct() {
	$this->main_body = new Services();
	parent::__construct( array('id' =>'wrap'));
    }
}

class Services extends Div{
    function __construct($id = 'main') {
	parent::__construct( array('id' => $id));
	$data  = '<img border="0" src="images/UnderConstruction.bmp" width="435" height="356">';
	$this->add_data($data);
    }
}

?>