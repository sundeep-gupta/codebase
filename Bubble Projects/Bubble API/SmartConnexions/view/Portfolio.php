<?php
require_once(LIB.'/HTML/HTMLPage.php');
require_once(LIB.'/HTML/Body.php');
require_once(VIEW.'/lib/IndexTemplate.php');
require_once(VIEW.'/lib/RightMenu.php');


class PortfolioView extends HTMLPage{
    protected $template_body;
    protected $html_head ;
    protected $body ;
    protected $model;
    public function __construct($model) {
	$this->model = $model;
	$portfolio_page  = new PortfolioBody();
	$this->body  = new Body( array('onload'=>'process(\'Portfolio\')','bgcolor'=> "#333333"), $portfolio_page);
	$this->head  = new HTMLHead();

	$this->head->add_stylesheet("dhtml/crea2ive.css");
    $this->head->add_javascript("dhtml/ajaxlib.js");
    $this->head->add_javascript("dhtml/stmenu.js");
    $this->head->add_javascript("dhtml/creajax.js");
	$this->head->set_title("Welcome to Crea2ive World!");

	parent::__construct();
    }

}

class PortfolioBody extends IndexTemplate {
    public function __construct() {

	$this->main_body = new Portfolio();
	parent::__construct(null,  array('id' =>'frame'));
    }
}

class Portfolio extends Div{
    function __construct($id = 'main') {
	  parent::__construct( array('id' => $id));
	  $this->add_data(new Div(array('id'=> 'cdata')));
 	  $this->add_data(new RightMenu());
    }
}
?>
