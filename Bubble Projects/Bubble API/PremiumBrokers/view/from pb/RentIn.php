<?
require_once(LIB.'/Bubble/HTML/Div.php');
require_once(VIEW.'/HTMLPage.php');
require_once(VIEW.'/RealEstate.php');
require_once(LIB.'/Bubble/HTML/HTMLHead.php');

class RentInView extends HTMLPage {
    public function __construct($model) { 

	$index_page  = new RentInBody($model);
	$this->body  = new Body(null, $index_page);

	$this->head  = new HTMLHead();
	$this->head->add_stylesheet("images/bubblepb.css");
	$this->head->set_title("---Premiun Brokers---");
	parent::__construct();
    }
}

class RentInBody extends TemplateView {
    public function __construct($model) {
	$this->main_body = new RentIn($model);
	$this->right_menu = new RealEstateMenu();
	parent::__construct( array('header' => array('active_menu' => 'Real Estate')), array('id' =>'wrap'));
    }
}


class RentIn extends Div {
    function __construct($modell) {
	parent::__construct( array('id'=>'main2' ));

	    $data = '<table id="board-head">
<tr>
	<th width="15%" colspan="2">Title</th>
	<th width="40%" align="left">Description</th>
	<th width="20%" align="center">	Location</th>
	<th width="25%" align="center">	Vendor Comments</th>
</tr><tr>
    <td class="windowbg2" valign="middle" align="center" width="3%">
        <img src="http://www.bubble.co.in/yabbfiles/Templates/Forum/default/thread.gif" alt="" title=""/>
    </td>
    <td class="windowbg" valign="middle"  align="left" width="12%">
         3 BHK Flat for Sale
    </td>
    <td class="windowbg" valign="middle"  align="left" width="40%">
    <div style="float: left; width: 95%;"> 	
      Flat For Sale - Area app. 1200 sq.ft . Located in one of the most sought after societies in Koregaon Park..  Excellent quality of construction ,all amenities, enhanced by beautiful land-scaping.  Situated in the  serene and peaceful heart of Koregaon Park , yet conveniently  located. 
    </div>
    <div style="float: left; width: 5%; text-align: center;"></div>
    </td>
    <td class="windowbg2" valign="middle" align="center" width="20%">
            Koregaon Park
    </td>
    <td class="windowbg2" valign="middle" align="center" width="25%">
         Constructed 2 Years back
     </td>
  </tr>	
</table>';
	$this->add_data($data);    
    }

}

?>