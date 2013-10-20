<?php
class PortfolioAjax {
    function __construct($id = 'main') {
      $this->data = '<h1>Few of our recent projects...</h1>
               <hr>
               <table>
               <tr>
               <td>
                 <h3><a href="http://www.aksharbharati.org" target="_blank">Akshar Bharati (http://www.aksharbharati.org)</a></h3>
                 <a href="http://www.aksharbharati.org" target="_blank"><img src="images/ab.jpg"></a>

                 <p>This website represents an NGO working towards child education & empowerment. The site has following content:<br />
                    1. Web pages with static information (<a href="http://www.aksharbharati.org" target="_blank">http://www.aksharbharati.org</a>) <br />
                    2. Dynamic community forum (<a href="http://www.aksharbharati.org/drupal" target="_blank">http://www.aksharbharati.org/drupal/</a>)
                    <br />3. Flash banner.
              </td>
              </tr><tr>
                <td>
  <hr>
  <h3><a href="http://www.premiumbrokers.co.in" target="_blank">Premium Brokers (http://www.premiumbrokers.co.in)</a></h3>
  <a href="http://www.premiumbrokers.co.in" target="_blank"><img src="images/pb.jpg"></a>
  <p>This website represents a Broking & Trading company. This website has following content:<br />
  1. A news scroller<br />
  2. A flash banner (title)<br />
  3. Address book<br />
  4. Rent IN/OUT, Buy/Sell online forms (<a href="http://premiumbrokers.co.in/controller.php?action=RealEstate" target="_blank">Real Estate</a>)<br />
  5. Easy to update & upload interface
  </td>
  </tr>

  <tr>
  <td>
  <hr>
  <h3><a href="http://www.doorsteptaxi.com" target="_blank">Doorsteptaxi (http://www.doorsteptaxi.com)</a></h3>
  <a href="http://www.doorsteptaxi.com" target="_blank"><img src="images/dt.jpg"></a>
  <p>This website represents a Private Hire Taxi group. This website has following content:<br />
  1. Static webpages<br />
  2. A Contact form<br />
  </td>
  </tr>

  <tr>
  <td>
  <hr>
  <h3><a href="http://www.insha.in" target="_blank">Insha.in (http://www.insha.in)</a></h3>
  <a href="http://www.insha.in" target="_blank"><img src="images/insha.jpg"></a>
  <p>This is a personal portal with dynamic content. This website has following content:<br />
  1. Static webpages<br />
  2. Flash Menu<br />
  3. Blog platform (<a href="http://blog.insha.in" target="_blank">http://blog.insha.in</a>) <br />
  4. Picture Gallery (<a href="http://reflections.insha.in" target="_blank">http://reflections.insha.in</a>) <br />
  5. A Contact form <br />
  <hr>
  </td>
  </tr>


  </table>
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
