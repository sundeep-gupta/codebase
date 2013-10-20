<?php
class BrokingHandler {
    protected $presenter;
    protected $step;
    public function __construct() {
	$this->presenter = 'Broking';
    }
    
    public function __default() {
    }

    public function get_presenter_name() {
	return $this->presenter;
    }
}







?>