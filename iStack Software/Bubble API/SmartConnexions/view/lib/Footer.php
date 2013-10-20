<?php

class Footer extends Div {
    public function __construct($id = 'footer') {
    	parent::__construct( array('id' => $id));
    	$this->add_data('<p class="footer">&copy 2009 Smartconnexions | Designed & Maintained by <a href="http://www.crea2ive.com">.Crea2ive.</a></p>');
    }
}
?>