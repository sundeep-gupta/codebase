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
	$data  = '<h1>Training at <span class="green">Premium Brokers!!</span></h1>
  
  <p class="style1">Compared to the returns in investment options like banks, 
Govt. bonds and FDIs , the Capital Markets provide great growth prospects and 
opportunities for investors to make good returns with limited calculated risk.
</p>
<p class="style1">With 100 crore + of Indian population only 6 to 8% of 
investors invest in Capital markets. This huge ignorance towards the Capital 
Markets and Financial investments is because of lack of awareness among 
investors about capital markets. Understanding this need, Premium Brokers has 
designed unique courses to make investors better undertand capital markets &amp; do 
wise investments.</p>
<p class="style1"><strong>Courses offered:</strong></p>
<p class="style1"><strong>Basic Module:</strong></p>
<ul>
	<li class="style1">Stock Market basic</li>
	<li class="style1">Capital Market</li>
	<li class="style1">Indices</li>
	<li class="style1">Security Analysis</li>
	<li class="style1">Macro-Economics</li>
	<li class="style1">Introduction to Technical Analysis</li>
	<li class="style1">Introduction to Derivatives</li>
	<li class="style1">Demo of actual trading and execution of orders</li>
</ul>
<p class="style1"><strong>Advanced Module:</strong></p>
<ul>
	<li class="style1">Derivatives Trading</li>
	<li class="style1">Futures</li>
	<li class="style1">Options</li>
	<li class="style1">Premiums</li>
	<li class="style1">Standard Premiums (Options)</li>
	<li class="style1">Application of Tech. Analysis</li>
	<li class="style1">Hedging</li>
	<li class="style1">Psychology of Trades</li>
	<li class="style1">Top Scrip Trading in F &amp; O</li>
	<li class="style1">Classroom Exercises</li>
</ul>
<p class="style1"><strong>Professional Module:</strong></p>
<ul>
	<li class="style1">Stock selection strategies</li>
	<li class="style1">Sources of Information</li>
	<li class="style1">Market Analysis</li>
	<li class="style1">Balance Sheet Analysis</li>
	<li class="style1">Technical Analysis</li>
	<li class="style1">Stock Market Cycles</li>
	<li class="style1">Macro-Economic factors</li>
	<li class="style1">Risk Management</li>
</ul>
<p class="style1"><strong>Technical Analysis:</strong></p>
<ul>
	<li class="style1">Introduction &amp; Study</li>
	<li class="style1">Dow Theory</li>
	<li class="style1">Trend &amp; Trend Lines</li>
	<li class="style1">Moving Averages</li>
	<li class="style1">Japanese Candlesticks Theory</li>
	<li class="style1">Price Patterns &amp; Retracements</li>
	<li class="style1">Indicators &amp; Oscillators</li>
	<li class="style1">Importance of implementing Stop Loss &amp; Stop Loss Levels</li>
	<li class="style1">Money management</li>
	<li class="style1">Live Practicals</li>
	<li class="style1">Trading techniques &amp; systems</li>
</ul>
<p class="style1"><strong>Faculty:</strong></p>
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
