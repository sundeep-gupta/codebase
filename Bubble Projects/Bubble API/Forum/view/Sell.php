<?
require_once(VIEW.'/HTMLPage.php');
require_once(VIEW.'/RealEstate.php');
require_once(LIB.'/Bubble/HTML/Div.php');
class SellView extends HTMLPage {
    public function __construct($model) { 
	$index_page  = new SellBody($model);
	$this->body  = new Body(null, $index_page);
	$this->head  = new HTMLHead();
	$this->head->add_stylesheet("images/bubblepb.css");
	$this->head->set_title("---Premiun Brokers---");
	parent::__construct();
    }
}

class SellBody extends RealEstateBody {
    public function __construct($model) {
	$this->main_body = new Sell($model);
	parent::__construct( array('id' =>'wrap'));
    }
}




class Sell extends Div{
    protected $model;
    function __construct($model) {
	parent::__construct( array('id'=> 'main'));

	$this->model = $model;
	$step = $this->model->get_step();
	$data = '';
	if ($step == 1) {
	    $data .= '<form action="controller.php?action=RentOut&event=submit_personal_info" method="POST" >';
	    $data .= '<h1>Sell Property (Step 1 of 2)</h1><br/>';
	    $data .= '<label for="firstname">First Name</label>'."\n";
	    $data .= '<input id="fname" type="text" name="firstname"/><br/>'."\n";
	    $data .= '<label for="lastname">Last Name</label>'."\n";
	    $data .= '<input id="lname" type="text" name="lastname"/><br/>'."\n";
	    $data .= '<label for="address">Address :</label>'."\n";
	    $data .= '<input id="address" type="text" name="address"/><br/>'."\n";
	    $data .= '<label for="phonel">Phone (Landline) :</label>'."\n";
	    $data .= '<input id="phonel" type="text" name="phonel"/><br/>'."\n";
	    $data .= '<label for="phonem">Mobile :</label>'."\n";
	    $data .= '<input id="phonem" type="text" name="phonem"/><br/>'."\n";
	    $data .= '<label for="email">Email :</label>'."\n";
	    $data .= '<input id="email" type="text" name="email"/><br/>'."\n";
	    $data .= '<input  type="submit" name="personal_details" value="next"/><br/>'."\n";
	    $data .= '</form>';
	} elseif ($step == 2) {
	    $data .= '<form action="controller.php?action=RentOut&event=submit_rentout_info" method="POST" >';
	    $data .= '<h1>Rent In Form (Step 2 of 2)</h1><br/>';
	    $data .= '<label for="ptype">Property Type</label>'."\n";
	    $data .= '<input id="fname" type="text" name="ptype"/><br/>'."\n";
	    $data .= '<label for="broom">Bedrooms</label>'."\n";
	    $data .= '<input id="broom" type="text" name="broom"/><br/>'."\n";
 	    $data .= '<label for="area">Area</label>'."\n";
	    $data .= '<input id="area" type="text" name="area"/><br/>'."\n";
	    $data .= '<label for="amount">Amount:</label>'."\n";
	    $data .= '<input id="amount" type="text" name="amount"/><br/>'."\n";
	    $data .= '<label for="floor">Floor:</label>'."\n";
	    $data .= '<input id="floor" type="text" name="floor"/><br/>'."\n";
	    $data .= '<label for="terrace">Terrace:</label>'."\n";
	    $data .= '<input id="terrace" type="text" name="terrace"/><br/>'."\n";
	    $data .= '<input  type="submit" value="Submit"/><br/>'."\n";
	    $data .= '</form>';
	} elseif ($step == 3) {
	    $data = '<p>'.$_SESSION['firstname'].' Your form submitted successfully </p>';
	}

	$this->add_data($data);    
    }

}
?>