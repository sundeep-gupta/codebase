<?php
require_once(VIEW.'/HTMLPage.php');
require_once(VIEW.'/Template.php');
require_once(LIB.'/Bubble/HTML/Div.php');


class TrainingView extends HTMLPage{
    protected $template_body;
    protected $html_head ;
    protected $body ;
    protected $model;
    public function __construct($model) { 
	$this->model = $model;
	$insurance_page  = new TrainingBody();
	$this->body  = new Body(null, $insurance_page);
	$this->head  = new HTMLHead();
	$this->head->add_stylesheet("images/bubblepb.css");
	$this->head->set_title("---Premiun Brokers---");
	parent::__construct();
    }
    
}

class TrainingBody extends TemplateView {
    public function __construct() {
	$this->main_body = new Training();
	parent::__construct( array('header' => array('active_menu' => 'Training')), array('id' =>'wrap'));
    }
}

class Training extends Div{
    function __construct($id = 'main') {
	parent::__construct( array('id' => $id));
	$data  = '<h1>Training</h1>
  
  <p class="style1" text-align: justify; background: white"><strong>Compared to the returns in investment options like banks, 
Govt. bonds and FDIs , the Capital Markets provide great growth prospects and 
opportunities for investors to make good returns with limited calculated risk.
</p>
<p class="style1" text-align: justify; background: white">With 100 crore+ of Indian population only 6 to 8% of 
investors invest in Capital markets. This huge ignorance towards the Capital 
Markets and Financial investments is because of lack of awareness among 
investors about capital markets. Understanding this need, Premium Brokers has 
designed unique courses to make investors better undertand capital markets &amp; do 
wise investments.</p>
<p class="style1">Courses offered:</p>
<table bordercolor="#4284B0" cellspacing="1" cellpadding="1" border="1" style="width: 500; position: relative; height: 746px; top: 15px; left: 10px; z-index: 1;" align="center" class="style1">
	<tr>
		<td style="width: 144px">Title</td>
		<td>Content</td>
	</tr>
	<tr>
		<td style="width: 144px"><strong>Basic Module</strong></td>
		<td>Stock Market basic <br />
		Capital Market <br />
		Indices <br />
		Security Analysis <br />
		Macro-Economics <br />
		Introduction to Technical Analysis <br />
		Introduction to Derivatives <br />
		Demo of actual trading and execution of orders </td>
	</tr>
	<tr>
		<td style="width: 144px"><strong>Advanced Module</strong></td>
		<td>Derivatives Trading <br />
		Futures <br />
		Options <br />
		Premiums <br />
		Standard Premiums (Options) <br />
		Application of Tech. Analysis <br />
		Hedging <br />
		Psychology of Trades <br />
		Top Scrip Trading in F &amp; O <br />
		Classroom Exercises</td>
	</tr>
	<tr>
		<td style="width: 144px"><strong>Professional Module</strong></td>
		<td>Stock selection strategies <br />
		Sources of Information <br />
		Market Analysis <br />
		Balance Sheet Analysis <br />
		Technical Analysis <br />
		Stock Market Cycles <br />
		Macro-Economic factors <br />
		Risk Management</td>
	</tr>
	<tr>
		<td style="width: 144px"><strong>Technical Analysis</strong></td>
		<td>Introduction &amp; Study <br />
		Dow Theory <br />
		Trend &amp; Trend Lines <br />
		Moving Averages <br />
		Japanese Candlesticks Theory <br />
		Price Patterns &amp; Retracements <br />
		Indicators &amp; Oscillators <br />
		Importance of implementing Stop Loss &amp; Stop Loss Levels <br />
		Money management <br />
		Live Practicals <br />
		Trading techniques &amp; systems</td>
	</tr>
</table>

<br/>

<p class="style1">Faculty:</p>
<p class="style1">Classes are conducted by experienced professionals in the 
capital market</p>
<p class="style1"><strong>Pedagogy:</strong></p>
<p class="style1">To make the classroom sessions interactive, effective and 
informative case studies, class discussions, assignments, presentations, etc. 
are used.</p>
<p class="style1">
<a href="http://www.premiumbrokers.co.in/controller.php?action=Contact"><strong>
<span class="style3">Click here</span></strong></a><span class="style3"> to get 
in touch with us for more details. </span></p>
 			';
	$this->add_data($data);
    }
}

?>
