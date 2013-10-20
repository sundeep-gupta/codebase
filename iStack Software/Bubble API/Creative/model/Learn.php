<?php
class LearnHandler {
    protected $presenter;
    protected $step;
    public function __construct() {
	$this->presenter = 'Learn';
    }
    
    public function __default() {
    }

    public function get_presenter_name() {
	return $this->presenter;
    }
}







?>