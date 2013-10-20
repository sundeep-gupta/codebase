<?php
class AddBookHandler {
    protected $presenter;
    protected $step;
    public function __construct() {
	$this->presenter = 'AddBook';
    }
    
    public function __default() {
    }

    public function get_presenter_name() {
	return $this->presenter;
    }
}







?>
