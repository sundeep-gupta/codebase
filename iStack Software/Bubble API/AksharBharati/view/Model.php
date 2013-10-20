<?php
require_once(MVC_LIB.'/Bubble/'.PROJECT_NAME.'/view/HTMLPage.php');
require_once(MVC_LIB.'/Bubble/'.PROJECT_NAME.'/view/Template.php');

class ModelView extends HTMLPage{
    protected $template_body;
    protected $html_head ;
    protected $body ;
    protected $model;
    public function __construct($model) { 
		$this->model = $model;
		$index_page  = new ModelBody();
		$this->body  = new Body(null, $index_page);
		$this->head  = new HTMLHead();
		$this->head->add_stylesheet("images/bubble_ab.css");
		$this->head->set_title("Akshar Bharati - Home");
		parent::__construct();
    }
    
}

class ModelBody extends TemplateView {
    public function __construct() {
	$this->main_body = new Model();
	parent::__construct( array('header' => array('active_menu' => 'Home')), 
			     array('id' =>'wrap'));
    }
}

class Model extends Div{
    function __construct($id = 'main') {
		parent::__construct( array('id' => $id));
		$data = '	<p class="style2" align="justify"><strong>Working Model</strong></p>
	<p class="style3" align="justify">
	<img alt="" src="images/workingmodel.jpg" width="423" height="539"></p>
	<p class="style1" align="justify">The process starts with identifying 
	potential places which need help. This information is usually made available 
	by associate NGOs, Akshar Bharati volunteers &amp; other known people/groups 
	when they come across such places. </p>
	<p class="style1" align="justify"><strong>1.</strong> Once the place is identified, a group of 
	Akshar Bharati volunteers survey the place to gather following data,</p>

	<p class="style1" align="justify">&nbsp; <img alt="" src="images/bluebullet24.gif" width="10" height="10"> 
	Why kids come there? (is this a school or a classroom facility)<br>
&nbsp; <img alt="" src="images/bluebullet24.gif" width="10" height="10"> What 
	kind of setup they have? <br>
&nbsp; <img alt="" src="images/bluebullet24.gif" width="10" height="10"> What is 
	the family background of kids?<br>
&nbsp; <img alt="" src="images/bluebullet24.gif" width="10" height="10"> How can 
	we help them? (They require only books or books with&nbsp;&nbsp;&nbsp;&nbsp; 
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;storage?)<br>

&nbsp; <img alt="" src="images/bluebullet24.gif" width="10" height="10"> What 
	kind of books can be donated? (Whether they require only &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Marathi or they 
	require Hindi/Marathi &amp; English books?)<br>
&nbsp; <img alt="" src="images/bluebullet24.gif" width="10" height="10"> Who 
	will look after the library? (Is there any responsible person?)<br>
&nbsp; <img alt="" src="images/bluebullet24.gif" width="10" height="10"> How 
	will we get feedback from them at regular basis?</p>
	<p class="style1" align="justify"><strong>2. </strong>Procure Books: New 
	books are procured directly from the publishers. Hence we get heavy 
	discounts on funds spent. Books are care selected base on feedback received 
	from the currently setup library locations, institutes &amp; NGOs. We currently 
	deal with publishers like Navneet, Mehta, Bharat Bharathi. Customized set of 
	books are provided based on requiement of the library location/institute.</p>

	<p class="style1" align="justify"><strong>3. </strong>Akshar Bharati team 
	stamps &amp; catalogs books. We currently use open source library management 
	tool <a href="obiblio.sourceforge.net/">OpenBiblio</a> to manage books 
	procured &amp; given out. Each book carries a barcode for tracking purpose. This 
	also eases numbering at the library location.</p>
	<p class="style1" align="justify"><strong>4. </strong>Books are donated &amp; 
	library is inaugurated at the location. Instructions on monthly feedback 
	form are provided. Feedback form is mandatory for the library recipient 
	authority. They are required to fill it up &amp; send it across to us on or 
	before first week of every month about last month\'s working of the library.</p>

	<p class="style1" align="justify"><strong>5. </strong>A NGO volunteer or 
	school worker is assigned responsibility of looking after the working 
	Library. This person acts as point of contact to provide feedback &amp; get help 
	from Akshar Bharati team. </p>
	<p class="style1" align="justify"><strong>6. </strong>Feedback collection 
	team of Akshar Bharati takes care of collecting feedback from all locations 
	at the end of every month &amp; sharing it with all other volunteers. Also, if 
	there is any request for conducting activities or for new books, the 
	feedback team passes such information to procurement &amp; library activities 
	management team. &nbsp;</p>';
		$this->add_data($data);
    }
}
?>
