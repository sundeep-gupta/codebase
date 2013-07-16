<?php
class ServicesHandler {
    protected $presenter;
    protected $step;
    public function __construct() {
	$this->presenter = 'Services';
    }
    
    public function __default() {
    }

    public function get_presenter_name() {
	return $this->presenter;
    }
}







?>