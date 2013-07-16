<?php
require_once(VIEW.'/HTMLPage.php');
require_once(VIEW.'/Template.php');

require_once(PB_LIB.'/Bubble/PremiumBrokers/HTML/Index.php');

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
	$this->head->add_content_type("text/html");
	$this->head->add_javascript("ddtabmenufiles/ddtabmenu.js");
	$this->head->add_stylesheet("ddtabmenufiles/solidblocksmenu.css");
	$this->head->add_stylesheet("sddm.css");
	$this->head->add_stylesheet("http://www.bubble.co.in/yabbfiles/Templates/Forum/default.css");
	$this->set_title("Bubble Space!!! - Login");
	$this->add_script('ddtabmenu.definemenu("ddtabs3", 1)');
	$this->add_style('
	table {font-family: Book Antiqua; font-size: 10pt; color: #230000;}
	a:link {color: #394A54; text-decoration: none; }
	a:visited {color: #394A54; text-decoration: none; }
	a:hover {color: black; text-decoration: none; }
	a#side {color: white; text-decoration: underline; font-weight: bold; }
	td#side {padding-left: 20; }
	td#content {padding-left: 5; padding-right: 5; padding-top: 10; padding-bottom: 20; }');

	parent::__construct();
    }
    
}

class IndexBody extends TemplateView {
    public function __construct() {
	$this->main_body = new Index();
	parent::__construct( array('id' =>'wrap'));
    }
}


?>