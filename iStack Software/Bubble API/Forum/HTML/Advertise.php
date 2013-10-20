<?php
require_once (LIB.'/Bubble/HTML/Div.php');
class Advertise extends Div {
    public function __construct($id = 'content-wrap') {
	parent::__construct( array('id' => $id));
	$data = '<img src="images/headerpic.jpg" alt="headerphoto" 
                  class="no-border" height="120" width="820"/>'."\n";
	$this->add_data( $data);
    }
}

?>