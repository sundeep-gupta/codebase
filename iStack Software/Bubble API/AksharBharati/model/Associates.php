<?php
class AssociatesHandler {
    protected $presenter;
    protected $step;
    public function __construct() {
	$this->presenter = 'Associates';
    }
    
    public function __default() {
    }

    public function get_presenter_name() {
	return $this->presenter;
    }
}







?>
