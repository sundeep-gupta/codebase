<?php
require_once (LIB.'/Bubble/HTML/Div.php');

class LeftMenu extends Div{
    public function __construct($id = 'sidebar') {
	parent::__construct( array('id'=>$id));
	$data = '<ul class="sidemenu">
				<li><a href="controller.php?action=About">About</a></li>
				<li><a href="controller.php?action=Business">Business Development</a></li>
				<li><a href="controller.php?action=Services">Allied Services</a></li>
				<li><a href="controller.php?action=Contact">Contact us</a></li>
						
			</ul>		
				
			<h1>Wise Words</h1>
			<p>"Men are disturbed, not by the things that happen,
			but by their opinion of the things that happen."</p> 
			<p class="align-right">- Epictetus</p>';
	$this->add_data($data);
    }
}