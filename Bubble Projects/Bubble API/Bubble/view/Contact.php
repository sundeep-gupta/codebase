<?php
require_once(VIEW.'/HTMLPage.php');
require_once(VIEW.'/Template.php');
require_once(LIB.'/Bubble/HTML/Div.php');
require_once(PB_LIB.'/Bubble/PremiumBrokers/view/ContactForm.php');

class ContactView extends HTMLPage{
    protected $template_body;
    protected $html_head ;
    protected $body ;
    protected $model;
    public function __construct($model) { 
	$this->model = $model;
	$p_contact   = new ContactBody($model);
	$this->body  = new Body(null, $p_contact);
	$this->head  = new HTMLHead();
	$this->head->add_stylesheet("images/bubblepb.css");
	$this->head->add_javascript("images/validate.js");
	$this->head->add_javascript("images/commonValidate.js");
	$this->head->set_title("---Premiun Brokers---");
#	$p_contact->main_body->form->get_validator();
	parent::__construct();
    }
    
}

class ContactBody extends TemplateView {
    public function __construct($model) {
	$this->main_body = new Contact($model);
	parent::__construct( array('header' => array('active_menu' => 'Contact')), array('id' =>'wrap'));
    }
}

class Contact extends Div{
    function __construct($model) {
	parent::__construct( array('id' => 'main'));
	$html = '<h1>Contact <span class="green">us</span></h1>
        <p class="style1"> <strong>
            For your broking, insurance & real estate needs contact us at <a href="mailto:info@premiumbrokers.co.in">info@premiumbrokers.co.in</a>
        </p>
                
        <p class="style1"><strong>Office Address: </strong></p>
<p class="style1"><strong>Premium Brokers</strong><br />
3rd Floor<br />
Choice Apts, Bldg. &quot;C&quot;<br />
Above Featherlite Showroom,<br />
Dhole Patil Road, Pune - 411001 <br/>
Maharashtra <br/>
India <br/>
-----------------------------------------------
</p>
<p class="style1">Ph: +91-20-66034231/66034234 <br/>
Ph: +91-9225547643 <br/>
<a href="http://www.premiumbrokers.co.in">www.premiumbrokers.co.in</a>
</p>';
	$this->form = new ContactForm('controller.php?action=Contact&event=submit', 'Online Contact Form');
	$html .= $this->form->get_html_text();
	$this->add_data($html);
    }
}

?>
