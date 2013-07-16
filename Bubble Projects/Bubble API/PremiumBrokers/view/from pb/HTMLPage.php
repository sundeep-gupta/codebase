<?php

abstract class HTMLPage {
    protected $body;
    protected $head;
    public function __construct() {
	
    }
    public function get_html_text() {
	$html_text = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">';
	$html_text .= $this->head->get_html_text();
	$html_text .= $this->body->get_html_text();
	$html_text .= '</html>';
	return $html_text;
    }
}


class Body {
    protected $attr ;
    protected $data;
    
    public function __construct($attr = null, $data = null) {
	$this->attr = $attr;
	$this->data = $data;
    }
    
    public function get_html_text() {
	$html_data = '<body ';
	if ($this->attr != null and is_array($this->data)) {
	    foreach ($this->data as $key => $value) {
		$html_data .= $key .'="'.$value.'" ';
	    }
	}
	$html_data .= ">\n";
	$html_data .= $this->data->get_html_text();
	$html_data .= '</body>';
	return $html_data;
    }
}

?>