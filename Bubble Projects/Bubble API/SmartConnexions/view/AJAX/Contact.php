<?php

class ContactAjax {
    public function __construct($attr = array('name'=>'contact',
                               'id' => 'form',
						       'method'=>'POST',
						       )) {

	$this->attr = $attr;
	$this->attr['action'] = 'emailer/emailer.php';
	$this->title = 'Title of the Form';
   }
    public function get_xml() {

	$html = '<form ';
	if ( $this->attr != null) {
	    foreach ($this->attr as $key=>$value) {
		$html .= $key."='".$value."'";
	    }
	}
	$html .= ">\n";
	$html .= '<h1>'.$this->title.'</h1><br/>';
	$html .= '<label for="Name">Your Name <spam class="red">*</spam></label>'."\n";
	$html .= '<div id="d_firstname"><input id="Name" type="text" name="Name" />'.
	    '</div><br/>'."\n";
	$html .= '<label for="Email">Your Email <spam class="red">*</spam></label>'."\n";
	$html .= '<div id="d_email"><input id="Email" type="text" name="Email" /></div><br/>'."\n";
	$html .= '<label for="address">Subject</label>'."\n";
	$html .= '<div id="d_subject"><input id="subject" type="text" name="subject" /></div><br/>'."\n";
	$html .= '<label for="message">Requirements and/or Questions :<span class="red">*</span> </label>'."\n";
	$html .= '<div id="d_message"><textarea cols=40 rows=10 name="message" value=""></textarea></div><br/>';


	$html .= '<input  type="submit" name="personal_details" value="Submit" class="submit"/>';
    $html .= '<input type="reset" name="Reset" value="Clear Form" /><br/><br/>'."\n";
	$html .= '<input type="hidden" name="reply_to_field" value="Email" />';
	$html .= '<input type="hidden" name="required_fields" value="Name,Comments" />';
	$html .= '<input type="hidden" name="required_email_fields" value="Email" />';
	$html .= '<input type="hidden" name="recipient_group" value="0" />';
	$html .= '<input type="hidden" name="error_page" value="" /> ';
	$html .= '<input type="hidden" name="thanks_page" value="" />';
	$html .= '<input type="hidden" name="send_copy" value="no" />';
	$html .= '<input type="hidden" name="copy_subject" value="Subject of Copy Email" />';
	$html .= '<input type="hidden" name="copy_tomail_field" value="Email" >';
	$html .= '<input type="hidden" name="mail_type" value="vert_table" />';
	$html .= '<input type="hidden" name="mail_priority" value="1" />';
	$html .= '<input type="hidden" name="return_ip" value="1" />';

	$html .= '</form>';
	return $html;
    }
}


?>