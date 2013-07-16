<?php
require_once(PB_LIB.'/Bubble/PremiumBrokers/view/RentOut.php');
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