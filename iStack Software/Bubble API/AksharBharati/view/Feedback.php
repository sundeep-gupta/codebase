<?php
require_once(MVC_LIB.'/Bubble/'.PROJECT_NAME.'/view/HTMLPage.php');
require_once(MVC_LIB.'/Bubble/'.PROJECT_NAME.'/view/Template.php');
require_once(LIB.'/Bubble/HTML/Form.php');

class FeedbackView extends HTMLPage{
    protected $template_body;
    protected $html_head ;
    protected $body ;
    protected $model;
    public function __construct($model) { 
		$this->model = $model;
		$index_page  = new FeedbackBody();
		$this->body  = new Body(null, $index_page);
		$this->head  = new HTMLHead();
		$this->head->add_stylesheet("images/bubble_ab.css");
		$this->head->set_title("Akshar Bharati - Home");
		parent::__construct();
    }
    
}

class FeedbackBody extends TemplateView {
    public function __construct() {
	$this->main_body = new Feedback();
	parent::__construct( array('header' => array('active_menu' => 'Home')), 
			     array('id' =>'wrap'));
    }
}

class Feedback extends Div{
    function __construct($id = 'main') {
		parent::__construct( array('id' => $id));
		$form = new FeedbackForm();
		
		$this->add_data($form->get_html_text());
    }
}

class FeedbackForm {

	protected $form;

    public function __construct() {

		$this->form = new Form('feedback', 'controller.php?action=Feedback&event=Submit','POST',
								array('id' => 'feedback',
									  'onSubmit' => 'return validateFeedback()'));
		$this->form->set_title('Feedback Form');

		$name = new Input('name', 'text', '', array('id' => 'name'));
		$name->set_label('Name');
		$this->form->add_element($name);
	
		$ngo = new Input('ngo', 'text','',array('id' => 'ngo'));
		$ngo->set_label('NGO');
		$this->form->add_element($ngo);


		$total_books = new Input('total_books','password','',array('id' => 'total_books'));
		$total_books->set_label('Total Books');
		$this->form->add_element($total_books);

		$circulation = new Input('circulation','text','',array('id'=>'circulation'));
		$circulation->set_label('Circulated Books');
		$this->form->add_element($circulation);

		
		$favourite = new Input('favourite','text','',array('id'=>'favourite'));
		$favourite->set_label('Favourite Category');
		$this->form->add_element($favourite);

		$cat_movement = new Input('cat_movement','text','',array('id'=>'cat_movement'));
		$cat_movement->set_label('Category Movement');
		$this->form->add_element($cat_movement);


		$books_lost = new Input('books_lost','text','',array('id'=>'books_lost'));
		$books_lost->set_label('Books Torn / Lost');
		$this->form->add_element($books_lost);



		$user_base = new Input('user_base','text','',array('id'=>'user_base'));
		$user_base->set_label('User Base');
		$this->form->add_element($user_base);


		$user_edu = new Input('user_edu','text','',array('id'=>'user_edu'));
		$user_edu->set_label('User Education');
		$this->form->add_element($books_lost);

		$activities = new Input('activities','text','',array('id'=>'activities'));
		$activities->set_label('Activities');
		$this->form->add_element($activities);

		$requirement = new Input('requirement','text','',array('id'=>'requirement'));
		$requirement->set_label('Requirement');
		$this->form->add_element($requirement);

		$comments = new Input('comments','text','',array('id'=>'comments'));
		$comments->set_label('Comments');
		$this->form->add_element($comments);


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

