<?php

class ContactForm {
    public function __construct($action, $title, $attr = array('name'=>'contact',
						       'method'=>'POST',
						       'onSubmit' => 'return validateContactUs()')) {
	
	$this->attr = $attr;
	$this->attr['action'] = $action;
	$this->title = $title;
	$this->validater_name = 'validateContactUs';
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
	$html .= '<div id="d_firstname"><input id="firstname" type="text" name="firstname" />'.
	    '</div><br/>'."\n";
	$html .= '<label for="lastname">Last Name <spam class="red">*</spam> </label>'."\n";
	$html .= '<div id="d_lastname"><input id="lastname" type="text" name="lastname" /></div><br/>'."\n";
	$html .= '<label for="phonem">Phone <spam class="red">*</spam></label>'."\n";
	$html .= '<div id="d_phonem"><input id="phonem" type="text" name="phonem" /></div><br/>'."\n";
	$html .= '<label for="email">Email <spam class="red">*</spam></label>'."\n";
	$html .= '<div id="d_email"><input id="email" type="text" name="email" /></div><br/>'."\n";
	$html .= '<label for="address">Subject</label>'."\n";
	$html .= '<div id="d_subject"><input id="subject" type="text" name="subject" /></div><br/>'."\n";
	$html .= '<label for="message">Message <span class="red">*</span> </label>'."\n";
	$html .= '<div id="d_message"><textarea cols=40 rows=10 name="message" value=""></textarea></div><br/>';
	$html .= '<input  type="submit" name="personal_details" value="Submit" class="submit"/><br/><br/>'."\n";
	$html .= '</form>';
	return $html;
    }
/* Function to create JavaScript for Validating Form */

    public function get_validator() {

	$validater = 'function '.$this->validater_name."() { \n";

	$validater .= "\n}";
	return $validater;
    }

}


?>