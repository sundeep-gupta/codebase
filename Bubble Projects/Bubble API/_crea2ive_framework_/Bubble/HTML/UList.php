<?php

class UList {
    protected $attr;
    protected $elements;
    protected $row_index;
    public function __construct($attr = '') {
	if ($attr != '') {
	    $this->attr = $attr;
	}
	$this->row_index = -1;
	$this->elements = array();
    }

    public function add_element( $element_attr = null, 
				$data = null) {
	$element = new UListElement($element_attr, $data);
	array_push($this->elements, $element);
    }

    public function get_html_text() {
	$html_text = '<ul ';
	if ( $this->attr != null) {
	    foreach ($this->attr as $key=>$value) {
		$html_text .= $key."='".$value."' ";
	    }
	}
	$html_text .= ">\n";

	if ($this->elements != null) {
	    foreach($this->elements as $element) {
		$html_text .= $element->get_html_text();
	    }
	}
	$html_text .= '</ul>';
	return $html_text;
    }
}


class UListElement {

    protected $attr;
    protected $data;

    public function __construct($attr = null, $data = null) {
	if ($attr != null) {
	    $this->attr = $attr;
	}
	$this->data = $data;
    }

    public function get_html_text() {
	$html_text = '<li ';

	if($this->attr != null) {
	    foreach($this->attr as $key => $value) {
		$html_text .= $key."='".$value."'";
	    }	    
	}

	$html_text .= ">\n";
	if(isset($this->data) and is_string($this->data)) {
	    $html_text .= $this->data;
	} elseif(isset($this->col_data)) {
	    $html_text .= $this->data->get_html_text();
	}
	$html_text .= "</li>\n";
	return $html_text;
    }

}

?>