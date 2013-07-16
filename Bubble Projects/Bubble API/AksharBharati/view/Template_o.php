<?php
require_once(LIB.'/Bubble/HTML/Div.php');
require_once(LIB.'/Bubble/HTML/HTMLHead.php');
require_once(LIB.'/Bubble/HTML/UList.php');

class TemplateView extends Div{
    protected $header     = null;
    protected $footer     = null;
    protected $right_menu = null;
	protected $left_menu = null;
    protected $main_body  = null;

    public function __construct($template_attr = null, $html_attr = null) { 
	parent::__construct($html_attr);
	if ($this->header == null) {
	    $this->header     = new Header($template_attr['header']);
	}

	if ($this->left_menu == null) {
	    $this->left_menu = new LeftMenu();
	}
	if ($this->right_menu == null) {
	    $this->right_menu = new RightMenu();
	}
	if ($this->footer == null) {
	    $this->footer     = new Footer();
	}
	
	$this->add_data($this->header);

	$this->add_data($this->left_menu);
	$this->add_data($this->main_body);
	$this->add_data($this->right_menu);
	$this->add_data($this->footer);
    }
    
   public function set_main_body($main_body = '') { 
		$this->main_body = $main_body;
    }

    public function get_header() { return $this->header; }
    public function get_ads() { return $this->ads; }
    public function get_footer() { return $this->footer; }
    public function get_main_body() { return $this->main_body; }
    public function get_right_menu() { return $this->right_menu; }
}


class Header extends Div{

    protected $header_attr;

    function __construct($header_attr = null, $html_attr = array ('id' =>'header')) {
		parent::__construct( $html_attr);
		$this->header_attr = $header_attr;
		$data = '<img border="0" src="images/titlebar7.jpg" width="800" height="100">';
		$data .= 
		'<img border="0" src="images/devider.jpg" width="800" height="2"><OBJECT classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
	   codebase="http://active.macromedia.com/flash2/cabs/swflash.cab#version=4,0,0,0"
		 ID=Untitled WIDTH=800 HEIGHT=250>
	 <PARAM NAME=movie VALUE="images/abmidpic.swf">
	 <PARAM NAME=quality VALUE=high>
	 <PARAM NAME=loop VALUE=false>
	 <EMBED src="images/abmidpic" loop=false quality=high
	   WIDTH=800 HEIGHT=250 TYPE="application/x-shockwave-flash"
		 PLUGINSPAGE="http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash">
		 </EMBED>
</OBJECT><img border="0" src="images/devider.jpg" width="800" height="2">';

		$this->add_data($data);		
    }

}

class LeftMenu extends Div {
	public function __construct($attr = array('id' => 'sidebar')) {
		parent::__construct($attr);
		$data = 
			'<a href="controller.php?action=Index"><img src="images/home.jpg" height="20"/></a>'.
				'<a href="controller.php?action=Projects"><img src="images/projects.jpg" height="20"/></a>'.
				'<a href="controller.php?action=Associates"><img src="images/associates.jpg" height="20"/></a>'.
				'<a href="controller.php?action=Model"><img src="images/model.jpg"     height="20"/></a>'.
				'<a href="controller.php?action=Volunteer"><img src="images/volunteer.jpg" height="20"/></a>'.
				'<a href="controller.php?action=Donate"><img src="images/donate.jpg"    height="20"/></a>'.
				'<a href="controller.php?action=Feedback"><img src="images/feedback.jpg"  height="20"/></a>'.
				'<a href="controller.php?action=Contact"><img src="images/contact.jpg"   height="20"/></a>';
		$this->add_data($data);				
	}
}

class RightMenu extends Div {
    public function __construct($attr = array('id' => 'sidebar2')) {
	parent::__construct( $attr );
		$data = '<p align="left"><b><font face="Monotype Corsiva"
		color="#000099">News Updates</font></b>
     <!--[if IE]>

<IE:Download ID="marqueedata" STYLE="behavior:url(#default#download)" /> 
<marquee id="externalmarquee" direction=up scrollAmount=4 style="width:120px;height:120px;border:0px solid blue;padding:3px" onMouseover="this.scrollAmount=1" onMouseout="this.scrollAmount=3" src="update.html">
</marquee>


<script language="JavaScript1.2">

function downloaddata(){
marqueedata.startDownload(externalmarquee.src,displaydata)
}

function displaydata(data){
externalmarquee.innerHTML=data
}

if (document.all)
window.onload=downloaddata


</script>

<![endif]-->
    
    ';
		$this->add_data($data);
    }
}

class Advertise extends Div {
    public function __construct($id = 'content-wrap') {
		parent::__construct( array('id' => $id));
    }
}

class Footer extends Div {
    public function __construct($id = 'footer') {
	parent::__construct( array('id' => $id));
			$div = new Div(array('id' => 'footer-left'));	
      $div = 
			'<div class="footer-left">
			<p class="align-left">			
			&copy; 2008 <strong>AksharBharati</strong> |
			Design by <a href="http://www.bubble.co.in/">Bubble Inc.,</a>
	
			</p>		
			</div>';
		$this->add_data($div);
    }

}
?>
