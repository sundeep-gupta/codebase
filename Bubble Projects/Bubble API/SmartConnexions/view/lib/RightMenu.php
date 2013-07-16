<?php
class RightMenu extends Div {
    public function __construct($id = 'rm') {
	parent::__construct( array('id'=> $id));
	$data = '<h1>hi</h1>';
	$this->add_data($data);
    }
}
?>