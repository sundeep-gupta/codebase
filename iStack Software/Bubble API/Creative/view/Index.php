<?php
require_once(LIB.'/HTML/HTMLPage.php');
require_once(LIB.'/HTML/Body.php');
require_once(VIEW.'/lib/IndexTemplate.php');
require_once(VIEW.'/lib/RightMenu.php');


class IndexView extends HTMLPage{
    protected $template_body;
    protected $html_head ;
    protected $body ;
    protected $model;
    public function __construct($model, $title, $stylesheets = array('dhtml/crea2ive.css'),
                                        $scripts = array('dhtml/ajaxlib.js','dhtml/creajax.js', 'dhtml/stmenu.js')) {
	$this->model = $model;
	$index_page  = new IndexBody();
	$this->body  = new Body( array('onload'=>'process(\'Index\')','bgcolor'=> "#333333"), $index_page);
	$this->head  = new HTMLHead();
    foreach ($scripts as $script) {
          $this->head->add_javascript($script);
    }
    if(is_array($stylesheets)) {
      foreach($stylesheets as $stylesheet) {
        $this->head->add_stylesheet($stylesheet);
      }
    }
	$this->head->set_title($title);
	parent::__construct();
    }

}

class IndexBody extends IndexTemplate {
    public function __construct() {

	$this->main_body = new Index();
	parent::__construct(null,  array('id' =>'frame'));
    }
}

class Index extends Div{
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
