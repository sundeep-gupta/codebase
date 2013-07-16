<?php
/* TODO: This should in future extend FORM */
class DeletePropertyForm {
    protected $attr ;
    public function __construct($action, $title, $list, $txn_type, $prop_type,
				$attr = array('name'=>'delete_form',
					      'method'=>'POST',
					      'onSubmit' => 'return deleteContacts()')) {
	$this->attr           = $attr;
	$this->attr['action'] = $action;
	$this->title          = $title;
	$this->list           = $list;
	$this->txn_type       = $txn_type;
	$this->prop_type      = $prop_type;
    }
    public function get_html_text() {
	$html = '<form ';
	if ( $this->attr != null) {
	    foreach ($this->attr as $key=>$value) {
		$html .= $key."='".$value."'";
	    }
	}
	$html .= ">\n";
	$html .= '<h1>'.$this->title.'</h1><br/>';

	if ($this->prop_type == 'Commercial') {
	    $html .= '<input type=radio name="p_category" VALUE="1" checked '.
		'onClick="window.location.href=\'controller.php?action=DeleteProperty&event=show_commercial\'">Commercial';
	    $html .= '<input type=radio name="p_category" value="2" '.
		'onClick="window.location.href=\'controller.php?action=DeleteProperty&event=show_residential\'">Residential<br/>';
	} elseif ($this->prop_type == 'Residential') {
	    $html .= '<input type=radio name="p_category" VALUE="1" '.
		'onClick="window.location.href=\'controller.php?action=DeleteProperty&event=show_commercial\'">Commercial';
	    $html .= '<input type=radio name="p_category" value="2" checked '.
		'onClick="window.location.href=\'controller.php?action=DeleteProperty&event=show_residential\'">Residential<br/>';
	    
	}

	if ($this->txn_type == 'Sell') {
	    $html .= '<input type=radio name="p_txn_type" VALUE="1" checked '.
		'onClick="window.location.href=\'controller.php?action=DeleteProperty&event=show_sell\'">Sell';
	    $html .= '<input type=radio name="p_txn_type" value="2" '.
		'onClick="window.location.href=\'controller.php?action=DeleteProperty&event=show_rent\'">Rent<br/>';
	} elseif ($this->txn_type == 'Rent') {
	    $html .= '<input type=radio name="p_txn_type" VALUE="1" '.
		'onClick="window.location.href=\'controller.php?action=DeleteProperty&event=show_sell\'">Sell';
	    $html .= '<input type=radio name="p_txn_type" value="2" checked '.
		'onClick="window.location.href=\'controller.php?action=DeleteProperty&event=show_rent\'">Rent<br/>';
	    
	}

	if (count($this->list) > 0) {
	    $height = ( count($this->list) > 10 ? 80 : count($this->list)*8);
	    if(count($this->list) > 1) {
		$html .= '<input type="checkbox" id="selectall" name="selectall" '.
		    'onClick="select_all(this.form.property,this)") ">Select All </input>';
	    }
	    $html .= '<div style="height:'.$height.'em; overflow:scroll; overflow-x: hidden;	background-color: #FAFAFA;  ">'; 
	    $table = new HTMLTable(array('id'=>'board-head'));
	    $table->add_header_row();
	    $table->add_header_column( array('width'=>'15%', 'colspan'=>'2'), 'Title');
	    $table->add_header_column( array('width'=>'30%', 'align'=>'left'), 'Description');
	    $table->add_header_column( array('width'=>'20%', 'align'=>'center'), 'Location');
	    $table->add_header_column( array('width'=>'20%', 'align'=>'center'), 'Other Details');
	    $table->add_header_column( array('width'=>'15%', 'align'=>'center'), 'Contact');
	    foreach ($this->list as $property) {
		$table->add_row( array('bgcolor'=>'#00FF00'));
		$table->add_column( array('valign'=>"middle", 
					  'align'=>"center",
					  'width'=>"4%"),
				    '<input type="checkbox" id="property" name="property[]" value="'.$property['id'].'" ></input>');
		$table->add_column( array( 'valign'=>"middle", 
					  'width'=>"12%"),
				    $property['title']);
		$table->add_column( array('valign'=>"center",
					  'width'=>"30%"), 
				    $property['desc']);
		$table->add_column( array('valign'=>"middle", 
					  'width'=>"20%"),
				    $property['location']);
		$table->add_column( array('valign'=>"middle", 
					  'width'=>"20%"),
				    $property['other']);
		$table->add_column( array('valign'=>"middle", 
					  'width'=>"15%"),
				    $property['contact']);
	    }
	    
	    $html .= $table->get_html_text();
	    $html .= '</div>';

	    $data .= '<label for="selectall">Select All</label>';
	    $data .= '<input type="checkbox" id="selectall" name="selectall" onclick="select_all(this.form.property, this)"/><br/>';
	    $html .= '<input  type="submit" name="personal_details" value="Delete" class="submit"/><br/>'."\n";
	} else {
	    $html .= '<div><br/>No Records in this Category<br/><br/></div>';
	}
	$html .= '</form>';
	return $html;
    }
}