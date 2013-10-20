<?php
require_once(VIEW.'/Articles.php');
class ArticlesHandler {
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