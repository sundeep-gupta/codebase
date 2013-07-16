<?php

class ResidentialPropertyForm {
    protected $attr ;
    public function __construct($action, $title, $prop_types, $status, $furnished, $lift,
				$option_urls, $attr = array('name'=>'residential',
					      'method'=>'POST',
					      'onSubmit' =>'return validateResidential()'
					      )) {
	$this->attr           = $attr;
	$this->attr['action'] = $action;
	$this->title          = $title;
	$this->prop_types     = $prop_types;
	$this->status         = $status;
	$this->furnished      = $furnished;
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
	$html .= '<div id="error"></div>';
	

	$html .= '<input class="radio"  id="p_category" type=radio name="p_category" VALUE="1" '.
	    'onClick="window.location.href=\''.$this->option_urls[0].'\'"> Commercial</input>';
	$html .= '<input class="radio" id="p_category" type=radio name="p_category" value="2" checked '.
	    'onClick="window.location.href=\''.$this->option_urls[1].'\'"> Residential </input><br/><br/>';
	$html .= '<label for="p_type" >Property Type</label>'."\n";
	
	$html .= '<select name="p_type">';
	foreach ($this->prop_types as $row) {
	    $html .= '<option value="'.$row['value'].'">'.$row['name'].'</option>'."\n";
	}
	$html .= '</select><br/><br/>';
	
	$html .= '<label for="p_name">Property Name</label>'."\n";
	$html .= '<div id="d_name"><input id="p_name" type="text" name="p_name"/></div><br/>'."\n";
	
	$html .= '<label for="p_address">Address <span class="red">*</span> </label>'."\n";
	$html .= '<div id="d_address"><input id="p_address" type="text" name="p_address"/></div><br/>'."\n";
	
	$html .= '<label for="p_status">Status</label>'."\n";
	
	$html .= '<select name="p_status">'."\n";
	foreach ($this->status as $row) {
	    $html .= '<option value="'.$row['value'].'">'.$row['name'].'</option>'."\n";
	}
	$html .= "</select><br/><br/>";

	$html .= '<label for="p_age">Age [years] <span class="red">*</span> </label>'."\n";
	$html .= '<div id="d_age"><input id="p_age" type="text" name="p_age"/></div><br/>'."\n";
	
	$html .= '<label for="broom">Bedrooms <span class="red">*</span> </label>'."\n";
	$html .= '<div id="d_broom"><input id="broom" type="text" name="broom"/></div><br/>'."\n";
	
	$html .= '<label for="b_area">Built Area [S0FT] <span class="red">*</span> </label>'."\n";
	$html .= '<div id="d_barea"><input id="b_area" type="text" name="b_area"/></div><br/>'."\n";
	
	$html .= '<label for="c_area">Carpet Area [SFT]</label>'."\n";
	$html .= '<div id="d_carea"><input id="c_area" type="text" name="c_area"/></div><br/>'."\n";
	
	$html .= '<label for="amount">Selling Price [INR]</label>'."\n";
	$html .= '<div id="d_amount"><input id="amount" type="text" name="amount" value="0"/></div><br/>'."\n";
	
	$html .= '<label for="floor">Floor</label>'."\n";
	$html .= '<div id="d_floor"><input id="floor" type="text" name="floor" value="0"/></div><br/>'."\n";
	
	$html .= '<label for="p_furnished">Furnished</label>'."\n";
	
	$html .= '<select name="p_furnished">'."\n";
	foreach ($this->furnished as $row) {
	    $html .= '<option value="'.$row['value'].'">'.$row['name'].'</option>'."\n";
	}
	$html .= "</select><br/><br/>\n";
	
	$html .= '<label for="generator">Generator</label>'.
	    '<input type="checkbox" name="generator" class="radio"/><br/>';
	
	$html .= '<label for="terrace">Terrace</label>'."\n";
	$html .= '<div id="d_terrace"><input id="terrace" type="text" name="terrace" value="0"/></div><br/>'."\n";
	
	$html .= '<label for="balcony">Balconies</label>'."\n";
	$html .= '<div id="d_balcony"><input id="balcony" type="text" name="balcony" value="0"/></div><br/>'."\n";
	
	$html .= '<label for="garden">Garden</label>'."\n";
	$html .= '<div id="d_garden"><input id="garden" type="text" name="garden" value="0"/></div><br/>'."\n";
	
	$html .= '<label for="amenities">Amenities</label>'."\n";
	$html .= '<div id="d_amenities"><input id="amenities" type="text" name="amenities"/></div><br/>'."\n";
	
	$html .= '<label for="water">Water</label>'."\n";
	$html .= '<div id="d_water"><input id="water" type="text" name="water"/></div><br/>'."\n";
	
	$html .= '<label for="p_lift">Lift Facility</label>'."\n";
	
	$html .= '<select name="p_lift">'."\n";

	foreach ($this->lift as $row) {
	    $html .= '<option value="'.$row['value'].'">'.$row['name'].'</option>'."\n";
	}
	$html .= "</select><br/><br/>\n";
	
	$html .= '<label for="details">More Details</label>';
	$html .= '<div id="d_details"><textarea name="details" cols=30 rows=10></textarea></div>';
	
	$html .= '<input  type="submit" value="Submit" class="submit"/><br/>'."\n";
	
	$html .= '</form>';
	return $html;
    }
}