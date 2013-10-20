<?php
class TrainingHandler {
    protected $presenter;
    protected $step;
    public function __construct() {
	$this->presenter = 'Training';
    }
    
    public function __default() {
    }

    public function get_presenter_name() {
	return $this->presenter;
    }
}







?>