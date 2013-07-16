<?php
 class Div {
    protected $attr;
    protected $data;

    public function __construct($attr = array(), $data = array()) {
	# TODO: Invalidate if attr and data are not of array type
	$this->attr = $attr;
	$this->data = $data;
    }

    public function add_data($data = '') {
    	array_push($this->data, $data);
    }
    public function set_data($data = '') {
      $this->data = array($data);
    }
    public function get_html_text() {
	$html_text = '<div ';
	if ( $this->attr != null) {
	    foreach ($this->attr as $key=>$value) {
		$html_text .= $key."='".$value."'";
	    }
	}
	$html_text .= ">\n";
	if ($this->data != null) {
	    foreach($this->data as $row) {
		if (is_string($row)) {
		    $html_text .= $row;
		} else {
		    $html_text .= $row->get_html_text();
		}
	    }
	}
	$html_text .= '</div>';
	return $html_text;
    }
    

}

?>