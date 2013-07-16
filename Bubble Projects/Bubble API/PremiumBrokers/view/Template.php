<?php
require_once(LIB.'/Bubble/HTML/Div.php');
require_once(LIB.'/Bubble/HTML/HTMLHead.php');
require_once(LIB.'/Bubble/HTML/UList.php');

class TemplateView extends Div{
    protected $header     = null;

    protected $ads        = null;
    protected $footer     = null;
    protected $right_menu = null;
    protected $main_body  = null;

    public function __construct($template_attr = null, $html_attr = null) { 
	parent::__construct($html_attr);
	if ($this->header == null) {
	    $this->header     = new Header($template_attr['header']);
	}
	if ($this->ads == null) {
	    $this->ads        = new Advertise();
	}
	if ($this->right_menu == null) {
	    $this->right_menu = new RightMenu();
	}
	if ($this->footer == null) {
	    $this->footer     = new Footer();
	}
	
	$this->add_data($this->header);
	$this->add_data($this->ads);

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


class TwoPaneTemplateView extends Div{
    protected $header     = null;
    protected $ads        = null;
    protected $footer     = null;
    protected $main_body  = null;

    public function __construct($attr = null) { 

	parent::__construct($attr);

	if ($this->header == null) {
	    $this->header     = new Header();
	}
	if ($this->ads == null) {
	    $this->ads        = new Advertise();
	}
	if ($this->footer == null) {
	    $this->footer     = new Footer();
	}
	$this->add_data($this->header);
	$this->add_data($this->ads);
	$this->add_data($this->main_body);
	$this->add_data($this->footer);
    }
    
    public function set_main_body($main_body = '') { 
	$this->main_body = $main_body;
    }

    public function get_header() { return $this->header; }
    public function get_ads() { return $this->ads; }
    public function get_footer() { return $this->footer; }
    public function get_main_body() { return $this->main_body; }

}

class Header extends Div{

    protected $menu_items = array ( 
	'Home'         => 'index.php',
	'Broking'       => 'controller.php?action=Broking',
	'Insurance'     => 'controller.php?action=Insurance',
	'Real Estate'   => 'controller.php?action=RealEstate',
	'Advisory'      => 'controller.php?action=Advisory',
	'Partner us' => 'controller.php?action=Opportunities',
	'Training'      => 'controller.php?action=Training',
	'Contact'       => 'controller.php?action=Contact',
	);
    protected $header_attr;

    function __construct($header_attr = null, $html_attr = array ('id' =>'header')) {
	parent::__construct( $html_attr);
	$this->header_attr = $header_attr;

	$data = '<h1 id="logo" style="position: absolute; left: 33; top: 16">
		Premium<span class="green">Brokers</span><span class="gray"></span></h1>	
		';
	$this->add_data($data);		
	$menu = new UList();
	foreach ($this->menu_items as $name=>$url) {
	    $menu_attr = null;
	    if (is_array($this->header_attr) and $this->header_attr['active_menu'] == $name) {
		$menu_attr = array('id' => 'current');
	    }
	    $menu->add_element($menu_attr, '<a href="'.$url.'"><span>'.$name.'</span></a>');
	}
	$data = $menu->get_html_text();
	$this->add_data($data);
	
    }

}


class RightMenu extends Div {
    public function __construct($id = 'rightbar') {
	parent::__construct( array('id'=> $id));
	$data = '<h1>News Updates</h1>


                    <!--[if IE]>

<IE:Download ID="marqueedata" STYLE="behavior:url(#default#download)" /> 
<marquee id="externalmarquee" direction=up scrollAmount=4 style="width:100 px;height:150px;border:0px solid black;padding:3px" onMouseover="this.scrollAmount=2" onMouseout="this.scrollAmount=4" src="update.html">
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
	$data = '<img src="images/headerpic.jpg" alt="headerphoto" 
                  class="no-border" height="120" width="820"/>'."\n";
	$this->add_data( $data);
    }
}

class Footer extends Div {
    public function __construct($id = 'footer') {
	parent::__construct( array('id' => $id));
	$div = new Div( array('id' => 'footer-left'));

	$div = '<div class="footer-left">
		<p class="align-left">			
		&copy; 2008 <strong>Premium Brokers</strong> |
		Design by <a href="http://www.bubble.co.in/">Bubble Inc.,</a>

		</p>		
	</div>
	
	<div class="footer-right">
		<p class="align-right">
		<a href="index.html">Home</a>&nbsp;|&nbsp;
  		<a href="http://www.premiumbrokers.co.in/controller.php?action=Sitemap">Sitemap</a>&nbsp;|&nbsp;
   		</p>

	</div>';
	$this->add_data($div);
    }

}
?>
