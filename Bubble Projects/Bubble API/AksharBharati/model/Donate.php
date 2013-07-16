<?php
class DonateHandler {
    protected $presenter;
    protected $step;
    public function __construct() {
	$this->presenter = 'Donate';
    }
    
    public function __default() {
    }

    public function get_presenter_name() {
	return $this->presenter;
    }
}







?>
