<?php
require_once(LIB.'/HTML/Div.php');
require_once(LIB.'/HTML/HTMLHead.php');
require_once(LIB.'/HTML/UList.php');

require_once(VIEW.'/Header.php');
require_once(VIEW.'/Advertise.php');
require_once(VIEW.'/RightMenu.php');
require_once(VIEW.'/Footer.php');

class ThreePaneTemplateView extends Div{
    protected $header     = null;

    protected $ads        = null;
    protected $footer     = null;
    protected $right_bar  = null;
    protected $left_bar   = null;
    protected $main_body  = null;

    public function __construct($template_attr = null, $html_attr = null) {
	parent::__construct($html_attr);
	if ($this->header == null) {
	    $this->header     = new Header($template_attr['header']);
	}
#	if ($this->ads == null) {
#	    $this->ads        = new Advertise();
#	}
	if ($this->left_bar == null) {
       $this->left_bar = new LeftBar();
    }
	if ($this->right_bar == null) {
	    $this->right_bar = new RightBar();
	}
	if ($this->footer == null) {
	    $this->footer     = new Footer();
	}

	$this->add_data($this->header);
#	$this->add_data($this->ads);
    $this->add_data($this->left_bar);
	$this->add_data($this->main_body);
#	$this->add_data($this->right_bar);
	$this->add_data($this->footer);
    }

    public function set_main_body($main_body = '') {
	$this->main_body = $main_body;
    }

    public function get_header()     { return $this->header; }
    public function get_ads()        { return $this->ads; }
    public function get_footer()     { return $this->footer; }
    public function get_main_body()  { return $this->main_body; }
    public function get_right_bar()  { return $this->right_bar; }
    public function get_left_bar()   { return $this->left_bar; }
}

?>