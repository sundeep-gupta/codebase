<?php
class RequirementHandler {
    protected $presenter;
    protected $step;
    public function __construct() {
	$this->presenter = 'Requirement';
    }
    
    public function __default() {
	$this->step = 1;
    }

    public function submit_personal_info() {
	$this->step = 2;
	$_SESSION['firstname'] = $_POST['firstname'];
    }
    
    public function submit_rentout_info() {
	$this->step = 3;
    }

    public function get_presenter_name() {
	return $this->presenter;
    }
    public function get_step() {
	return $this->step;
    }
}







?>