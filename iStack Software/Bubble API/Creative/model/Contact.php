<?php
class ContactHandler {
    protected $presenter;
    protected $step;
    public function __construct() {
	$this->presenter = 'Contact';
    }
    
    public function __default() {
    }

    public function get_presenter_name() {
	return $this->presenter;
    }
}







?>