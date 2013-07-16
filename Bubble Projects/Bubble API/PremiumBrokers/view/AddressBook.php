<?php
require_once(VIEW.'/HTMLPage.php');
require_once(VIEW.'/Template.php');
require_once(LIB. '/Bubble/HTML/HTMLTable.php');
require_once(PB_LIB.'/Bubble/PremiumBrokers/view/AddressBookForm.php');


class AddressBookView extends HTMLPage{
    protected $template_body;
    protected $html_head ;
    protected $body ;
    protected $model;
    public function __construct($model) { 
	$this->model = $model;
	$index_page  = new AddressBookBody($model);
	$this->body  = new Body(null, $index_page);
	$this->head  = new HTMLHead();
	$this->head->add_stylesheet("images/bubblepb.css");
	$this->head->add_javascript("images/commonValidate.js");
	$this->head->add_javascript("images/validate.js");
	$this->head->set_title("---Premiun Brokers---");
	parent::__construct();
    }
    
}

class AddressBookBody extends TemplateView {
    public function __construct($model) {
	$this->main_body = new AddressBook($model);
	parent::__construct( array('header' => array('active_menu' => 'Home')), 
			     array('id' =>'wrap'));
    }
}

class AddressBook extends Div{
    protected $model ;
    function __construct($model) {
	parent::__construct( array('id' => 'main'));
	$data = '';
	$this->model = $model;
	$contacts = $this->model->get_contacts();
	if (count($contacts) <= 0) {
	    $data .= '<div style="background: #FAFAFA; align:center; width:\'90%\';">No contacts added in address book</div>';
	}
	$form = new AddressBookForm( 'controller.php?action=AddressBook&event=add_contact','Add Contact');
	$data .= $form->get_html_text();
	if(count($contacts) > 0 ) {
	    $data .= '<form name="contacts" action="controller.php?action=AddressBook&event=send_mail" method="POST" >';
	    $data .= '<h1>Send Message</h1>';
	    $data .= '<div style="height:10em; overflow:scroll; overflow-x: hidden; ">';
	    
	    $contact_table = new HTMLTable(array('id'=>'board-head'));
	    $contact_table->add_header_row();
	    $contact_table->add_header_column( array('width'=>'25%', 'colspan'=>'2'), 'Name');
	    $contact_table->add_header_column( array('width'=>'20%', 'align'=>'left'), 'Phone');
	    $contact_table->add_header_column( array('width'=>'25%', 'align'=>'center'), 'E-Mail');
	    $contact_table->add_header_column( array('width'=>'30%', 'align'=>'center'), 'Other Details');

	    foreach ($contacts as $contact) {
		$contact_table->add_row( array('bgcolor'=>'#00FF00'));
		$contact_table->add_column( array(
						  'valign'=>"middle", 
						  'align'=>"center",
						  'width'=>"4%"),
					    '<input type="checkbox" id="contact" name="contact[]" value="'.$contact['id'].'" ></input>');
		$contact_table->add_column( array('class'=>"windowbg2",
						  'valign'=>"middle", 
						  'align'=>"left",
						  'width'=>"21%"),
					    $contact['name']);
		$contact_table->add_column( array( 'valign'=>"middle", 
						  'align'=>"center",
						  'width'=>"20%"), 
					    $contact['phone']);
		$contact_table->add_column( array('valign'=>"middle", 
						  'align'=>"left",
						  'width'=>"25%"),
					    $contact['email']);
		$contact_table->add_column( array( 'valign'=>"middle", 
						  'align'=>"left",
						  'width'=>"30%"),
					    $contact['address']);
	    }
	    $data .= $contact_table->get_html_text();
	    
	    $data .='</div><br/>';
	    
	    $data .= '<label for="selectall">Select All</label>';
	    $data .= '<input type="checkbox" id="selectall" name="selectall" onclick="select_all(this.form.contact, this)"/><br/>';
	    
	    $data .= '<label for="message">Your Message here</label>';
	    $data .= '<textarea class="message" id="message" name="message" ></textarea><br/>';
	    
	    $data .= '<input class="submit" type="submit" value="Send Message"/>';	
	    $data .= '<input class="button" type="submit" value="Delete" onClick="return deleteContacts(this.form)"/>';
	    
	    $data .= '</form>';
	}        
	$this->add_data($data);
    }

}
?>