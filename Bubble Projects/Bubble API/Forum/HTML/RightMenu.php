<?php
require_once(LIB.'/Bubble/HTML/Div.php');

class RightMenu extends Div {
    public function __construct($id = 'rightbar') {
	parent::__construct( array('id'=> $id));
	$data = '<h1>News Updates</h1>
			<p> Our new client is Blah Blah Blah :)</p>	
			<h1>Testimonials</h1>
			<p>Bubble provides best service in class (not outside the class:))</p>';
	$this->add_data($data);
    }
}
?>