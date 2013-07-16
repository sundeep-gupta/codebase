<?php
require_once (LIB.'/Bubble/HTML/Div.php');
class Footer extends Div {
    public function __construct($id = 'footer') {
	parent::__construct( array('id' => $id));
	$div = new Div( array('id' => 'footer-left'));
	$data = '<p class="align-left">© 2008 <strong>Premium Brokers</strong> |
		Design by <a href="http://www.bubble.co.in/">Bubble Inc.,</a>
		</p>';
	$div->add_data($data);
	$this->add_data($data);

	$div  = new Div( array('id' => 'footer-right'));
	$data = '<p class="align-right">
		<a href="http://www.bubble.co.in/bubbleprojects/BrightSide/index.html">Home</a>&nbsp;|&nbsp;
  		<a href="http://www.bubble.co.in/bubbleprojects/BrightSide/index.html">SiteMap</a>&nbsp;|&nbsp;
   		</p>';
	$div->add_data($data);
	$this->add_data($div);
    }

}

?>