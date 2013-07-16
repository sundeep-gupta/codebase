<?php
class ServicesAjax {
    function __construct($id = 'main') {
      $this->data = '   <h1>Crea2ive Services!</h1>

   <h1>Our existing plans and offers:</h1>

  <div id="cdata1">
  <b>Commercial Plans - Suitable for Shops, Restaurants, Companies & SMEs</b>
  <hr>
   <div id="cdata1l">
  <p>
<b>CS-1</b>
<li>3 Static webpages
<li>Unlimited POP 3 Email Ids
<li>Free domain name
<li>Web hosting for 1 Year
<li>Submission to Search Engines
<li>Performance Optimization
<li>Online Contact form
   </p>
   </div>

   <div id="cdata1r">
   <p>
   <b>CS-2</b>
<li>5 Static webpages
<li>Flash banner/Ad
<li>Dynamic News Scroll
<li>Unlimited POP 3 Email Ids
<li>Free domain name
<li>Web hosting for 1 Year
<li>Submission to Search Engines
<li>Performance Optimization
<li>Online Contact form
   </p>
   </div>
   </div>




 <div id="cdata2">
  <b>Home Plans - Suitable for Personal & Group portals</b>
  <hr>
   <div id="cdata2l">
  <p>
<b>HM-1</b>
<li>5 Static webpages
<li>Unlimited POP 3 Email Ids
<li>Picture Gallery
<li>Guest Book
<li>Free domain name
<li>Web hosting for 1 Year
<li>Submission to Search Engines
<li>Performance Optimization

   </p>
   </div>

   <div id="cdata2r">
   <p>

<b>HM-2</b>
<li>Unlimited Static webpages
<li>Unlimited POP 3 Email Ids
<li>Picture Gallery
<li>Blog platform
<li>Free domain name
<li>Web hosting for 1 Year
<li>Submission to Search Engines
<li>Performance Optimization
<li>Online Contact form
   </p>
   </div>
   </div>



';
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
