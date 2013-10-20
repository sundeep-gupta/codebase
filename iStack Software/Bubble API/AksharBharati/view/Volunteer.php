<?php
require_once(MVC_LIB.'/Bubble/'.PROJECT_NAME.'/view/HTMLPage.php');
require_once(MVC_LIB.'/Bubble/'.PROJECT_NAME.'/view/Template.php');

class VolunteerView extends HTMLPage{
    protected $template_body;
    protected $html_head ;
    protected $body ;
    protected $model;
    public function __construct($model) { 
		$this->model = $model;
		$index_page  = new VolunteerBody();
		$this->body  = new Body(null, $index_page);
		$this->head  = new HTMLHead();
		$this->head->add_stylesheet("images/bubble_ab.css");
		$this->head->set_title("Akshar Bharati - Home");
		parent::__construct();
    }
    
}

class VolunteerBody extends TemplateView {
    public function __construct() {
	$this->main_body = new Volunteer();
	parent::__construct( array('header' => array('active_menu' => 'Home')), 
			     array('id' =>'wrap'));
    }
}

class Volunteer extends Div{
    function __construct($id = 'main') {
		parent::__construct( array('id' => $id));
		$data = '	<p class="style2" align="justify"><strong>Volunteer</strong></p>
	<p class="style1" align="justify">
	Akshar Bharati provides following opportunities for an individual to 
	volunteer in various activities:</p>
	<p class="style1" align="justify">
	&nbsp;&nbsp; <img alt="" src="images/bluebullet24.gif" width="10" height="10">&nbsp; 
	Flexibility to work on any chosen activity<br>

	&nbsp;&nbsp; <img alt="" src="images/bluebullet24.gif" width="10" height="10">&nbsp; 
	Simple activities like stamping &amp; cataloging books<br>
	&nbsp;&nbsp; <img alt="" src="images/bluebullet24.gif" width="10" height="10">&nbsp; 
	Activities only after office hours<br>
	&nbsp;&nbsp; <img alt="" src="images/bluebullet24.gif" width="10" height="10">&nbsp; 
	No need to do any field activities<br>

	&nbsp;&nbsp; <img alt="" src="images/bluebullet24.gif" width="10" height="10">&nbsp; 
	Just identifying potential targets is an activity as well<br>
	&nbsp;&nbsp; <img alt="" src="images/bluebullet24.gif" width="10" height="10">&nbsp; 
	Information management &amp; Monthly library visits<br>
	&nbsp;&nbsp; <img alt="" src="images/bluebullet24.gif" width="10" height="10">&nbsp; 
	Conducting various activities for Kids &amp; NGO volunteers<br>

	&nbsp;&nbsp; <img alt="" src="images/bluebullet24.gif" width="10" height="10">&nbsp; 
	Procurement &amp; Fund raising </p>
	<p class="style1" align="justify">&nbsp;</p>';

		$this->add_data($data);
    }
}
?>
