<?php

class CommercialPropertyForm {
    protected $attr ;
    public function __construct($action, $title, $prop_types, $internet, $lift,$option_urls,
				$attr = array('name'=>'commercial',
					      'method'=>'POST',
					      'onSubmit' =>'return validateCommercial()'
					      )) {
	$this->attr           = $attr;
	$this->attr['action'] = $action;
	$this->title          = $title;
	$this->prop_types     = $prop_types;
	$this->internet       = $internet;
	$this->lift           = $lift;
	$this->option_urls    = $option_urls;
	
    }

    public function get_html_text() {
	$height = 10;
	$html = '<form ';
	if ( $this->attr != null) {
	    foreach ($this->attr as $key=>$value) {
		$html .= $key."='".$value."'";
	    }
	}
	$html .= ">\n";
	$html .= '<h1>'.$this->title.'</h1><br/>';
	$html .= '<div id="error"></div>'
;

	$html .= '<input class="radio" type=radio name="p_category" VALUE="1" checked '.
	    'onClick="window.location.href=\''.$this->option_urls[0].'\'">Commercial</input>';

	$html .= '<input class="radio" type=radio name="p_category" value="2" '.
	    'onClick="window.location.href=\''.$this->option_urls[1].'\'">Residential</input>';
	$html .= "<br/><br/>";
	$html .= '<label for="p_type">Property Type</label>'."\n";
	
	$html .= '<select name="p_type">';
	foreach ($this->prop_types as $row) {
	    $html .= '<option value="'.$row['value'].'">'.$row['name'].'</option>'."\n";
	}
	$html .= '</select><br/><br/>';
	
	$html .= '<label for="p_name">Property Name</label>'."\n";
	$html .= '<div id="d_name"><input id="p_name":type="text" name="p_name"/></div><br/>'."\n";
	
	$html .= '<label for="p_address">Address <span class="red">*</span> </label>'."\n";
	$html .= '<div id="d_address"><input id="p_address" type="text" name="p_address"/></div><br/>'."\n";
	
	
	$html .= '<label for="p_age">Age [years] <span class="red">*</span> </label>'."\n";
	$html .= '<div id="d_age"><input id="p_age" type="text" name="p_age"/></div><br/>'."\n";
	
	$html .= '<label for="b_area">Built Area [SFT] <span class="red">*</span> </label>'."\n";
	$html .= '<div id="d_barea"><input id="b_area" type="text" name="b_area"/></div><br/>'."\n";
	
	$html .= '<label for="c_area">Carpet Area [SFT]</label>'."\n";
	$html .= '<div id="d_carea"><input id="c_area" type="text" name="c_area" value="0"/></div><br/>'."\n";
	
	$html .= '<label for="amount">Selling Price [INR]</label>'."\n";
	$html .= '<div id="d_amount"><input id="amount" type="text" name="amount" value="0"/></div><br/>'."\n";
	
	$html .= '<label for="floor">Floor</label>'."\n";
	$html .= '<div id="d_floor"><input id="floor" type="text" name="floor" value="0"/></div><br/>'."\n";
	
	
	$html .= '<label for="height">Height</label>'."\n";
	$html .= '<div id="d_height"><input id="height" type="text" name="height" value="0"/></div><br/>'."\n";
	
	$html .= '<label for="frontage">Frontage</label>'."\n";
	$html .= '<div id="d_frontage"><input id="frontage" type="text" name="frontage" value="0"/></div><br/>'."\n";
	
	
	$html .= '<label for="mezzanine">Mezzanine</label>'."\n";
	$html .= '<div id="d_mezzanine"><input id="mezzanine" type="text" name="mezzanine" value="0"/></div><br/>'."\n";
	
	
	$html .= '<label for="e_cap">Electricity Capacity (in KW)</label>'."\n";
	$html .= '<div id="d_ecap"><input id="e_cap" type="text" name="e_cap" value="0"/></div><br/>'."\n";

	$html .= '<label for="p_internet">Internet</label>'."\n";
	
	$html .= '<select name="p_internet">'."\n";
	foreach ($this->internet as $row) {
	    $html .= '<option value="'.$row['value'].'">'.$row['name'].'</option>'."\n";
	}
	$html .= "</select><br/><br/>\n";
	
	
	$html .= '<label for="f_safety">Fire Safety</label>';
	$html .= '<input class="radio" type="checkbox" name="f_safety"></input><br/>';
	
	$html .= '<label for="generator">Generator</label>'.
	    '<input type="checkbox" name="generator" class="radio"/><br/>';

	
	$html .= '<label for="g_cap">Generator Capacity (in KW)</label>'."\n";
	$html .= '<div id="d_gcap"><input id="g_cap" type="text" name="g_cap" value="0"/></div><br/>'."\n";
	
	$html .= '<label for="water">Water</label>'."\n";
	$html .= '<div id="d_water"><input id="water" type="text" name="water"/></div><br/>'."\n";
	
	$html .= '<label for="p_lift">Lift Facility</label>'."\n";
	
	$html .= '<select name="p_lift">'."\n";
	foreach ($this->lift as $row) {
	    $html .= '<option value="'.$row['value'].'">'.$row['name'].'</option>'."\n";
	}
	$html .= "</select><br/><br/>\n";
	
	$html .= '<label for="details">More Details</label>';
	$html .= '<div id="d_details"><textarea id="details" name="details" cols=30 rows=10></textarea></div><br/>';
	
	
	$html .= '<input class="submit" type="submit" value="Submit"/><br/>'."\n";
	$html .= '</form>';
	return $html;
    }
}