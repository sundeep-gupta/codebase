<?php
require_once(VIEW.'/HTMLPage.php');
require_once(VIEW.'/Template.php');
require_once(LIB.'/Bubble/HTML/Div.php');

class ContactView extends HTMLPage{
    protected $template_body;
    protected $html_head ;
    protected $body ;
    protected $model;
    public function __construct($model) { 
	$this->model = $model;
	$insurance_page  = new ContactBody();
	$this->body  = new Body(null, $insurance_page);
	$this->head  = new HTMLHead();
	$this->head->add_stylesheet("images/bubblepb.css");
	$this->head->set_title("---Premiun Brokers---");
	parent::__construct();
    }
    
}

class ContactBody extends TemplateView {
    public function __construct() {
	$this->main_body = new Contact();
	parent::__construct( array('id' =>'wrap'));
    }
}

class Contact extends Div{
    function __construct($id = 'main') {
	parent::__construct( array('id' => $id));
	$data = '<p><b>Contact Premium Brokers</b></p>
        <p style="color: black;">
            For assistance in asset management and investment in Indian market, expert training on stock market and mutual funds, getting better returns with best customers for your property. contact us at, <a href="mailto:info@premiumbrokers.co.in">info@premiumbrokers.co.in</a>
        </p>
        <p style="color: black;">
            For any other information or queries write to us at <a href="mailto:query@premiumbrokers.co.in">query@premiumbrokers.co.in</a>
        </p>
        <form method=POST action="controller.php?action=Contact&event=submit">
          <table align=center width=90% cellpadding=3>
                <tr>
                    <td >Name</td>
                    <td>
                        <input type=text size=30 name="name" value=""/>
                    </td>
                </tr>
                <tr>
                    <td >Email</td>
                    <td>
                        <input type=text size=40 name="mail" value=""/>
                    </td>
                </tr>
                <tr>
                    <td >Phone (M)</td>
                    <td>
                        <input type=text size=15 name="phonem" value=""/>
                    </td>
                </tr>
                <tr>
                    <td >Phone (L)</td>
                    <td>
                        <input type=text size=15 name="phonel" value=""/>
                    </td>
                </tr>
                <tr>
                    <td >Subject</td>
                    <td>
                        <input type="text" size=40 name="subject" value=""></input>
                    </td>
                </tr><tr>
                    <td  valign="center">Your Message</td>
                    <td>
                        <textarea cols=40 rows=10 name="message" value=""></textarea>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td align=center>
                        <input type=submit value=submit></input>
                    </td>
                </tr>
            </table>
        </form>';
	$this->add_data($data);
    }
}

?>