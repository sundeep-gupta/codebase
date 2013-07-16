<?php
/* TODO: This should in future extend FORM */
class AddressBookForm {
    protected $attr ;
    public function __construct($action, $title, $attr = array('name'=>'addressbook',
						       'method'=>'POST',
						       'onSubmit' => 'return validateAddressBook()')) {
	$this->attr = $attr;
	$this->attr['action'] = $action;
	$this->title = $title;

    }
    public function get_html_text() {
	$html = '<form ';
	if ( $this->attr != null) {
	    foreach ($this->attr as $key=>$value) {
		$html .= $key."='".$value."'";
	    }
	}
	$html .= ">\n";
	$html .= '<h1>'.$this->title.'</h1><br/>';
	$html .= '<label for="firstname">First Name <spam class="red">*</spam></label>'."\n";
	$html .= '<div id="d_firstname"><input id="firstname" type="text" name="firstname" title="Enter upto 20 characters" />'.
	    '</div><br/>'."\n";
	$html .= '<label for="lastname">Last Name <spam class="red">*</spam> </label>'."\n";
	$html .= '<div id="d_lastname"><input id="lastname" type="text" name="lastname" /></div><br/>'."\n";
	$html .= '<label for="phonem">Phone <spam class="red">*</spam></label>'."\n";
	$html .= '<div id="d_phonem"><input id="phonem" type="text" name="phonem" /></div><br/>'."\n";
	$html .= '<label for="email">Email <spam class="red">*</spam></label>'."\n";
	$html .= '<div id="d_email"><input id="email" type="text" name="email" /></div><br/>'."\n";
	$html .= '<label for="address">Other Details</label>'."\n";
	$html .= '<div id="d_other"><input id="address" type="text" name="address" /></div><br/>'."\n";
	$html .= '<input  type="submit" name="personal_details" value="Submit" class="submit"/><br/><br/>'."\n";
	$html .= '</form>';
	return $html;
    }
}