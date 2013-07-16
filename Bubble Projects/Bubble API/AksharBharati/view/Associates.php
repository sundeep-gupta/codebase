<?php
require_once(MVC_LIB.'/Bubble/'.PROJECT_NAME.'/view/HTMLPage.php');
require_once(MVC_LIB.'/Bubble/'.PROJECT_NAME.'/view/Template.php');

class AssociatesView extends HTMLPage{
    protected $template_body;
    protected $html_head ;
    protected $body ;
    protected $model;
    public function __construct($model) { 
		$this->model = $model;
		$index_page  = new AssociatesBody();
		$this->body  = new Body(null, $index_page);
		$this->head  = new HTMLHead();
		$this->head->add_stylesheet("images/bubble_ab.css");
		$this->head->set_title("Akshar Bharati - Home");
		parent::__construct();
    }
    
}

class AssociatesBody extends TemplateView {
    public function __construct() {
	$this->main_body = new Associates();
	parent::__construct( array('header' => array('active_menu' => 'Home')), 
			     array('id' =>'wrap'));
    }
}

class Associates extends Div{
    function __construct($id = 'main') {
	parent::__construct( array('id' => $id));
		$data = '	<p class="style2" align="justify"><strong>Associates</strong></p>
	<p class="style1" align="justify">Akshar Bharati is currently associated 
	with following NGOs:</p>
	<p class="style1" align="justify">&nbsp;&nbsp; <img alt="" src="images/bluebullet24.gif" width="10" height="10">&nbsp; 
	Surajya<br>
	&nbsp;&nbsp; <img alt="" src="images/bluebullet24.gif" width="10" height="10">&nbsp;
	Swaroop Vardini<br>
	&nbsp;&nbsp; <img alt="" src="images/bluebullet24.gif" width="10" height="10">&nbsp;
	Sewa Sahyog<br>
	&nbsp;&nbsp; <img alt="" src="images/bluebullet24.gif" width="10" height="10">&nbsp;
	Pratham<br>
	&nbsp;&nbsp; <img alt="" src="images/bluebullet24.gif" width="10" height="10">&nbsp;
	Maharashtra Education Society (MES)&nbsp;<br>
	&nbsp;&nbsp; <img alt="" src="images/bluebullet24.gif" width="10" height="10">&nbsp;
	Bharatiya Samaj Seva Kendra (BSSK)<br>
	&nbsp;&nbsp; <img alt="" src="images/bluebullet24.gif" width="10" height="10">&nbsp;
	Sweekar</p>
';

		$this->add_data($data);
    }
}
?>
