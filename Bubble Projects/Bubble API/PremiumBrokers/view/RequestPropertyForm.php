<?php

class RequestPropertyForm {
    protected $attr ;
    public function __construct($action, $title, $list, $prop_type, $option_urls,
				$attr = array('name'=>'request_property',
					      'method'=>'POST',
					      'onSubmit' => 'return validateRequestProperty()')) {
	$this->attr = $attr;
	$this->attr['action'] = $action;
	$this->title = $title;
	$this->list = $list;
	$this->prop_type = $prop_type;
	$this->option_urls = $option_urls;
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

	if ($this->prop_type == 'Commercial') {
	    $html .= '<label class="rb" for="p_category">Commercial</label>';
	    $html .= '<input type=radio name="p_category" VALUE="1" checked '.
		'onClick="window.location.href=\''.$this->option_urls[0].'\'"/>';
	    $html .= '<label class="rb" for="p_category">Residential</label>';
	    $html .= '<input type=radio name="p_category" value="2" '.
		'onClick="window.location.href=\''.$this->option_urls[1].'\'"/>';
	} elseif ($this->prop_type == 'Residential') {
	    $html .= '<label class="rb" for="p_category">Commercial</label>';
	    $html .= '<input class="radio" type=radio name="p_category" VALUE="1" '.
		'onClick="window.location.href=\''.$this->option_urls[0].'\'"/>';
	    $html .= '<label class="rb" for="p_category">Residential</label>';
	    $html .= '<input type=radio name="p_category" value="2" checked '.
		'onClick="window.location.href=\''.$this->option_urls[1].'\'"/>';
	    
	}
	if ( count($this->list) > 0 ) {

	    $style = ( (count($this->list) > 10 ) ? "height: 80em; overflow:scroll; overflow-x: hidden;" :"" );

	    $html .= '<div style=" '.$style.' background-color: #FAFAFA;  ">';
	    $table = new HTMLTable(array('id'=>'board-head'));
	    $table->add_header_row();
	    $table->add_header_column( array('width'=>'15%', 'colspan'=>'2'), 'Title');
	    $table->add_header_column( array('width'=>'40%', 'align'=>'left'), 'Description');
	    $table->add_header_column( array('width'=>'20%', 'align'=>'center'), 'Location');
	    $table->add_header_column( array('width'=>'25%', 'align'=>'center'), 'Other Details');
	    
	    foreach ($this->list as $property) {
		
		$table->add_row( array('bgcolor'=>'#00FF00'));
		$table->add_column( array( 'valign'=>"middle", 
					  'align'=>"center",
					  'width'=>"4%"),
				    '<input type="checkbox" name="property[]" value="'.$property['id'].'" ></input>');
		$table->add_column( array( 'valign'=>"middle", 
					  'align'=>"left",
					  'width'=>"12%"),
				    $property['title']);
		$table->add_column( array( 'valign'=>"middle", 
					  'align'=>"left",
					  'width'=>"40%"), 
				    $property['desc']);
		$table->add_column( array( 'valign'=>"middle", 
					  'align'=>"left",
					  'width'=>"20%"),
				    $property['location']);
		$table->add_column( array( 'valign'=>"middle", 
					  'align'=>"left",
					  'width'=>"25%"),
				    $property['other']);
	    }
	    
	    $html .= $table->get_html_text();
	    $html .= '</div><!-- debug -->';
	    $html .= '<div id="main">';
	    $html .= '<br/><h1>'.$this->title.'</h1><br/>';
	    $html .= '<label for="firstname">First Name <spam class="red">*</spam></label>'."\n";
	    $html .= '<div id="d_firstname"><input id="firstname" type="text" name="firstname"/></div><br/>'."\n";
	    $html .= '<label for="lastname">Last Name <spam class="red">*</spam></label>'."\n";
	    $html .= '<div id="d_lastname"><input id="lastname" type="text" name="lastname"/></div><br/>'."\n";
	    $html .= '<label for="phonem">Phone <spam class="red">*</spam></label>'."\n";
	    $html .= '<div id="d_phonem"><input id="phonem" type="text" name="phonem"/></div><br/>'."\n";
	    $html .= '<label for="email">Email <spam class="red">*</spam></label>'."\n";
	    $html .= '<div id="d_email"><input id="email" type="text" name="email"/></div><br/>'."\n";
	    $html .= '<label for="address">Other Details</label>'."\n";
	    $html .= '<div id="d_other"><input id="address" type="text" name="address"/></div><br/>'."\n";
	    $html .= '<input class="submit" type="submit" name="personal_details" value="Submit"/><br/>'."\n";
	    $html .= '</div>';
	} else {
	    $html .= '<div> <br/>No records available. Please post your requirements <a href="controller.php?action=Requirement">here</a>.';
	    $html .= 'We will get back to you soon.<br/> <br/>';
	    $html .= '</div>';
	}
	$html .= '</form>';
	
	$html .= '<div id="sidebar">
<h1>Contact us:</h1>
<p class="style1">Nahid Shaikh<br/>
Ph:
</p></div>		';
	return $html;
    }
}