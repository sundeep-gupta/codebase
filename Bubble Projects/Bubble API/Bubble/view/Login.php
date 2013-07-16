<?php
require_once(VIEW.'/HTMLPage.php');
require_once(VIEW.'/Template.php');


class LoginView extends HTMLPage{
    protected $template_body;
    protected $html_head ;
    protected $body ;
    protected $model;
    public function __construct($model) { 
	$this->model = $model;
	$index_page  = new LoginBody();
	$this->body  = new Body(null, $index_page);
	$this->head  = new HTMLHead();
	$this->head->add_stylesheet("images/bubblepb.css");
	$this->head->set_title("---Premiun Brokers---");
	parent::__construct();
    }
    
}

class LoginBody extends TemplateView {
    public function __construct() {
	$this->main_body = new Login();
	parent::__construct( array('header' => array('active_menu' => 'Home')), 
			     array('id' =>'wrap'));
    }
}

class Login extends Div{
    function __construct($id = 'main') {
	parent::__construct( array('id' => $id));
	$data = '<form action="controller.php?action=Login&event=Authenticate" method="POST">
	<h1>Authorization <span class="green">Required<span></br></h1>
        <p>This page has restricted access. Please enter the password below to login.</p>

	<label for="password">Password </label><input type="password" id="password" name="password"/><br/>
	<input type="submit" value="Login" class="submit">
	<input type="hidden" name="sub" value="sub">
        <input type="hidden" name="presenter" value="'.$_SERVER['REQUEST_URI'].'"><div class=error>'.$msg.'</div>	</form>';
	$this->add_data($data);
    }
}
?>