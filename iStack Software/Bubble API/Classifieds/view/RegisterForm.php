<?php
require_once(LIB.'/Bubble/HTML/Form.php');
class RegisterForm {
    protected $username;
	protected $password;
	protected $email;
	protected $confirm_password;

	protected $form;

    public function __construct() {

		$this->form = new Form('register', '/classifieds/controller.php?action=Register&event=Submit','POST',
								array('id' => 'register',
									  'onSubmit' => 'return validateRegister()'));
		$this->form->set_title('New User');

		$username = new Input('username', 'text', '', array('id' => 'username'));
		$username->set_label('User Name');
		$this->form->add_element($username);
	
		$password = new Input('password', 'password','',array('id' => 'password'));
		$password->set_label('Password');
		$this->form->add_element($password);


		$confirm_password = new Input('c_password','password','',array('id' => 'c_password'));
		$confirm_password->set_label('Confirm');
		$this->form->add_element($confirm_password);

		$email = new Input('email','text','',array('id'=>'email'));
		$email->set_label('Email');
		$this->form->add_element($email);

		$submit = new Input('submit', 'submit','Register',array('class' => 'submit'));
		$this->form->add_element($submit);
    }
	public static function validate() {
		return $_POST;
	}
    public function get_html_text() {
		return $this->form->get_html_text();
    }
}
?>
