<?php
require_once(VIEW.'/HTMLPage.php');
require_once(VIEW.'/Template.php');
require_once(LIB.'/Bubble/HTML/Div.php');


class BrokingView extends HTMLPage{
    protected $template_body;
    protected $html_head ;
    protected $body ;
    protected $model;
    public function __construct($model) { 
	$this->model = $model;
	$insurance_page  = new BrokingBody();
	$this->body  = new Body(null, $insurance_page);
	$this->head  = new HTMLHead();
	$this->head->add_stylesheet("images/bubblepb.css");
	$this->head->set_title("---Premiun Brokers---");
	parent::__construct();
    }
    
}

class BrokingBody extends TemplateView {
    public function __construct() {
	$this->main_body = new Broking();
	parent::__construct( array('header' => array('active_menu' => 'Broking')), array('id' =>'wrap'));
    }
} 

class Broking extends Div{
    function __construct($id = 'main') {
	parent::__construct( array('id' => $id));

	$data = '<H1>Financial Services at&nbsp;<SPAN class=green>Premium Brokers!!</SPAN> </H1>
<P class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN 
style="FONT-SIZE: 10pt"><o:p><FONT face="Times New Roman" 
color=#000000></FONT></o:p></SPAN>&nbsp;</P><SPAN style="FONT-SIZE: 10pt"><FONT 
color=#000000><FONT face="Times New Roman">
<P class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN 
style="FONT-SIZE: 10pt">Services Offered<o:p></o:p></SPAN></P>
<P class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN 
style="FONT-SIZE: 10pt"><o:p>&nbsp;</o:p></SPAN></P>
<P class=MsoNormal 
style="MARGIN: 0in 0in 0pt 0.5in; TEXT-INDENT: -0.25in; mso-list: l0 level1 lfo1; tab-stops: list .5in"><SPAN 
style="FONT-SIZE: 10pt; FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; mso-bidi-font-family: Wingdings"><SPAN 
style="mso-list: Ignore">Ø<SPAN 
style="FONT: 7pt \'Times New Roman\'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
</SPAN></SPAN></SPAN><SPAN style="FONT-SIZE: 10pt"><SPAN 
style="mso-spacerun: yes">&nbsp;</SPAN>Equity<o:p></o:p></SPAN></P>
<P class=MsoNormal 
style="MARGIN: 0in 0in 0pt 0.5in; TEXT-INDENT: -0.25in; mso-list: l0 level1 lfo1; tab-stops: list .5in"><SPAN 
style="FONT-SIZE: 10pt; FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; mso-bidi-font-family: Wingdings"><SPAN 
style="mso-list: Ignore">Ø<SPAN 
style="FONT: 7pt \'Times New Roman\'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
</SPAN></SPAN></SPAN><SPAN style="FONT-SIZE: 10pt"><SPAN 
style="mso-spacerun: yes">&nbsp;</SPAN>Derivatives<o:p></o:p></SPAN></P>
<P class=MsoNormal 
style="MARGIN: 0in 0in 0pt 0.5in; TEXT-INDENT: -0.25in; mso-list: l0 level1 lfo1; tab-stops: list .5in"><SPAN 
style="FONT-SIZE: 10pt; FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; mso-bidi-font-family: Wingdings"><SPAN 
style="mso-list: Ignore">Ø<SPAN 
style="FONT: 7pt \'Times New Roman\'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
</SPAN></SPAN></SPAN><SPAN style="FONT-SIZE: 10pt"><SPAN 
style="mso-spacerun: yes">&nbsp;</SPAN>IPO<o:p></o:p></SPAN></P>
<P class=MsoNormal 
style="MARGIN: 0in 0in 0pt 0.5in; TEXT-INDENT: -0.25in; mso-list: l0 level1 lfo1; tab-stops: list .5in"><SPAN 
style="FONT-SIZE: 10pt; FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; mso-bidi-font-family: Wingdings"><SPAN 
style="mso-list: Ignore">Ø<SPAN 
style="FONT: 7pt \'Times New Roman\'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 

</SPAN></SPAN></SPAN><SPAN style="FONT-SIZE: 10pt"><SPAN 
style="mso-spacerun: yes">&nbsp;</SPAN>Mutual Funds<o:p></o:p></SPAN></P>
<P class=MsoNormal 
style="MARGIN: 0in 0in 0pt 0.5in; TEXT-INDENT: -0.25in; mso-list: l0 level1 lfo1; tab-stops: list .5in"><SPAN 
style="FONT-SIZE: 10pt; FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; mso-bidi-font-family: Wingdings"><SPAN 
style="mso-list: Ignore">Ø<SPAN 
style="FONT: 7pt \'Times New Roman\'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
</SPAN></SPAN></SPAN><SPAN style="FONT-SIZE: 10pt"><SPAN 
style="mso-spacerun: yes">&nbsp;</SPAN>Depository Services<o:p></o:p></SPAN></P>
<P class=MsoNormal 
style="MARGIN: 0in 0in 0pt 0.5in; TEXT-INDENT: -0.25in; mso-list: l0 level1 lfo1; tab-stops: list .5in"><SPAN 
style="FONT-SIZE: 10pt; FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; mso-bidi-font-family: Wingdings"><SPAN 
style="mso-list: Ignore">Ø<SPAN 
style="FONT: 7pt \'Times New Roman\'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
</SPAN></SPAN></SPAN><SPAN style="FONT-SIZE: 10pt"><SPAN 
style="mso-spacerun: yes">&nbsp;</SPAN>PMS<o:p></o:p></SPAN></P>
<P class=MsoNormal 
style="MARGIN: 0in 0in 0pt 0.5in; TEXT-INDENT: -0.25in; mso-list: l0 level1 lfo1; tab-stops: list .5in"><SPAN 
style="FONT-SIZE: 10pt; FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; mso-bidi-font-family: Wingdings"><SPAN 
style="mso-list: Ignore">Ø<SPAN 
style="FONT: 7pt \'Times New Roman\'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
</SPAN></SPAN></SPAN><SPAN style="FONT-SIZE: 10pt"><SPAN 
style="mso-spacerun: yes">&nbsp;</SPAN>Commodities<o:p></o:p></SPAN></P>
<P class=MsoNormal 
style="MARGIN: 0in 0in 0pt"></FONT></FONT></SPAN></P><BR>';
	$this->add_data($data);
    }
}

?>