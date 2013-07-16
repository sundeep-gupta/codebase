<?php
require_once(MVC_LIB.'/Bubble/Classifieds/view/Index.php');
require_once(MVC_LIB.'/Bubble/Classifieds/model/ClassifiedsHandler.php');
class IndexHandler extends ClassifiedsHandler {
    protected $presenter;
    protected $step;
    public function __construct() {
	parent::__construct();
	$this->presenter = 'Index';
    }
    
    public function __default() {
    }

    public function get_presenter_name() {
	return $this->presenter;
    }
}







?>