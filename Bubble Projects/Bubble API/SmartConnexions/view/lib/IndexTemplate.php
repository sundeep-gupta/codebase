<?php
require_once(LIB.'/HTML/Div.php');
require_once(LIB.'/HTML/HTMLHead.php');
require_once(LIB.'/HTML/UList.php');

require_once(VIEW.'/lib/Header.php');
require_once(VIEW.'/lib/Footer.php');
require_once(VIEW.'/lib/RightMenu.php');

class IndexTemplate extends Div{
    protected $header     = null;

    protected $footer     = null;
    protected $main_body  = null;

    public function __construct($template_attr = null, $html_attr = null) {
	parent::__construct($html_attr);
	if ($this->header == null) {
	    $this->header     = new Header($template_attr['header']);
	}
	if ($this->footer == null) {
	    $this->footer     = new Footer();
	}

	$this->add_data($this->header);
	$this->add_data($this->main_body);
	$this->add_data($this->footer);
    }

    public function set_main_body($main_body = '') {
    	$this->main_body = $main_body;
    }

    public function get_header()     { return $this->header; }
    public function get_footer()     { return $this->footer; }
    public function get_main_body()  { return $this->main_body; }

}

?>