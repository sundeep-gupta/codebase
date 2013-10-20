<?php
require_once(LIB.'/HTML/HTMLPage.php');
require_once(LIB.'/HTML/Body.php');
require_once(VIEW.'/lib/IndexTemplate.php');
require_once(VIEW.'/lib/RightMenu.php');

class IndexAjax {
  protected $data = null;
  function __construct() {
     $this->data = '<h1>SmartconneXions.in</h1>

<img src="images/under-construction.gif">

<h2>A <a href="http://www.crea2ive.com">.Crea2ive.</a> Project</h2>
<span class="icon_mail"><b>info@crea2ive.com</b></span>';
  }
  function get_xml() {
    $xml_text =  "header('Content-Type: text/xml')\n";
    $xml_text .= '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'."\n";
    $xml_text .= "\n";
    $xml_text .= "<response>";
    $xml_text .= $this->data;
    $xml_text .= '</response>';
    return $this->data;
  }
}
?>
