<?
# This should extend some base class
class ThreePaneHTMLOutput {
    protected $html;
    protected $head;
    protected $body;
    protected $header;
    protected $panes; # Array for 3 panes
    protected $footer;
    protected $state; # Holds the state of the output
    protected $page_properties;


    function __construct($html_params = '') {
	if (isset($html_params) && $html_params != '') {
	    $this->html .= $html_params;
	}
    }
    public function set_body_attr($attr) {
	if(is_array($attr)) {
	    $this->body = ' ';
	    foreach($attr as $key=>$value) {
		$this->body .= "$key='$value' ";
	    }
	}
    }
    
    public function set_head($head) {
	/*
         * if head is an object (of Type XYZ)
         */
	if(isset($head) && is_object($head)) {
	    $this->head = $head;
	}
    }
    
    /* 
     * Function to describe the properties of the page
     * These properties will be used for the root <table> 
     */
    public function set_page_properties($properties) {
	if(isset($properties) and is_array($properties)) {
	    $self->page_properties = $properties;
	}
    }
    
    protected function get_page_properties_as_string() {
	if(isset($self->page_properties) and is_array($this->properties)) {
	    $text = ' ';
	    foreach($self->properties as $key=>$value) {
		$text .= "$key='$value' ";
	    }
	}
    }


    /* 
     * Function to show the Header of the web page
     */
    public function set_header($header) {
	if(isset($header) && is_object($header)) {
	    $this->header = $header;
	}
    }
    
    public function set_footer($footer) {
	if(isset($footer) && is_object($footer)) {
	    $this->footer = $footer;
	}
    }
    
    public function get_html_text() {

	$html_text = '<!doctype html public "-//W3C//DTD HTML 4.01 Transitional//EN"';
	$html_text .= '<html'. ($html)?" $html_params>" : '>';
	if(isset($head) && is_object($head)) {
	    $html_text .= $head->get_html_text();
	}

	$html_text .= '<body';
	#
	# Set the params of body tag
	#
	$html_text .= ($this->body)?$this->body.">\n" :">\n";
	$html_text .= "<div align='center'>\n";
	
	#
	# Construct the table for the page (divided into 3 panes + header and footer)
	#
	$html_text .= "<table";
	$html_text .= $self->get_page_properties_as_string();
	$html_text .= ">\n";
	
	#
	# This adds a row for Header
	#
	$html_text .= "<tr>\n<td colspan='3' ";
	$html_text .= $header->get_attr_as_string();
	$html_text .= ">";
	$html_text .= $header->get_html_text();
	$html_text .= "</td></tr>";
	
	#
	# Second row of table which has 3 cols
	#
	$html_text .= "<tr>\n";

	#
        # First of the three panes
	#
	$html_text .= '<td ';
	$html_text .= $left_pane->get_attr_as_string();
	$html_text .= ">\n";
	$html_text .= $left_pane->get_html_text();
	$html_text .= "</td>\n";

	#
        # second of the three panes
	#
	$html_text .= '<td ';
	$html_text .= $middle_pane->get_attr_as_string();
	$html_text .= ">\n";
	$html_text .= $middle_pane->get_html_text();
	$html_text .= "</td>\n";	

        #
        # Third  of the three panes
	#
	$html_text .= '<td ';
	$html_text .= $right_pane->get_attr_as_string();
	$html_text .= ">\n";
	$html_text .= $right_pane->get_html_text();
	$html_text .= "</td>\n";

	#
	# End of second row (3 panes added)
	#
	$html_text .= "</tr>\n";


	#
	# This adds a row for Footer
	#
	$html_text .= "<tr>\n<td colspan='3' ";
	$html_text .= $footer->get_attr_as_string();
	$html_text .= ">";
	$html_text .= $footer->get_html_text();
	$html_text .= "</td></tr>";

	$html_text .= "</table>\n";
	$html_text .= "</div>\n";
        $html_text .= '</body>';
	$html_text .= '</html>';

	return $html_text;
    }

}