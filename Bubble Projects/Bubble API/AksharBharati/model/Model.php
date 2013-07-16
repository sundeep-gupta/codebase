<?php
class ModelHandler {
    protected $presenter;
    protected $step;
    public function __construct() {
	$this->presenter = 'Model';
    }
    
    public function __default() {
    }

    public function get_presenter_name() {
	return $this->presenter;
    }
}







?>
