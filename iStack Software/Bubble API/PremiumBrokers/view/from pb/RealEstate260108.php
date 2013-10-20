<?php
require_once(VIEW.'/HTMLPage.php');
require_once(VIEW.'/Template.php');
require_once(LIB.'/Bubble/HTML/Div.php');


class RealEstateView extends HTMLPage{
    protected $template_body;
    protected $html_head ;
    protected $body ;
    protected $model;
    public function __construct($model) { 
	$this->model = $model;
	$insurance_page  = new RealEstateBody();
	$this->body  = new Body(null, $insurance_page);
	$this->head  = new HTMLHead();
	$this->head->add_stylesheet("images/bubblepb.css");
	$this->head->set_title("---Premiun Brokers---");
	parent::__construct();
    }
    
}

class RealEstateBody extends TemplateView {
    public function __construct() {
	if ($this->main_body == null) {
	    $this->main_body = new RealEstate();
	}
	if ($this->right_menu == null) {
	    $this->right_menu = new RealEstateMenu();
	}
	parent::__construct( array('header' => array('active_menu' => 'Real Estate')), array('id' =>'wrap'));
    }
}

class RealEstate extends Div{
    function __construct($id = 'main') {
	parent::__construct( array('id' => $id));
	$data  = '<img border="0" src="images/UnderConstruction.bmp" width="435" height="356">';
	$data = '<H1>Real Estate&nbsp;at&nbsp;<SPAN class=green>Premium Brokers!!</SPAN> </H1>

<P class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN 
style="FONT-SIZE: 10pt"><FONT color=#000000><FONT face="Times New Roman">We 
serve as a one-stop shop for those looking to own, occupy, invest, lease or sell 
property. We cater to a wide array of real estate needs across all segments in 
the real estate industry. <SPAN 
style="mso-spacerun: yes">&nbsp;</SPAN><o:p></o:p></FONT></FONT></SPAN></P>
<P class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN 
style="FONT-SIZE: 10pt"><o:p><FONT face="Times New Roman" 
color=#000000>&nbsp;</FONT></o:p></SPAN></P>
<P class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN 
style="FONT-SIZE: 10pt"><FONT color=#000000><FONT 
face="Times New Roman">Services Offered<o:p></o:p></FONT></FONT></SPAN></P>
<P class=MsoNormal style="MARGIN: 0in 0in 0pt"><SPAN 
style="FONT-SIZE: 10pt"><o:p><FONT face="Times New Roman" 
color=#000000>&nbsp;</FONT></o:p></SPAN></P>
<P class=MsoNormal 
style="MARGIN: 0in 0in 0pt 0.5in; TEXT-INDENT: -0.25in; mso-list: l0 level1 lfo1; tab-stops: list .5in"><FONT 
color=#000000><SPAN 
style="FONT-SIZE: 10pt; FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; mso-bidi-font-family: Wingdings"><SPAN 
style="mso-list: Ignore">Ø<SPAN 
style="FONT: 7pt \'Times New Roman\'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
</SPAN></SPAN></SPAN><SPAN style="FONT-SIZE: 10pt"><FONT 
face="Times New Roman">Brokerage Services<o:p></o:p></FONT></SPAN></FONT></P>
<P class=MsoNormal 
style="MARGIN: 0in 0in 0pt 0.5in; TEXT-INDENT: -0.25in; mso-list: l0 level1 lfo1; tab-stops: list .5in"><FONT 
color=#000000><SPAN 
style="FONT-SIZE: 10pt; FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; mso-bidi-font-family: Wingdings"><SPAN 
style="mso-list: Ignore">Ø<SPAN 
style="FONT: 7pt \'Times New Roman\'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
</SPAN></SPAN></SPAN><SPAN style="FONT-SIZE: 10pt"><FONT 
face="Times New Roman">Advice on investments in property, with lucrative, fixed 
and safe returns<o:p></o:p></FONT></SPAN></FONT></P>
<P class=MsoNormal 
style="MARGIN: 0in 0in 0pt 0.5in; TEXT-INDENT: -0.25in; mso-list: l0 level1 lfo1; tab-stops: list .5in"><FONT 
color=#000000><SPAN 
style="FONT-SIZE: 10pt; FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; mso-bidi-font-family: Wingdings"><SPAN 
style="mso-list: Ignore">Ø<SPAN 
style="FONT: 7pt \'Times New Roman\'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
</SPAN></SPAN></SPAN><SPAN style="FONT-SIZE: 10pt"><FONT 
face="Times New Roman">Investment 
consultancy<o:p></o:p></FONT></SPAN></FONT></P>

<P class=MsoNormal 
style="MARGIN: 0in 0in 0pt 0.5in; TEXT-INDENT: -0.25in; mso-list: l0 level1 lfo1; tab-stops: list .5in"><FONT 
color=#000000><SPAN 
style="FONT-SIZE: 10pt; FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; mso-bidi-font-family: Wingdings"><SPAN 
style="mso-list: Ignore">Ø<SPAN 
style="FONT: 7pt \'Times New Roman\'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
</SPAN></SPAN></SPAN><SPAN style="FONT-SIZE: 10pt"><FONT 
face="Times New Roman">Property Portfolio Management 
Services<o:p></o:p></FONT></SPAN></FONT></P>
<P class=MsoNormal 
style="MARGIN: 0in 0in 0pt 0.5in; TEXT-INDENT: -0.25in; mso-list: l0 level1 lfo1; tab-stops: list .5in"><FONT 
color=#000000><SPAN 
style="FONT-SIZE: 10pt; FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; mso-bidi-font-family: Wingdings"><SPAN 
style="mso-list: Ignore">Ø<SPAN 
style="FONT: 7pt \'Times New Roman\'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
</SPAN></SPAN></SPAN><SPAN style="FONT-SIZE: 10pt"><FONT 
face="Times New Roman">Commercial Property 
Management<o:p></o:p></FONT></SPAN></FONT></P>
<P class=MsoNormal 
style="MARGIN: 0in 0in 0pt 0.5in; TEXT-INDENT: -0.25in; mso-list: l0 level1 lfo1; tab-stops: list .5in"><FONT 
color=#000000><SPAN 
style="FONT-SIZE: 10pt; FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; mso-bidi-font-family: Wingdings"><SPAN 
style="mso-list: Ignore">Ø<SPAN 
style="FONT: 7pt \'Times New Roman\'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
</SPAN></SPAN></SPAN><SPAN style="FONT-SIZE: 10pt"><FONT 
face="Times New Roman">Residential Property 
Management<o:p></o:p></FONT></SPAN></FONT></P>
<P class=MsoNormal 
style="MARGIN: 0in 0in 0pt 0.5in; TEXT-INDENT: -0.25in; mso-list: l0 level1 lfo1; tab-stops: list .5in"><FONT 
color=#000000><SPAN 
style="FONT-SIZE: 10pt; FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; mso-bidi-font-family: Wingdings"><SPAN 
style="mso-list: Ignore">Ø<SPAN 
style="FONT: 7pt \'Times New Roman\'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
</SPAN></SPAN></SPAN><SPAN style="FONT-SIZE: 10pt"><FONT 
face="Times New Roman">Property maintenance<o:p></o:p></FONT></SPAN></FONT></P>
<P class=MsoNormal 
style="MARGIN: 0in 0in 0pt 0.5in; TEXT-INDENT: -0.25in; mso-list: l0 level1 lfo1; tab-stops: list .5in"><FONT 
color=#000000><SPAN 
style="FONT-SIZE: 10pt; FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; mso-bidi-font-family: Wingdings"><SPAN 
style="mso-list: Ignore">Ø<SPAN 
style="FONT: 7pt \'Times New Roman\'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 

</SPAN></SPAN></SPAN><SPAN style="FONT-SIZE: 10pt"><FONT 
face="Times New Roman">Tenancy management<o:p></o:p></FONT></SPAN></FONT></P>
<P class=MsoNormal 
style="MARGIN: 0in 0in 0pt 0.5in; TEXT-INDENT: -0.25in; mso-list: l0 level1 lfo1; tab-stops: list .5in"><FONT 
color=#000000><SPAN 
style="FONT-SIZE: 10pt; FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; mso-bidi-font-family: Wingdings"><SPAN 
style="mso-list: Ignore">Ø<SPAN 
style="FONT: 7pt \'Times New Roman\'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
</SPAN></SPAN></SPAN><SPAN style="FONT-SIZE: 10pt"><FONT 
face="Times New Roman">Lease negotiations and 
approval<o:p></o:p></FONT></SPAN></FONT></P>
<P class=MsoNormal 
style="MARGIN: 0in 0in 0pt 0.5in; TEXT-INDENT: -0.25in; mso-list: l0 level1 lfo1; tab-stops: list .5in"><FONT 
color=#000000><SPAN 
style="FONT-SIZE: 10pt; FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; mso-bidi-font-family: Wingdings"><SPAN 
style="mso-list: Ignore">Ø<SPAN 
style="FONT: 7pt \'Times New Roman\'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
</SPAN></SPAN></SPAN><SPAN style="FONT-SIZE: 10pt"><FONT 
face="Times New Roman">Disposition strategies / sale 
administration<o:p></o:p></FONT></SPAN></FONT></P>
<P class=MsoNormal 
style="MARGIN: 0in 0in 0pt 0.5in; TEXT-INDENT: -0.25in; mso-list: l0 level1 lfo1; tab-stops: list .5in"><FONT 
color=#000000><SPAN 
style="FONT-SIZE: 10pt; FONT-FAMILY: Wingdings; mso-fareast-font-family: Wingdings; mso-bidi-font-family: Wingdings"><SPAN 
style="mso-list: Ignore">Ø<SPAN 
style="FONT: 7pt \'Times New Roman\'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
</SPAN></SPAN></SPAN><SPAN style="FONT-SIZE: 10pt"><FONT 
face="Times New Roman">Legal advisory services on real estate 
transactions<o:p></o:p></FONT></SPAN></FONT></P><BR> 					';
	$this->add_data($data);
    }
}

class RealEstateMenu extends Div{
    public function __construct($id = 'sidebar') {
	parent::__construct( array('id'=>$id));
	$data = '<ul class="sidemenu">
				<li><a href="controller.php?action=Buy">Buy Property</a></li>
				<li><a href="controller.php?action=Sell">Sell Property</a></li>
				<li><a href="controller.php?action=RentIn">Rent / Lease In</a></li>
				<li><a href="controller.php?action=RentOut">Rent / Lease Out</a></li>
				<li><a href="controller.php?action=Requirement">My Requirements</a></li>
						
			</ul>		
			<h1>Wise Words</h1>
			<p>"Men are disturbed, not by the things that happen,
			but by their opinion of the things that happen."</p> 
			<p class="align-right">- Epictetus</p>';
	$this->add_data($data);
    }
}

?>