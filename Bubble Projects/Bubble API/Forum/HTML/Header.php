<?php
require_once (LIB.'/Bubble/HTML/Div.php');
class Header extends Div{

    function __construct($id = 'header') {
	parent::__construct( array('id' => $id));
	$data = '<h1 id="logo">
		<img border="0" src="images/pblogo.png" width="100" height="50" align="absmiddle">Premium<span class="green">Brokers</span><span class="gray"></span></h1>	
		<h2 id="slogan">... Valuing relations ... forever !!</h2> ';

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