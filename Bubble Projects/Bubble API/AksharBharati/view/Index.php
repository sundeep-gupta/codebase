<?php
require_once(MVC_LIB.'/Bubble/'.PROJECT_NAME.'/view/HTMLPage.php');
require_once(MVC_LIB.'/Bubble/'.PROJECT_NAME.'/view/Template.php');

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
		$this->head->add_stylesheet("images/bubble_ab.css");
		$this->head->set_title("Akshar Bharati - Home");
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
		$data = '	<p class="style1" align="justify">Akshar Bharati is a sincere effort to 
	reach the children from rural and underprivileged areas who have the will to 
	learn, to read books and to make difference in their lives. Akshar Bharati 
	is trying to set up small libraries for such children in their localities so 
	that the books will be available for them when they need them the most. <br>
	<br>
	Akshar Bharati provides an easy way for everyone to get involved in Social 
	work. We work along various NGO organization who are active in areas where 
	we see requirement of a library. <br>
	<br>
	The advantages of working along with area specific NGO are: <br>
	<br>
	&nbsp;&nbsp; <img alt="" src="images/bluebullet24.gif" width="10" height="10">&nbsp; The NGO volunteers can look after Akshar Bharati library <br>
	&nbsp;&nbsp; <img alt="" src="images/bluebullet24.gif" width="10" height="10">&nbsp; Provide us constant feedback about working of Akshar Bharati<br>
	&nbsp;&nbsp; <img alt="" src="images/bluebullet24.gif" width="10" height="10">&nbsp; Akshar Bharati does not need to have a dedicated person required to &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;manage 
	library. </p>
	<p class="style1" align="justify">Once Akshar Bharati library in place we encourage volunteers to 
	conduct various activities at the library location so to build curiosity 
	among children to utilize books of the library. Akshar Bharati volunteers 
	conduct regular paper toy &amp; science experiment activities at various 
	locations.<br>
	<br>
	<br>
	Akshar Bharati library has following salient features:<br>
	<br>
	&nbsp;&nbsp; <img alt="" src="images/bluebullet24.gif" width="10" height="10">&nbsp; No 
	Separate room required<br>
	&nbsp;&nbsp; <img alt="" src="images/bluebullet24.gif" width="10" height="10">&nbsp; AB provides storage if required which can be kept in corner without&nbsp;&nbsp;&nbsp;&nbsp; 
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;obstructing other activities<br>
	&nbsp;&nbsp; <img alt="" src="images/bluebullet24.gif" width="10" height="10">&nbsp; Book shelf library model to easily accommodate ~1000 books<br>
	&nbsp;&nbsp; <img alt="" src="images/bluebullet24.gif" width="10" height="10">&nbsp; No dedicated staff required<br>
	&nbsp;&nbsp; <img alt="" src="images/bluebullet24.gif" width="10" height="10">&nbsp; Akshar Bharati assistance if any book is torn or not getting used<br>
	&nbsp;&nbsp; <img alt="" src="images/bluebullet24.gif" width="10" height="10">&nbsp; At any time library can be scaled up with additional books<br>
	&nbsp;&nbsp; <img alt="" src="images/bluebullet24.gif" width="10" height="10">&nbsp; Facility to procure &amp; donate project specific books<br>
	<br>
	<br>
	Akshar Bharati is a member of Sewa International an NGO which facilitates in 
	raising funds for various causes &amp; distribute among member NGOs.</p>';

		$this->add_data($data);
    }
}
?>
