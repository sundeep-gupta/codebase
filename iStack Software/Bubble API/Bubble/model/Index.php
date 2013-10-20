<?php
require_once(VIEW.'/Index.php');
class IndexHandler {
    protected $presenter;
    protected $step;
    public function __construct() {
	$this->presenter = 'Index';
    }
    
    public function __default() {
    }

    public function get_presenter_name() {
	return $this->presenter;
    }
}







?>