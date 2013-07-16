<?php

class RentInHandler {
    protected $presenter ;
    public function __construct() {
	$this->presenter = 'RentIn';
    }

    public function __default() {

    }

    public function get_presenter_name() {
	return $this->presenter;
    }
}

?>