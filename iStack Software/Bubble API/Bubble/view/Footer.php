<?php

class Footer extends Div {
    public function __construct($id = 'footer') {
	parent::__construct( array('id' => $id));
	$div = new Div( array('id' => 'footer-left'));

	$div = '<div class="footer-left">
	|<a href="/galleries/Bubble%20Gallery/index.htm">Gallery</a> 
	|<a href="/cgi-bin/bubbleforum/YaBB.pl">Forum </a>|
	<a href="/ebook.php">E-Book</a> |
	<a href="/myspace.php">My Space</a> |
	<a href="/advertise/index.php">Advertise</a> <b>|</b>
	<a href="/contact.php">Contact us </a>
	</div>

	<div class="footer-right">
		<font size="1" color="white"> All Rights Reserved, Bubble Inc.,</font>
	</div>';
	$this->add_data($div);
    }

}
?>