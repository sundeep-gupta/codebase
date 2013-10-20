<?php
/*
 * Pane is nothing but a frame kind of portion of the html page
 * where attr of the pane will be added as attr of either div or the <td> of the 
 * its parent to which it will get added (e.g., ThreePaneHTMLOutput, etc)
 */

class HTMLPane {
    protected $attr;

    function __construct($attr=array()) {
	if(isset($attr) and is_array($attr)) {
	    $this->attr = $attr;
	}
    }
    
    function get_attr_as_string() {
	$text = '';
	if(isset($this->attr) and is_array($this->attr)) {
	    foreach($this->attr as $key=>$value) {
		$text .= " $key='$value' ";
	    }
	}
	return $text;
    }

    function get_html_text() {
	
    }
}




?>