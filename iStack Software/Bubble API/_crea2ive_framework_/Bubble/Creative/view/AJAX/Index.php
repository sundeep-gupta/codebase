<?php
require_once(LIB.'/HTML/HTMLPage.php');
require_once(LIB.'/HTML/Body.php');
require_once(VIEW.'/lib/IndexTemplate.php');
require_once(VIEW.'/lib/RightMenu.php');

class IndexAjax {
  protected $data = null;
  function __construct() {
     $this->data = '<h1>Welcome to Crea2ive World!</h1>
     <p>
    <b>Crea2ive</b> is a figment of bunch of folks who couldn\'t suppress their appetite for web technologies! <br />It\'s a group of creative, innovative and passionate nerds focussing on delivering <b>Concise, Efficient, Optimized, Elegant and Cost effective solutions</b> in a quickest possible time frame.

    <br /><br />Our experience dates back to 2002 when we launched our first website. Then on we have developed various web solutions either directly or indirectly as freelancing group.
    <br /><br /><a href="portfolio.html">Click here to check our recent projects</a>
    <br /><br /><b>Our expertise includes:</b>
    <li>Developing Flash content
    <li>Designing custom templates
    <li>Logo designing
    <li>Implementing community forums
    <li>Implementing Picture Gallery
    <li>Configuring blog platform
    <li>Database profiling
    <li>Creating custom processing forms
    <li>Hosting Support
    <li>Renewal support
    <li>Website migration support
    <li>Developing interactive content
    <li>Search Engine Submission
    <li>Website marketing solutions

    <br /><br />
    <a href="services.html">Click here to check our web designing plans/offers</a> <br />
    <a href="contact.php">Click here to reach us for a custom quote </a> <br />
    <br />
    <p class="pline">All our projects are backed by content update support, renewal support and migration support.</p> <br />

    When we say <b>Cost effective solution</b> what we mean is, we are not selling you anything rather we are a group of enthusiasts trying to help you to establish global presence. Hence we will thoroughly analyze your requirements and suggest you the least expensive and concise solution. Based on standard requirements and type of existing business solutions we have already classified set of plans to help you decide.
    <br /><br />
    Also, we will do our part of technical work without overloading you with unnecessary technical jargons. To help you understand in simple terms we\'ll handover a custom made FAQ/Development plan for follow up. You can as well check FAQ page in <b>Crea2ive\'s</b> <a href=learn.html>Learning centre!</a>

       </p>';
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
