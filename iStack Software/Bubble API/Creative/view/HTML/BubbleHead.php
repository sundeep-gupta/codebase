<?php
require_once(LIB.'/HTML/HTMLHead.php');
class BubbleHead extends HTMLHead{

  public function __construct() {
    parent::__construct();
	$this->add_stylesheet("ddtabmenufiles/solidblocksmenu.css");
    $this->add_stylesheet("css/bubble.css");
	$this->add_stylesheet("sdmenu/sdmenu.css");
    $this->add_javascript("sdmenu/sdmenu.js");
    $this->add_javascript("ddtabmenufiles/ddtabmenu.js");
    $this->add_javascript('css/bubble.js');
#    $this->set_title("Bubble Inc [Realizing Dreams ... ]");
  }

}
?>