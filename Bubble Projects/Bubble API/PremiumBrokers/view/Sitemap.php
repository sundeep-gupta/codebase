<?php
require_once(VIEW.'/HTMLPage.php');
require_once(VIEW.'/Template.php');
require_once(LIB.'/Bubble/HTML/Div.php');


class SitemapView extends HTMLPage{
    protected $template_body;
    protected $html_head ;
    protected $body ;
    protected $model;
    public function __construct($model) { 
	$this->model = $model;
	$insurance_page  = new SitemapBody();
	$this->body  = new Body(null, $insurance_page);
	$this->head  = new HTMLHead();
	$this->head->add_stylesheet("images/bubblepb.css");
	$this->head->set_title("---Premiun Brokers---");
	parent::__construct();
    }
    
}

class SitemapBody extends TemplateView {
    public function __construct() {
	$this->main_body = new Sitemap();
	parent::__construct( array('header' => array('active_menu' => 'Sitemap')), array('id' =>'wrap'));
    }
} 

class Sitemap extends Div{
    function __construct($id = 'main') {
	parent::__construct( array('id' => $id));

	$data = '<h1>Sitemap</h1>
  

<table id="Table_01" width="501" height="301" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="17">
			<img src="sitemapimages/sitemap_01.gif" width="500" height="24" alt=""></td>
		<td>
			<img src="sitemapimages/spacer.gif" width="1" height="24" alt=""></td>
	</tr>
	<tr>
		<td colspan="3" rowspan="3">
			<img src="sitemapimages/sitemap_02.gif" width="58" height="59" alt=""></td>
		<td colspan="2">
			<a href="http://www.premiumbrokers.co.in/controller.php?action=Broking" target="_self">
				<img src="sitemapimages/IPO.gif" width="84" height="37" border="0" alt=""></a></td>
		<td colspan="6" rowspan="2">
			<img src="sitemapimages/sitemap_04.gif" width="133" height="54" alt=""></td>
		<td colspan="5">
			<a href="http://www.premiumbrokers.co.in/controller.php?action=RealEstate" target="_self">
				<img src="sitemapimages/real-estate.gif" width="192" height="37" border="0" alt=""></a></td>
		<td rowspan="16">
			<img src="sitemapimages/sitemap_06.gif" width="33" height="276" alt=""></td>
		<td>
			<img src="sitemapimages/spacer.gif" width="1" height="37" alt=""></td>
	</tr>
	<tr>
		<td colspan="2" rowspan="2">
			<img src="sitemapimages/sitemap_07.gif" width="84" height="22" alt=""></td>
		<td colspan="5" rowspan="4">
			<img src="sitemapimages/sitemap_08.gif" width="192" height="55" alt=""></td>
		<td>
			<img src="sitemapimages/spacer.gif" width="1" height="17" alt=""></td>
	</tr>
	<tr>
		<td rowspan="11">
			<img src="sitemapimages/sitemap_09.gif" width="11" height="150" alt=""></td>
		<td colspan="4" rowspan="2">
			<a href="http://www.premiumbrokers.co.in/controller.php?action=Training" target="_self">
				<img src="sitemapimages/training.gif" width="95" height="23" border="0" alt=""></a></td>
		<td rowspan="7">
			<img src="sitemapimages/sitemap_11.gif" width="27" height="74" alt=""></td>
		<td>
			<img src="sitemapimages/spacer.gif" width="1" height="5" alt=""></td>
	</tr>
	<tr>
		<td colspan="2" rowspan="5">
			<img src="sitemapimages/sitemap_12.gif" width="47" height="66" alt=""></td>
		<td colspan="2" rowspan="3">
			<a href="http://www.premiumbrokers.co.in/controller.php?action=Opportunities" target="_self">
				<img src="sitemapimages/partner-us.gif" width="82" height="42" border="0" alt=""></a></td>
		<td rowspan="5">
			<img src="sitemapimages/sitemap_14.gif" width="13" height="66" alt=""></td>
		<td>
			<img src="sitemapimages/spacer.gif" width="1" height="18" alt=""></td>
	</tr>
	<tr>
		<td colspan="4" rowspan="5">
			<img src="sitemapimages/sitemap_15.gif" width="95" height="51" alt=""></td>
		<td>
			<img src="sitemapimages/spacer.gif" width="1" height="15" alt=""></td>
	</tr>
	<tr>
		<td rowspan="4">
			<img src="sitemapimages/sitemap_16.gif" width="15" height="36" alt=""></td>
		<td colspan="3" rowspan="2">
			<a href="http://www.premiumbrokers.co.in/controller.php?action=RealEstate" target="_self">
				<img src="sitemapimages/realestate.gif" width="165" height="27" border="0" alt=""></a></td>
		<td rowspan="11">
			<img src="sitemapimages/sitemap_18.gif" width="12" height="184" alt=""></td>
		<td>
			<img src="sitemapimages/spacer.gif" width="1" height="9" alt=""></td>
	</tr>
	<tr>
		<td colspan="2" rowspan="2">
			<img src="sitemapimages/sitemap_19.gif" width="82" height="24" alt=""></td>
		<td>
			<img src="sitemapimages/spacer.gif" width="1" height="18" alt=""></td>
	</tr>
	<tr>
		<td colspan="3" rowspan="2">
			<img src="sitemapimages/sitemap_20.gif" width="165" height="9" alt=""></td>
		<td>
			<img src="sitemapimages/spacer.gif" width="1" height="6" alt=""></td>
	</tr>
	<tr>
		<td rowspan="8">
			<img src="sitemapimages/sitemap_21.gif" width="31" height="151" alt=""></td>
		<td colspan="4" rowspan="2">
			<a href="http://www.premiumbrokers.co.in/controller.php?action=Advisory" target="_self">
				<img src="sitemapimages/advisory.gif" width="111" height="25" border="0" alt=""></a></td>
		<td>
			<img src="sitemapimages/spacer.gif" width="1" height="3" alt=""></td>
	</tr>
	<tr>
		<td colspan="2" rowspan="4">
			<img src="sitemapimages/sitemap_23.gif" width="30" height="76" alt=""></td>
		<td colspan="5" rowspan="2">
			<a href="http://www.premiumbrokers.co.in/controller.php?action=Insurance" target="_self">
				<img src="sitemapimages/insurance.gif" width="123" height="41" border="0" alt=""></a></td>
		<td colspan="2" rowspan="3">
			<img src="sitemapimages/sitemap_25.gif" width="149" height="64" alt=""></td>
		<td>
			<img src="sitemapimages/spacer.gif" width="1" height="22" alt=""></td>
	</tr>
	<tr>
		<td colspan="4" rowspan="3">
			<img src="sitemapimages/sitemap_26.gif" width="111" height="54" alt=""></td>
		<td>
			<img src="sitemapimages/spacer.gif" width="1" height="19" alt=""></td>
	</tr>
	<tr>
		<td colspan="5">
			<img src="sitemapimages/sitemap_27.gif" width="123" height="23" alt=""></td>
		<td>
			<img src="sitemapimages/spacer.gif" width="1" height="23" alt=""></td>
	</tr>
	<tr>
		<td rowspan="4">
			<img src="sitemapimages/sitemap_28.gif" width="53" height="84" alt=""></td>
		<td colspan="5" rowspan="2">
			<a href="http://www.premiumbrokers.co.in/controller.php?action=Broking" target="_self">
				<img src="sitemapimages/broking.gif" width="176" height="35" border="0" alt=""></a></td>
		<td rowspan="4">
			<img src="sitemapimages/sitemap_30.gif" width="43" height="84" alt=""></td>
		<td>
			<img src="sitemapimages/spacer.gif" width="1" height="12" alt=""></td>
	</tr>
	<tr>
		<td rowspan="3">
			<img src="sitemapimages/sitemap_31.gif" width="16" height="72" alt=""></td>
		<td colspan="5" rowspan="2">
			<a href="http://www.premiumbrokers.co.in/controller.php?action=RealEstate" target="_self">
				<img src="sitemapimages/real-estate-33.gif" width="119" height="36" border="0" alt=""></a></td>
		<td rowspan="3">
			<img src="sitemapimages/sitemap_33.gif" width="17" height="72" alt=""></td>
		<td>
			<img src="sitemapimages/spacer.gif" width="1" height="23" alt=""></td>
	</tr>
	<tr>
		<td colspan="5" rowspan="2">
			<img src="sitemapimages/sitemap_34.gif" width="176" height="49" alt=""></td>
		<td>
			<img src="sitemapimages/spacer.gif" width="1" height="13" alt=""></td>
	</tr>
	<tr>
		<td colspan="5">
			<img src="sitemapimages/sitemap_35.gif" width="119" height="36" alt=""></td>
		<td>
			<img src="sitemapimages/spacer.gif" width="1" height="36" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="sitemapimages/spacer.gif" width="31" height="1" alt=""></td>
		<td>
			<img src="sitemapimages/spacer.gif" width="16" height="1" alt=""></td>
		<td>
			<img src="sitemapimages/spacer.gif" width="11" height="1" alt=""></td>
		<td>
			<img src="sitemapimages/spacer.gif" width="71" height="1" alt=""></td>
		<td>
			<img src="sitemapimages/spacer.gif" width="13" height="1" alt=""></td>
		<td>
			<img src="sitemapimages/spacer.gif" width="11" height="1" alt=""></td>
		<td>
			<img src="sitemapimages/spacer.gif" width="13" height="1" alt=""></td>
		<td>
			<img src="sitemapimages/spacer.gif" width="17" height="1" alt=""></td>
		<td>
			<img src="sitemapimages/spacer.gif" width="53" height="1" alt=""></td>
		<td>
			<img src="sitemapimages/spacer.gif" width="12" height="1" alt=""></td>
		<td>
			<img src="sitemapimages/spacer.gif" width="27" height="1" alt=""></td>
		<td>
			<img src="sitemapimages/spacer.gif" width="15" height="1" alt=""></td>
		<td>
			<img src="sitemapimages/spacer.gif" width="16" height="1" alt=""></td>
		<td>
			<img src="sitemapimages/spacer.gif" width="106" height="1" alt=""></td>
		<td>
			<img src="sitemapimages/spacer.gif" width="43" height="1" alt=""></td>
		<td>
			<img src="sitemapimages/spacer.gif" width="12" height="1" alt=""></td>
		<td>
			<img src="sitemapimages/spacer.gif" width="33" height="1" alt=""></td>
		<td></td>
	</tr>
</table>

';
	$this->add_data($data);
    }
}

?>
