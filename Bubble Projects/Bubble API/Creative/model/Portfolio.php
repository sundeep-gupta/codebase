<?php

class PortfolioHandler {
    protected $presenter;
    protected $step;
    public function __construct() {
	$this->presenter = 'Portfolio';
    }
    
    public function __default() {
    }

    public function get_presenter_name() {
	return $this->presenter;
    }
}







?>