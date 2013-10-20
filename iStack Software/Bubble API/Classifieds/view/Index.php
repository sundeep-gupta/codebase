<?php
require_once(MVC_LIB.'/Bubble/Classifieds/view/Template.php');
require_once(MVC_LIB.'/Bubble/Classifieds/view/ClassifiedsView.php');

clas IndexView extends ClassifiedsView {
    public function __construct($model) {
	$this->body_text = new ThreePaneMainBody();
	$main_page = new Index($model);
	$this->body_text->set_main_body($main_page);
	parent::__construct($model);
    }

}

class Index extends Div {
    public function __construct($model, $attr=array('id'=> 'main')) {
	parent::__construct($attr);
	$data = '
                     
  <!-- Put your html content BELOW here -->
  Welcome to the home page.  Welcome to the home page.  
  Welcome to the home page.  Welcome to the home page.  
  Welcome to the home page.  Welcome to the home page.  
  Welcome to the home page.  Welcome to the home page.  
  Welcome to the home page.  Welcome to the home page.  
  Welcome to the home page.  Welcome to the home page.  
  Welcome to the home page.  Welcome to the home page.  
  Welcome to the home page.  Welcome to the home page.  
 <!-- Put your html content ABOVE here -->
';
	$this->add_data($data);
    }
}
?>
