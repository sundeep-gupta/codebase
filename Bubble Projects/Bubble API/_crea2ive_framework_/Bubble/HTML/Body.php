<?php

class Body {
    protected $attr ;
    protected $data;

    public function __construct($attr = null, $data = null) {
    	$this->attr = $attr;
    	$this->data = $data;
    }

    public function get_html_text() {
    	$html_data = '<body ';
    	if ($this->attr != null and is_array($this->attr)) {
    	    foreach ($this->attr as $key => $value) {
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