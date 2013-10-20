<?php

class BuyHandler {
    protected $presenter ;
    public function __construct() {
	$this->presenter = 'Buy';
    }

    public function __default() {

    }

    public function get_presenter_name() {
	return $this->presenter;
    }
}

?>