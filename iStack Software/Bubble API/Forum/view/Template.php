<?php
require_once(LIB.'/Bubble/HTML/Div.php');
require_once(LIB.'/Bubble/HTML/HTMLHead.php');

class TemplateView extends Div{
    protected $header     = null;
    protected $left_menu  = null;
    protected $ads        = null;
    protected $footer     = null;
    protected $right_menu = null;
    protected $main_body  = null;

    public function __construct($attr = null) { 
	parent::__construct($attr);
	if ($this->header == null) {
	    $this->header     = new Header();
	}
	if ($this->ads == null) {
#	    $this->ads        = new Advertise();
	}
	if ($this->left_menu == null) {
#	    $this->left_menu  = new LeftMenu();
	}
	if ($this->right_menu == null) {
#	    $this->right_menu = new RightMenu();
	}
	if ($this->footer == null) {
#	    $this->footer     = new Footer();
	}
	
	$this->add_data($this->header);
#	$this->add_data($this->ads);
#	$this->add_data($this->left_menu);
#	$this->add_data($this->main_body);
#	$this->add_data($this->right_menu);
#	$this->add_data($this->footer);
    }
    
    public function set_main_body($main_body = '') { 
	$this->main_body = $main_body;
    }
}

class Header extends Div{

    function __construct($id = 'header') {
	parent::__construct( array('id' => $id));
	$data = '<a href="/index.php"><img src="http://www.bubble.co.in/yabbfiles/Templates/Forum/default/title4.jpg"
				    alt="YaBB - Yet another Bubble Board" title="YaBB - Yet another Bubble Board" border="0" /></a>
	';

	$this->add_data($data);
	$data = '<ul>
			<li id="current"><a href="controller.php"><span>Home</span></a></li>
			<li><a href="controller.php?action=Stock"><span>Stock Trading</span></a></li>
			<li><a href="controller.php?action=Insurance"><span>Insurance</span></a></li>
			<li><a href="controller.php?action=RealEstate"><span>Real Estate</span></a></li>
			<li><a href="controller.php?action=Training"><span>Training</span></a></li>			
		</ul>';
	$this->add_data($data);
	
    }
}



?>