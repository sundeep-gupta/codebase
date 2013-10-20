<?php
class InsuranceHandler {
    protected $presenter;
    protected $step;
    public function __construct() {
	$this->presenter = 'Insurance';
    }
    
    public function __default() {
    }

    public function get_presenter_name() {
	return $this->presenter;
    }
}







?>