<?php
require_once(MVC_LIB.'/Bubble/Classifieds/view/Index.php');
require_once(MVC_LIB.'/Bubble/Classifieds/model/ClassifiedsHandler.php');
require_once(MVC_LIB.'/Bubble/Classifieds/view/RegisterForm.php');
class RegisterHandler extends ClassifiedsHandler {
    protected $presenter;
    protected $step;
	protected $form;
	protected $eror_msg;
    public function __construct() {
	parent::__construct();
	$this->presenter = 'Register';
    }
    
    public function __default() {
		$this->step = 1;
    }
	
	public function get_step() {
		return $this->step;
	}
	
	public function get_error() { return $this->error_msg; }
	public function submit() {
		$this->step = 2;
		$this->form = RegisterForm::validate();
		if ($this->form) {
			if($this->dbconn->user_exists($this->form['username'])) {
				$this->step = -1;
				$this->error_msg  = 'User already exists';
			} elseif($this->dbconn->insert_temp_user($this->form)) {
				$this->step = -1;
				$this->error_msg = 'Error in DB Ops';
			}
		} else {
			$this->step = -1;
			$this->error_msg = 'Form Invalidated by server';	
		}
	}
		
    public function get_presenter_name() {
		return $this->presenter;
    }
}







?>
