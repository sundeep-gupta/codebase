<?php
require_once(LIB.'/HTML/HTMLPage.php');
require_once(LIB.'/HTML/Body.php');
require_once(VIEW.'/lib/IndexTemplate.php');
require_once(VIEW.'/lib/RightMenu.php');

class ContactView extends HTMLPage{
    protected $template_body;
    protected $html_head ;
    protected $body ;
    protected $model;
    public function __construct($model) {
	$this->model = $model;
	$Contact_page  = new ContactBody();
	$this->body  = new Body( array('onload'=>'process(\'Contact\')','bgcolor'=> "#333333"), $Contact_page);
	$this->head  = new HTMLHead();

	$this->head->add_stylesheet("dhtml/crea2ive.css");
    $this->head->add_javascript("dhtml/ajaxlib.js");
    $this->head->add_javascript("dhtml/stmenu.js");
    $this->head->add_javascript("dhtml/creajax.js");
	$this->head->set_title("Welcome to Crea2ive World!");

	parent::__construct();
    }

}

class ContactBody extends IndexTemplate {
    public function __construct() {

	$this->main_body = new Contact();
	parent::__construct(null,  array('id' =>'frame'));
    }
}

class Contact extends Div{
    function __construct($id = 'main') {
	  parent::__construct( array('id' => $id));
	  $this->get_data();
 	  $this->add_data(new RightMenu());
    }
    function get_cdata_div() {
      $cdataDiv = new Div(array('id' => 'cdata'));
      return $cdataDiv;
    }
    function get_data() {
      $this->add_data($this->get_cdata_div());
    }
}
?>
