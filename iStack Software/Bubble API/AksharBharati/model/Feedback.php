<?php
class FeedbackHandler {
    protected $presenter;
    protected $step;
    public function __construct() {
	$this->presenter = 'Feedback';
    }
    
    public function __default() {
    }

    public function get_presenter_name() {
	return $this->presenter;
    }
}







?>
