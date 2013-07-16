<?php
class OpportunitiesHandler {
    protected $presenter;
    protected $step;
    public function __construct() {
	$this->presenter = 'Opportunities';
    }
    
    public function __default() {
    }

    public function get_presenter_name() {
	return $this->presenter;
    }
}







?>