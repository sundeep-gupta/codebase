<?php
require_once(MVC_LIB.'/Bubble/'.PROJECT_NAME.'/view/HTMLPage.php');
require_once(MVC_LIB.'/Bubble/'.PROJECT_NAME.'/view/Template.php');

class ContactView extends HTMLPage{
    protected $template_body;
    protected $html_head ;
    protected $body ;
    protected $model;
    public function __construct($model) { 
		$this->model = $model;
		$index_page  = new ContactBody();
		$this->body  = new Body(null, $index_page);
		$this->head  = new HTMLHead();
		$this->head->add_stylesheet("images/bubble_ab.css");
		$this->head->set_title("Akshar Bharati - Home");
		parent::__construct();
    }
    
}

class ContactBody extends TemplateView {
    public function __construct() {
	$this->main_body = new Contact();
	parent::__construct( array('header' => array('active_menu' => 'Home')), 
			     array('id' =>'wrap'));
    }
}

class Contact extends Div{
    function __construct($id = 'main') {
	parent::__construct( array('id' => $id));
		$data = '	
    <b>Cantact us</b><br/>
    Thanks for visiting the site. For more details, mail us at aksharbharati.india@gmail.com
   <br/><br/><br/><br/><br/><br/><br/>
   
    ';

		$this->add_data($data);
    }
}
?>
