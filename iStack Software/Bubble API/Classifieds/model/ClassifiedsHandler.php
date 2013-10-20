<?php
require_once(MVC_LIB.'/Bubble/Classifieds/model/DatabaseHandler.php');
class ClassifiedsHandler {
	protected $dbhandler = null;
    public function __construct() {
	/* All basic methods go here */
		$this->dbhandler = new DatabaseHandler();
		
    }
	public function get_category_list() {
		return $this->dbhandler->get_cats_main();
	}
	protected function __destruct() {
		$this->dbhandler = null;
	}
}

?>
