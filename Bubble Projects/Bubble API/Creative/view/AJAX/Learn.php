<?php
class LearnAjax {
    function __construct() {
      $this->data = '<h1>Welcome to Crea2ive\'s Learning Centre!</h1>

   <p>
<b>FAQs</b> <br /><br />

<b class="q">~What is a domain? What are different types of domains?</b><br />
A: A domain is a root level hierarchical representation of a website. In simple terms the other part of the website name.<br />
Types: .com, .co.uk, .in, .net, .biz, .info, .org, and so on<br />
<br />
<b class="q">~What is web hosting? </b><br />
A: A service which includes maintaining a website for a given period of time with allocated space and domain name. <br />
<br />
<b class="q">~What is web designing?</b><br />
A: Developing a website which includes creating pages, images, graphics and hosting it on the registered web space and domain name. <br />
<br />
<b class="q">~What is a static website?</b> <br />
A: A website with static pages and images. There will be no dynamic content like flash, interactive media, interactive forum etc...<br />
<br />
<b class="q">~What is a Dynamic website?</b> <br />
A: A website with dynamic content like interactive media, flash, movies, music, gaming, forums. <br />
<br />
<b class="q">~Why do I need flash? </b><br />
A: A flash movie/banner/ad garners visitor�s attention and there by passing on the message by the website owner. For example, a flash ad with rotating names of all the services provided or a flashing contact details.<br />
<br />
<b class="q">~What is online contact form?</b><br />
A: An online webpage which allows visitors to enter their contact details and reach out website owner with queries without having to call or visit personally.<br />
<br />
<b class="q">~What is a POP 3 Email ID?</b><br />
A: An email id which carries registered domain name extension and easily accessible by an email client. <br />
For example for a domain name abcinfo.com, Email ID can be created like, info@abcinfo.com <br />
And the emails can be accessed using tools like MS Outlook, Outlook Express or Evolution <br />
<br />
<b class="q">~Why do I need a website? </b><br />
A: Having a website helps in following ways: <br />
<li>Promoting busines
<li>Enabling customers to chose services online
<li>Contact form � Easy to reach
<li>Global presence � Competitive edge
<li>One place to posting news and updates
<li>Build partner network


</p>

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