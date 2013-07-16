<?php
require_once(MVC_LIB.'/Bubble/'.PROJECT_NAME.'/view/HTMLPage.php');
require_once(MVC_LIB.'/Bubble/'.PROJECT_NAME.'/view/Template.php');

class ProjectsView extends HTMLPage{
    protected $template_body;
    protected $html_head ;
    protected $body ;
    protected $model;
    public function __construct($model) { 
		$this->model = $model;
		$index_page  = new ProjectsBody();
		$this->body  = new Body(null, $index_page);
		$this->head  = new HTMLHead();
		$this->head->add_stylesheet("images/bubble_ab.css");
		$this->head->set_title("Akshar Bharati - Home");
		parent::__construct();
    }
    
}

class ProjectsBody extends TemplateView {
    public function __construct() {
	$this->main_body = new Projects();
	parent::__construct( array('header' => array('active_menu' => 'Home')), 
			     array('id' =>'wrap'));
    }
}

class Projects extends Div{
    function __construct($id = 'main') {
	parent::__construct( array('id' => $id));
		$data = '	
    <table style="width: 100%">
		<tr>
			<td>
			<table background="images/subtitle.jpg" style="height: 10px; width: 100%" cellspacing="0" cellpadding="0">
				<tr>
					<td style="height: 10px"><strong>&nbsp;6 Libraries (Abhyasikas) 
					with Surajya </strong></td>
				</tr>
			</table>
			</td>
		</tr>
		<tr>
			<td>
			<table style="width: 100%" class="style4" cellspacing="0" cellpadding="1">
				<tr>
					<td style="width: 378px">
					<p align="justify">Surajya an NGO working on various slums 
					of Pune. The core activity of Surajya is setting up 
					Abhyasikas (Classroom facility) for slum kids &amp; impart 
					tuition classes. Akshar Bharati along with Surajya has setup 
					libraries in 6 of their active locations. We have donated 
					~3000 books to surajya. Circulation of books around the 
					location is very encauraging &amp; kids seem to like the set of 
					books. <br>
					<br>
					Library locations:<br>
					<br>
					Ektanagar, Vishrantwadi<br>
					Ambedkar Nagar<br>
					Sanjay Park, Yerwada<br>
					Darodemala, Koregaonpark<br>
					JP Nagar, Yerwada </p>
					</td>
					<td>
					<img alt="" src="images/ABimages/darodemala_t.jpg" width="150" height="113"><br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					<br>
					</td>
				</tr>
			</table>
			</td>
		</tr>
		<tr>
			<td style="height: 23px">
			<table background="images/subtitle.jpg"  style="height: 10px; width: 100%" cellspacing="0" cellpadding="0">
				<tr>
					<td style="height: 10px"><strong>&nbsp;2 Libraries with MES at Garware School 
					, Pune</strong></td>
				</tr>
			</table>

			
			</td>
		</tr>
		<tr>
			<td>
			
			<table style="width: 100%" class="style4" cellspacing="0" cellpadding="1">
				<tr>
					<td style="width: 378px; height: 130px;">
					<p align="justify">Garware school is one of the oldest 
					schools in Pune which currently has a strength of 3000+ 
					students. There was library existing here with around 20000+ 
					books of which most were outdated. Most of the children are 
					from poor background. School houses proper library staff. AB 
					supplied 1000 books to the school.</p>
					</td>
					<td style="height: 130px">
					<img alt="" src="images/ABimages/darodemala_t.jpg" width="150" height="113"></td>
				</tr>
			</table>

			
			</td>
		</tr>
		<tr>
			<td>
			
			<table background="images/subtitle.jpg"  style="height: 10px; width: 100%" cellspacing="0" cellpadding="0">
				<tr>
					<td style="height: 10px"><strong>At Buddha Vihar with 
					Swayamdeep, Pune</strong></td>
				</tr>
			</table>
			
			
			</td>
		</tr>
		<tr>
			<td>
			
			<table style="width: 100%" class="style4" cellspacing="0" cellpadding="1">
				<tr>
					<td style="width: 378px; height: 130px;">
					<p align="justify"><font face="Book Antiqua" size="2">AB 
					team with NGO called Swayamdeep established library at 
					Buddha vihar. At buddha vihar they have a classroom 
					facility. AB supplied story books &amp; basic English books 
					which were required to conduct classes for the kids. Some 
					older people around the area are also seems to be interested 
					in using library books as well. </font></p>
					</td>
					<td style="height: 130px">
					<img alt="" src="images/ABimages/darodemala_t.jpg" width="150" height="113"></td>
				</tr>
			</table>

			
			
			</td>
		</tr>
		<tr>
			<td>
			
			<table background="images/subtitle.jpg"  style="height: 10px; width: 100%" cellspacing="0" cellpadding="0">
				<tr>
					<td style="height: 10px"><strong>With Swaroop Vardinin at 
					Mangalwar Peth, Pune</strong></td>
				</tr>
			</table>

			
			
			
			</td>
		</tr>
		<tr>
			<td>
			
			<table style="width: 100%" class="style4" cellspacing="0" cellpadding="1">
				<tr>
					<td style="width: 378px; height: 130px;">
					<p align="justify">AB Supplied around 500 Books which 
					consists of Stories, Basic maths &amp; English. Response was 
					good with circulation of 100 books in the first month. This 
					place houses around 80 children. Kids read books in the 
					class room as well as take them home. We are working with 
					Swaroop Vardini to setup few more libraries. </p>
					</td>
					<td style="height: 130px">
					<img alt="" src="images/ABimages/darodemala_t.jpg" width="150" height="113"></td>
				</tr>
			</table>

			
			
			
			</td>
		</tr>
		<tr>
			<td>
			
				<table background="images/subtitle.jpg"  style="height: 10px; width: 100%" cellspacing="0" cellpadding="0">
				<tr>
					<td style="height: 10px"><strong>Ashramshala, Wagholi, Pune</strong></td>
				</tr>
			</table>

			
			
			</td>
		</tr>
		<tr>
			<td>
			
				<table style="width: 100%" class="style4" cellspacing="0" cellpadding="1">
				<tr>
					<td style="width: 378px; height: 130px;">
					<p align="justify">There was a small library existing in the 
					premises with apporox 350+ books most of them were out 
					dated. So they wanted AB to updated their library with new 
					books suitable for 5th to 10th std. All the students (153 of 
					them) reside in the school most of them are orphans or from 
					single parent &amp; tribal background. </p>
					</td>
					<td style="height: 130px">
					<img alt="" src="images/ABimages/darodemala_t.jpg" width="150" height="113"></td>
				</tr>
			</table>

			
			
			</td>
		</tr>
		<tr>
			<td>
			
			<table background="images/subtitle.jpg"  style="height: 10px; width: 100%" cellspacing="0" cellpadding="0">
				<tr>
					<td style="height: 10px"><strong>Bharatiya Samaj Seva Kendra, 
					Vishrantwadi, Pune</strong></td>
				</tr>
			</table>

			
			</td>
		</tr>
		<tr>
			<td>
			
				<table style="width: 100%" class="style4" cellspacing="0" cellpadding="1">
				<tr>
					<td style="width: 378px; height: 130px;">
					<p align="justify"><strong>BSSK</strong> (Bharatiya Samaj 
					Seva Kendra<strong>) </strong>caters to the need of entire 
					family. Preference is given to Girls education. In this 
					place they conduct tuition classes, health camps, music 
					classes, self employment sessions etc., The library has been 
					setup with an aim of making not only kids but the entire 
					family to read books &amp; get benefited.</p>
					</td>
					<td style="height: 130px">
					<img alt="" src="images/ABimages/darodemala_t.jpg" width="150" height="113"></td>
				</tr>
			</table>

			
			
			</td>
		</tr>
		
		<tr>
			<td>
			
			<table background="images/subtitle.jpg"  style="height: 10px; width: 100%" cellspacing="0" cellpadding="0">
				<tr>
					<td style="height: 10px"><strong>Loknete Dada Jadhavrao High 
					School Hingangao, Pune</strong></td>
				</tr>
			</table>

			
			</td>
		</tr>
		<tr>
			<td>
			
				<table style="width: 100%" class="style4" cellspacing="0" cellpadding="1">
				<tr>
					<td style="width: 378px; height: 130px;">
					<p align="justify">This school is run set of individuals 
					with the aim of helping society. Fee is collected only to 
					procure to education material. The school staff requested us 
					to setup library. They conduct state board classes for grade 
					8-10th students. They have a strength of 160 students. 
					Akshar Bharati team has setup library &amp; planning to provide 
					storage shelf for the future set of books.</p>
					</td>
					<td style="height: 130px">
					<img alt="" src="images/ABimages/darodemala_t.jpg" width="150" height="113"></td>
				</tr>
			</table>

			
			
			</td>
		</tr>

		
		
		<tr>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>
	</table>

    
    
    
    
    ';

		$this->add_data($data);
    }
}
?>
