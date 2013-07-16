<?php
class AboutHandler {
    protected $presenter;
    protected $step;
    public function __construct() {
	$this->presenter = 'About';
    }
    
    public function __default() {
    }

    public function get_presenter_name() {
	return $this->presenter;
    }
}







?>