<?php
class RealEstateHandler {
    protected $presenter;
    protected $step;
    public function __construct() {
	$this->presenter = 'RealEstate';
    }
    
    public function __default() {
    }

    public function get_presenter_name() {
	return $this->presenter;
    }
}







?>