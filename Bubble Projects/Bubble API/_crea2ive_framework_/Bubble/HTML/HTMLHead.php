<?php
/*
 * Class for <head> tag and its subcontents
 * This should ideally extend from some base class in future
 * More methods might be needed to add.
 */

class HTMLHead {
    protected $stylesheets ;
    protected $javascript ;
    protected $style = "";
    protected $script = '';

    function __construct(){
	$this->stylesheets = array();
	$this->javascript  = array();
    }

    function add_stylesheet($filename) {

	if (isset($filename) && file_exists($filename))
	    array_push($this->stylesheets, $filename);
    }

    function add_javascript($filename) {

	if (isset($filename) && file_exists($filename))
	    array_push($this->javascript, $filename);
    }

    function add_style($style) {
	$this->style .= "\n";
	$this->style .= $style;
    }


    function add_script($script) {

	$this->script .= "\n";
	$this->script .= $script;
    }


    function add_content_type($mime_type, $charset) {
	if (isset($content_type) && isset($charset)) {
	    $this->content_type = $content_type;
	    $this->charset      = $charset;
	}
    }

    function set_title($title) {
	if (isset($title))
	    $this->title = $title;
    }

    function get_html_text() {
	$html_text  = "<head>\n";
	if (isset($this->content_type) && isset($this->charset)) {
	    $html_text .= "<meta http-equiv='Content-Type' content=".$this->content_type."; charset=".$this->charset.";>\n";
	}
	if (isset($this->title)) {
	    $html_text .= '<title>'.$this->title ."</title>\n";
	}
	if(is_array($this->stylesheets)) {
	    foreach($this->stylesheets as $stylesheet) {
		$html_text .= '<link rel="stylesheet" type="text/css" href="'.$stylesheet."\">\n";
	    }
	}

	if(is_array($this->javascript)) {
	    foreach($this->javascript as $javascript) {
		$html_text .= '<script type="text/javascript" src="'.$javascript.'"> </script>';
	    }
	}

	if ($this->style != '') {
	    $html_text .= "<style type='text/css'>\n".$this->style."</style>";
	}

	if ($this->script != '') {
	    $html_text .= "<script type=text/javascript'>\n".$this->script."\n</script>";
	}
	$html_text .= "</head>\n";
	return $html_text;
    }
}

?>