<?php
require_once(MVC_LIB.'/Bubble/Classifieds/view/Template.php');
require_once(MVC_LIB.'/Bubble/Classifieds/view/ClassifiedsView.php');
require_once(MVC_LIB.'/Bubble/Classifieds/view/RegisterForm.php');

class RegisterView extends ClassifiedsView {
    public function __construct($model) {
		$this->body_text = new ThreePaneMainBody();
		$main_page = new Register($model);
		$this->body_text->set_main_body($main_page);
		parent::__construct($model);
    }

}

class Register extends Div {
    public function __construct($model, $attr=array('id'=> 'main')) {
		parent::__construct($attr);
		if($model->get_step() == 2) {
			/* Form Submitted Successfully */
			$this->add_data('A Mail has been Sent to you ' );
		} else {
			if($model->get_step() == -1) {
				$this->add_data( $model->get_error());
			}	
			$register_form = new RegisterForm();
			$this->add_data($register_form);
		}
    }
}
?>
