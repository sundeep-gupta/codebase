<?php
class index {
    protected $presenter;
    public function __construct() {
	$this->presenter = 'ViewIndex';
    }
    
    public function __default() {
	# Do nothing as it is index class
	return 1;
    }

    public function getPresenterName() {
	return $this->presenter;
    }
}
?>