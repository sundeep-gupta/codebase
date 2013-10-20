<?php
class RightMenu extends Div {
    public function __construct($id = 'rm') {
	parent::__construct( array('id'=> $id));
	$data = '<script type="text/javascript" language="JavaScript1.2" src="dhtml/crea2ive.js"></script>
             <br /><br /><span class="icon_mail"><b>info@crea2ive.com</b></span>';
	$this->add_data($data);
    }
}
?>