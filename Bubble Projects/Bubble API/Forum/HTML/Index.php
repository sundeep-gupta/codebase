<?php
require_once(LIB.'/Bubble/HTML/Div.php');
class Index extends Div{
    function __construct($id = 'main') {
	parent::__construct( array('id' => $id));
	$data = '<a name="TemplateInfo"></a>
	         <h1>Welcome to <span class="green">Premium Brokers web portal</span></h1>
		 <p>Provide customized Investment advisory and training services to the investors
                    for creating, growing &amp; maintaining their wealth by offering
                    diversified investment options like equity, real estates, bullions and
                    other financial products. </p>
                 <p>Work on a bottom up medium to long term investment strategy so as to try and nullify the
                    volatility of the markets to give a continuous and steady return. </p>
                 <p> The exposure too is limited to 8 to 10 Stocks &amp; Mutual funds for effective fund management</p>';
	$this->add_data($data);
    }
}
?>