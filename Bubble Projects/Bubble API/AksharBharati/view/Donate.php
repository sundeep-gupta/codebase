<?php
require_once(MVC_LIB.'/Bubble/'.PROJECT_NAME.'/view/HTMLPage.php');
require_once(MVC_LIB.'/Bubble/'.PROJECT_NAME.'/view/Template.php');

class DonateView extends HTMLPage{
    protected $template_body;
    protected $html_head ;
    protected $body ;
    protected $model;
    public function __construct($model) { 
		$this->model = $model;
		$index_page  = new DonateBody();
		$this->body  = new Body(null, $index_page);
		$this->head  = new HTMLHead();
		$this->head->add_stylesheet("images/bubble_ab.css");
		$this->head->set_title("Akshar Bharati - Home");
		parent::__construct();
    }
    
}

class DonateBody extends TemplateView {
    public function __construct() {
	$this->main_body = new Donate();
	parent::__construct( array('header' => array('active_menu' => 'Home')), 
			     array('id' =>'wrap'));
    }
}

class Donate extends Div{
    function __construct($id = 'main') {
	parent::__construct( array('id' => $id));
		$data = '	<p class="style2" align="justify"><strong>Donate</strong></p>
	<p class="style1" align="justify">The intention of Akshar Bharati project is 
	to enable people in investing time, effort &amp; money in social cause with 
	accountable, manageable &amp; simple approach. </p>
	<p class="style1" align="justify">Donating in Akshar Bharati activates has 
	following salient features:</p>

	<p class="style1" align="justify">&nbsp;&nbsp; <img alt="" src="images/bluebullet24.gif" width="10" height="10">&nbsp; Collected funds are used only for 
	procuring books<br>
	&nbsp;&nbsp; <img alt="" src="images/bluebullet24.gif" width="10" height="10">&nbsp;
	Not a penny is taken by volunteers or NGOs<br>
	&nbsp;&nbsp; <img alt="" src="images/bluebullet24.gif" width="10" height="10">&nbsp;
	Easy way to spend on social cause<br>

	&nbsp;&nbsp; <img alt="" src="images/bluebullet24.gif" width="10" height="10">&nbsp;
	Regular feedbacks to track usage of Books<br>
	&nbsp;&nbsp; <img alt="" src="images/bluebullet24.gif" width="10" height="10">&nbsp;
	A proper process in place to identify &amp; finalize on library locations&nbsp;</p>
	<p class="style1" align="justify">Currently for donating in Akshar Bharati, 
	please send cheque in the name of <strong>Sewa International (Write Project: 
	Akshar Bharati at the back of the Cheque leaf)</strong> to the following 
	address:</p>

	<p class="style1" align="justify"><strong>Anurag Agarwal</strong><br>
	Symantec Software India Pvt Ltd.,<br>
	Mayfair Towers<br>
	Wakdewadi<br>
	Pune-Mumbai Highway<br>
	Shivajinagar<br>

	Pune - 411005<br>
	INDIA&nbsp;</p>';

		$this->add_data($data);
    }
}
?>
