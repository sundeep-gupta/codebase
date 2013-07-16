<?php
class StockHandler {
    protected $presenter;
    protected $step;
    public function __construct() {
	$this->presenter = 'Stock';
    }
    
    public function __default() {
    }

    public function get_presenter_name() {
	return $this->presenter;
    }
}







?>