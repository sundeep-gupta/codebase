<?php
class VolunteerHandler {
    protected $presenter;
    protected $step;
    public function __construct() {
		$this->presenter = 'Volunteer';
    }
    
    public function __default() {
    }

    public function get_presenter_name() {
		return $this->presenter;
    }
}







?>
