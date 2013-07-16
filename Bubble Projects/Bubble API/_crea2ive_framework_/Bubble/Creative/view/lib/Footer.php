<?php

class Footer extends Div {
    public function __construct($id = 'bottom') {
    	parent::__construct( array('id' => $id));
    	$this->add_data('<p class="footer">.Crea2ive. &copy; 2008, 2009. Best viewed in 1440x900 resolution.</p>');
    }
}
?>