<?php
class BusinessHandler {
    protected $presenter;
    protected $step;
    public function __construct() {
	$this->presenter = 'Business';
    }
    
    public function __default() {
    }

    public function get_presenter_name() {
	return $this->presenter;
    }
}







?>