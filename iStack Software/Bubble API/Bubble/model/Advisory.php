<?php
class AdvisoryHandler {
    protected $presenter;
    protected $step;
    public function __construct() {
	$this->presenter = 'Advisory';
    }
    
    public function __default() {
    }

    public function get_presenter_name() {
	return $this->presenter;
    }
}







?>