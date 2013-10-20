<?php
require_once(LIB.'/Bubble/DB/MySQL.php');
abstract class Property {
    protected $step;
    protected $dbconn;
    protected $queries;
    public function __construct() {
	$this->dbconn    = new MySQL(DB_HOST, DB_USER, DB_PASS, DB_NAME);
	$this->dbconn->connect();
	$this->queries = array( 
	    'Q_PB_STATUS_ALL'       => 'SELECT status_id, description FROM pb_status',
	    'Q_PB_LIFT_ALL'         => 'SELECT id, description FROM pb_lift_facility',
	    'Q_PB_INTERNET_ALL'     => 'SELECT id, description FROM pb_internet',
	    'Q_PB_FURNISHED_ALL'    => 'SELECT furnished_id, description FROM pb_furnished',
	    'Q_PB_ADDRESSBOOK_ALL'  => 'SELECT id,Concat(f_name," ", l_name) as name, email, phone, address FROM pb_address_book',

	    'Q_PB_RES_SELL'         => 'SELECT prop_id as id, name as title, pr.address as location, details as other, '.
	                               ' ppt.sub_type as prop_type, '.
                   	               ' bedrooms, b_area, floor, garden, terrace, balcony, amenities, furnished, lift, generator '.
	                               'FROM pb_residential pr, pb_txn_type pt, pb_prop_type ppt '.
	                               'WHERE pr.txn_type = pt.type_id AND ppt.type_id = pr.prop_type AND pt.description = \'Sell\'',

	    'Q_PB_RES_RENT'         => 'SELECT prop_id as id, name as title, pr.address as location, details as other,'.
	                                    ' bedrooms, b_area, floor, garden, terrace, balcony, amenities, furnished, lift, generator '.
	                              'FROM pb_residential pr, pb_txn_type pt, pb_prop_type ppt '.
                                      'WHERE pr.txn_type = pt.type_id AND ppt.type_id = pr.prop_type AND pt.description = \'Rent\'',

	    'Q_PB_COMM_SELL'        =>  'SELECT prop_id as id, name as title, pr.address as location, details as other, height, frontage, '.
	                               ' ppt.sub_type as prop_type, '.
	                               'mezzanine, elec_capacity, fire_safety, internet, water, lift, generator, gen_capacity '.
	                               'FROM pb_commercial pr, pb_txn_type pt, pb_prop_type ppt '.
                                      'WHERE pr.txn_type = pt.type_id AND ppt.type_id = pr.prop_type AND pt.description = \'Sell\'',

	    'Q_PB_COMM_RENT'        =>  'SELECT prop_id as id, name as title, pr.address as location, details as other, height, frontage, '.
	                               ' ppt.sub_type as prop_type, '.
	                                    'mezzanine, elec_capacity, fire_safety, internet, water, lift, generator, gen_capacity '.
	                              'FROM pb_commercial pr, pb_txn_type pt, pb_prop_type ppt '.
                                      'WHERE pr.txn_type = pt.type_id AND ppt.type_id = pr.prop_type AND pt.description = \'Rent\'',

	    'Q_PB_RES_SELL_CONTACT' => 'SELECT prop_id as id, name as title, pr.address as location, details as other, '.
	                                       'Concat(ab.f_name, " ", ab.l_name, " ( ", ab.phone," ) " ) as contact, '.
	                                ' ppt.sub_type as prop_type, '.
	                                'bedrooms, b_area, floor, garden, terrace, balcony, amenities, furnished, lift, generator '.
	                                'FROM pb_residential pr, pb_txn_type pt, pb_address_book ab, pb_prop_type ppt '.
                                        'WHERE pr.contact = ab.id and pr.txn_type = pt.type_id AND ppt.type_id = pr.prop_type and pt.description = \'Sell\'',

	    'Q_PB_RES_RENT_CONTACT' => 'SELECT prop_id as id, name as title, pr.address as location, details as other, '.
	                                       'Concat(ab.f_name, " ", ab.l_name, " ( ", ab.phone," ) " ) as contact, '.
	                               ' ppt.sub_type as prop_type, '.
	                                       'bedrooms, b_area, floor, garden, terrace, balcony, amenities, furnished, lift, generator '.
	                                'FROM pb_residential pr, pb_txn_type pt, pb_address_book ab, pb_prop_type ppt '.
                                        'WHERE pr.contact = ab.id and pr.txn_type = pt.type_id AND ppt.type_id = pr.prop_type and pt.description = \'Rent\'',

	    'Q_PB_COMM_SELL_CONTACT' => 'SELECT prop_id as id, name as title, pr.address as location, details as other, height, frontage, '.
	                                'mezzanine, elec_capacity, fire_safety, internet, water, lift, generator, gen_capacity, '.
	                                ' ppt.sub_type as prop_type, '.
                                        'Concat(ab.f_name, " ", ab.l_name, " ( ", ab.phone," ) " ) as contact '.
	                                'FROM pb_commercial pr, pb_txn_type pt, pb_prop_type ppt, pb_address_book ab  '.
                                        'WHERE pr.contact = ab.id and pr.txn_type = pt.type_id AND ppt.type_id = pr.prop_type and pt.description = \'Sell\'',

	    'Q_PB_COMM_RENT_CONTACT' => 'SELECT prop_id as id, name as title, pr.address as location, details as other, height, frontage, '.
	                                ' ppt.sub_type as prop_type, '.
	                                    'mezzanine, elec_capacity, fire_safety, internet, water, lift, generator, gen_capacity, '.
	                                    'Concat(ab.f_name, " ", ab.l_name, " ( ", ab.phone," ) " ) as contact '.
	                                'FROM pb_commercial pr, pb_txn_type pt, pb_address_book ab, pb_prop_type ppt  '.
                                        'WHERE pr.contact = ab.id and pr.txn_type = pt.type_id AND ppt.type_id = pr.prop_type and pt.description = \'Rent\'',
	    );
    }

    public function insert_residential_details($row) {

	$generator = (isset($row['generator'])) ? 1 : 0 ;
	$query     = 'INSERT INTO pb_residential '.
	    '(prop_type, name, address, status,'.
	    ' age, bedrooms, b_area, c_area, cost, floor,'.
            ' garden, terrace, balcony, amenities, water, furnished,'.
	    ' lift, generator, txn_type, details, contact)'.
	    ' values ('.$row['prop_type'].',';
	$query .= ((isset($row['name'])and $row['name'] != "" )? '"'.$row['name'].'", ' : 'null, ');
	$query .=  ((isset($row['address']) and $row['address'] != "")? '"'.$row['address'].'",' : 'null, ');
	$query .=  $row['status'].','.
	    $row['age'].','.
	    $row['bedrooms'].','.
	    $row['b_area'].','.
	    $row['c_area'].','.
	    $row['cost'].','.
	    $row['floor'].','.
	    $row['garden'].','.
	    $row['terrace'].','.
	    $row['balcony'].',';
	$query .= ((isset($row['amenities']) and $row['amenities'] != "" )? '"'.$row['ameneties'].'", ' : 'null, ');
	$query .= ((isset($row['water']) and $row['water'] != "")? '"'.$row['water'].'", ' : 'null, ');
	$query .= $row['furnished'].', '.
	    $row['lift'].', '.
	    $row['generator'].', '.
	    $row['txn_type'].', ';
	$query .= ((isset($row['details'])and $row['details'] != "" )? '"'.$row['details'].'", ' : 'null, ');
	$query .= $row['contact'].')';
	$_SESSION['d_query'] = $query;
	return $this->dbconn->insert($query);
    }
    
    public function insert_commercial_details($row) {

	$generator = (isset($row['generator'])) ? 1 : 0 ;
	$query     = 'INSERT INTO pb_commercial '.
	    '(prop_type, name, address,'.
	    ' age, b_area, c_area, cost, floor,'.
            ' height, frontage, mezzanine, elec_capacity, fire_safety, internet,'.
	    ' water, lift, generator, gen_capacity,  txn_type, details, contact)'.
	    ' values ('.$row['prop_type'].',';
	$query .= ((isset($row['name']) and $row['name'] != "" )? '"'.$row['name'].'", ' : 'null, ');
	$query .=  ((isset($row['address']) and $row['address'] != "") ? '"'.$row['address'].'",' : 'null, ');
	$query .= $row['age'].','.
	    $row['b_area'].','.
	    $row['c_area'].','.
	    $row['cost'].','.
	    $row['floor'].','.
	    $row['height'].','.
	    $row['frontage'].','.
	    $row['mezzanine'].','.
	    $row['elec_capacity'].','.
	    $row['fire_safety'].','.
	    $row['internet'].',';
	$query .= ((isset($row['water']) and $row['water'] != "" )? '"'.$row['water'].'",' : 'null, ');
	$query .= $row['lift'].','.
	    $row['generator'].','.
	    $row['gen_capacity'].','.
	    $row['txn_type'].',';
	$query .= ((isset($row['details']) and $row['details'] != "" )? '"'.$row['details'].'",' : 'null, ');
	$query .= $row['contact'].')';

	return $this->dbconn->insert($query);
    }
 

    public function insert_contact($contact) {
	$id_query = 'SELECT id from pb_address_book WHERE phone='.$contact['phone'];
	$result   = $this->dbconn->execute_query($id_query);

	if(! (count($result) > 0)) {
	    $query = 'INSERT INTO pb_address_book (f_name,l_name,address,email,phone)'.
		'values ("'.$contact['firstname'].'",'.
		'"'.$contact['lastname'].'",'.
		'"'.$contact['address'].'",'.
		'"'.$contact['email'].'",'.
	    ''.$contact['phone'].')';
	    $this->dbconn->insert($query);
	    $result     = $this->dbconn->insert($id_query);
	}
	$contact_id = $result[0]['id'];
	return $contact_id;
    }

    public function get_property_type($category) {
	$type   = array();
	$query  = 'SELECT type_id, sub_type FROM pb_prop_type WHERE type = "'.$category.'"';
	$result = $this->dbconn->execute_query($query);
	foreach ($result as $row) {
	    array_push($type, array('value' => $row['type_id'], 'name' => $row['sub_type']));
	}
	return $type;
    }

    public function get_status() {
	$type   = array();
	$result = $this->dbconn->execute_query($this->queries['Q_PB_STATUS_ALL']);
	foreach ($result as $row) {
	    array_push($type, array('value' => $row['status_id'], 'name' => $row['description']));
	}
	return $type;
    }

    public function get_furnished() {
	$type   = array();
	$result = $this->dbconn->execute_query($this->queries['Q_PB_FURNISHED_ALL']);
	foreach ($result as $row) {
	    array_push($type, array('value' => $row['furnished_id'], 'name' => $row['description']));
	}
	return $type;
    }   


    public function get_lift() {
	$type   = array();
	$result = $this->dbconn->execute_query($this->queries['Q_PB_LIFT_ALL']);
	foreach ($result as $row) {
	    array_push($type, array('value' => $row['id'], 'name' => $row['description']));
	}

	return $type;
    }
    
    public function get_internet() {
	$type   = array();
	$result = $this->dbconn->execute_query($this->queries['Q_PB_INTERNET_ALL']);
	foreach ($result as $row) {
	    array_push($type, array('value' => $row['id'], 'name' => $row['description']));
	}
	return $type;
    }
        

    public function get_contacts() {
	$result   = $this->dbconn->execute_query($this->queries['Q_PB_ADDRESSBOOK_ALL']);
	return $result;
    }
    
    public function get_transaction_id($type) {
	$result = $this->dbconn->execute_query('SELECT type_id FROM pb_txn_type WHERE description = "'.$type.'"');
	return $result[0]['type_id'];
    }

    public function read_residential_form() {
	
	$row = array( 'prop_type' => $_POST['p_type'],
		       'name' => $_POST['p_name'],
		       'address' => $_POST['p_address'],
		       'status' => $_POST['p_status'],
		       'age'    => $_POST['p_age'],
		       'bedrooms' => $_POST['broom'],
		       'b_area' => $_POST['b_area'],
		       'c_area' => $_POST['c_area'],
		       'cost'   => $_POST['amount'],
		       'floor'  => $_POST['floor'],
		       'garden' => $_POST['p_garden'],
		       'terrace' => $_POST['p_terrace'],
		       'balcony' => $_POST['p_balcony'],
		       'amenities' => $_POST['p_amenities'],
		       'furnished' => $_POST['p_furnished'],
		       'lift' => $_POST['p_lift'] ,
		       'generator' => (isset($_POST['generator'])) ? 1 : 0 ,
		       'details'     => $_POST['details'],
		       'water'       => $_POST['water']
	    );
	/* More server side validations here.*/
	$int_fields = array ('age','b_area','c_area','cost','floor','garden','terrace','balcony','bedrooms');
	foreach ($int_fields as $key) {
	    if (! isset($row[$key]) or strlen($row[$key]) == 0) {
		$row[$key] = 0;
	    }
	}

	return $row;	
    }


    public function read_commercial_form() {
	
	$row = array( 'prop_type' => $_POST['p_type'],
		       'name' => $_POST['p_name'],
		       'address' => $_POST['p_address'],
		       'age'    => $_POST['p_age'],
		       'b_area' => $_POST['b_area'],
		       'c_area' => $_POST['c_area'],
		       'cost'   => $_POST['amount'],
		       'floor'  => $_POST['floor'],
		       'height' => $_POST['height'],
		       'frontage' => $_POST['frontage'],
		       'mezzanine' => $_POST['mezzanine'],
		       'elec_capacity' => $_POST['e_cap'],
		       'internet' => $_POST['p_internet'],
		       'fire_safety' => (isset($_POST['f_safety'])) ? 1 : 0 ,
		       'generator' => (isset($_POST['generator'])) ? 1 : 0 ,
		       'lift'     => $_POST['p_lift'],
		       'gen_capacity' => $_POST['g_cap'],
		       'details'     => $_POST['details'],
		       'water'       => $_POST['water']
	    );
	/* TODO: More server side validations here.*/
	$int_fields = array ('age','b_area','c_area','cost','floor','height','frontage', 'mezzanine', 'elec_capacity','gen_capacity');
	foreach ($int_fields as $key) {
	    if (! isset($row[$key]) or strlen($row[$key]) == 0) {
		$row[$key] = 0;
	    }
	}
	return $row;

    }

    public function get_residentials_for_sell($contact = false) {
	$list = array();
	if ($contact == true) {
	    $result = $this->dbconn->execute_query($this->queries['Q_PB_RES_SELL_CONTACT']);
	    $list = $this->format_residential_contact($result);

	} else {
	    $result = $this->dbconn->execute_query($this->queries['Q_PB_RES_SELL']);
	    $list   = $this->format_residential($result);
	}
	return $list;
    }

    public function get_residentials_for_rent($contact = false) {
	$list = array();	

	if ($contact == true) {

	    $result = $this->dbconn->execute_query($this->queries['Q_PB_RES_RENT_CONTACT']);
	    $list = $this->format_residential_contact($result);
	} else {

	    $result = $this->dbconn->execute_query($this->queries['Q_PB_RES_RENT']);
	    $list   = $this->format_residential($result);
	}

	return $list;
    }

    public function get_commercial_for_sell($contact = false) {
	$list = array();
	if ($contact == true) {
	    $result = $this->dbconn->execute_query($this->queries['Q_PB_COMM_SELL_CONTACT']);
	    $list = $this->format_commercial_contact($result);
	} else {
	    $result = $this->dbconn->execute_query($this->queries['Q_PB_COMM_SELL']);
	    $list = $this->format_commercial($result);
	}
	return $list;
				
    }

    public function get_commercial_for_rent($contact = false) {
	$list = array();
	if ($contact == true) {
	    $result = $this->dbconn->execute_query($this->queries['Q_PB_COMM_RENT_CONTACT']);
	    $list = $this->format_commercial_contact($result);
	} else {
	    $result = $this->dbconn->execute_query($this->queries['Q_PB_COMM_RENT']);
	    $list = $this->format_commercial($result);
	}
	return $list;
				
    }

    protected function format_residential_contact($result) {
	$list = array();
	foreach($result as $row) {
	    array_push($list, array('id' => $row['id'],
				    'title'=> $row['title'],
				    'location' => $row['location'] ,
				    'other'    => $row['other'],
				    'desc'     => $this->get_description($row),
				    'contact'  => $row['contact']
			   ));
	}
	return $list;
    }
    
    protected function format_residential($result) {
	$list = array();
	foreach($result as $row) {
	    array_push($list, array('id'       => $row['id'],
				    'title'    => $row['title'],
				    'location' => $row['location'],
				    'other'    => $row['other'],
				    'desc'     => $this->get_description($row) 
			   ));
	}
	return $list;
    }

    protected function format_commercial_contact($result) {
	$list = array();
	foreach($result as $row) {
	    array_push($list, array('id' => $row['id'],
				    'title'=> $row['title'],
				    'location' => $row['location'],
				    'other'    => $row['other'],
				    'desc'     => $this->get_description($row,true),
				    'contact'  => $row['contact']
			   ));
	}
	return $list;
    }
    
    protected function format_commercial($result) {
	
	$list = array();
	foreach($result as $row) {
	    array_push($list, array('id' => $row['id'],
				    'title'=> $row['title'],
				    'location' => $row['location'],
				    'other'    => $row['other'],
				    'desc'     => $this->get_description($row,true)
			   ));
	}
	return $list;
    }


    protected function get_contacts_from_ids($contact_ids) {
	$query = 'SELECT email, Concat(f_name," ",l_name) as name FROM pb_address_book WHERE id in (';
	foreach ($contact_ids as $id) {
	    $in_list  .= ($in_list == '') ? $id : ', '.$id;
	}
	$query  .= $in_list.');';
	$result  = $this->dbconn->execute_query($query);
	return $result;
    }

    protected function get_properties_from_id($prop_ids, $category) {
	$query = '';
	if($category == 1) {
	    $query = 'SELECT prop_id as id, name as title, pr.address as location, '.
		'Concat(ab.f_name, " ", ab.l_name, " ( ", ab.phone," ) " ) as contact '.
		'FROM pb_commercial pr, pb_txn_type pt, pb_address_book ab  '.
		'WHERE pr.contact = ab.id and pr.txn_type = pt.type_id and pt.description = \'Rent\' and pr.prop_id in (';
	    foreach ($prop_ids as $id) {
		$in_list  .= ($in_list == '') ? $id : ', '.$id;
	    }
	    $query  .= $in_list.');';
	} elseif ($category == 2) {
	    $query = 'SELECT prop_id as id, name as title, pr.address as location, '.
		'Concat(ab.f_name, " ", ab.l_name, " ( ", ab.phone," ) " ) as contact '.
		'FROM pb_residential pr, pb_txn_type pt, pb_address_book ab  '.
		'WHERE pr.contact = ab.id and pr.txn_type = pt.type_id and pt.description = \'Rent\' and pr.prop_id in (';
	    foreach ($prop_ids as $id) {
		$in_list  .= ($in_list == '') ? $id : ', '.$id;
	    }
	    $query  .= $in_list.');';
	}

	$result  = $this->dbconn->execute_query($query);
	return $result;
    }

    protected function delete_property($prop_id, $prop_type, $txn_type) {

	if ($prop_type == 2) {
	    $table_name = 'pb_residential';
	} elseif($prop_type == 1) {
	    $table_name = 'pb_commercial';
	}
	$query = 'DELETE from '.$table_name.' WHERE prop_id in (';
	foreach ($prop_id as $id) {
	    $in_list  .= ($in_list == '') ? $id : ', '.$id;
	}
	$query .= $in_list.')';

//	$this->dbconn->delete($query);
    }

    protected function delete_contacts($ids) {
	$in_list = '';
	foreach ($ids as $id) {
	    $in_list  .= ($in_list == '') ? $id : ', '.$id;
	}
	$query = 'DELETE FROM pb_residential where contact in ('.$in_list.')';
	$this->dbconn->delete($query);

	$query = 'DELETE FROM pb_commercial WHERE contact in ('.$in_list.')';
	$this->dbconn->delete($query);
	
	$query = 'DELETE FROM pb_address_book WHERE id in ('.$in_list.')';
	$this->dbconn->delete($query);

    }

    protected function get_contact_from_id($id) {
	$query = 'SELECT Concat(f_name," ", l_name) as name, phone, email FROM pb_address_book where id = '.$id;
	$result = $this->dbconn->execute_query($query);
	if (count($result) > 0) {
	    return $result[0];
	}
	return ;
    }
    
    protected function get_descriptive_residential($row) {
	/* Function that takes a hash of RECORD type and returns a descriptive form ... title, desc, locan..etc */
	$n_row['title']    = $row['name'];
	$n_row['location'] = $row['address'];
	$n_row['desc']     = $this->get_description($row);
	return $n_row;
    }
    protected function get_descriptive_commercial($row) {
	/* Function that takes a hash of RECORD type and returns a descriptive form ... title, desc, locan..etc */
	$n_row['title']    = $row['name'];
	$n_row['location'] = $row['address'];
	$n_row['desc']     = $this->get_description($row,true);
	return $n_row;
    }

    protected function get_description($row, $commercial = false) {
	$desc = '';
	if($commercial) {
	    $desc .= $row['prop_type'];
	    if($row['elec_capacity'] > 0) {
		$desc .= 'Electricity capacity : '.$row['elec_capacity'].' MW';
	    }

	    $result = $this->dbconn->execute_query('SELECT description as internet FROM pb_internet WHERE id ='.$row['internet']);
	    if(isset($result[0]['internet']) and $result[0]['internet'] != '') {
		$desc .= ', Internet facility: '.$result[0]['internet'];
	    }

	    $result = $this->dbconn->execute_query('SELECT description as lift FROM pb_lift_facility WHERE id ='.$row['lift']);
	    if(isset($result[0]['lift']) and $result[0]['lift'] != '') {
		$desc .= ', has lift facility ';
	    }

	    if($row['fire_safety'] == 1) {
		$desc .= 'with fire safety.';
	    }

	} else {
	    $desc = $row['prop_type'].' with '.$row['bedrooms'].' bedrooms';
	    if($row['floor'] > 0) {
		if($row['prop_type'] == 'Independent House') {
		    $desc .= ', '.$row['floor'].' floors.';
		} elseif( $row['prop_type'] == 'Apartment / Flat') {
		    $desc .= ', located in '.$row['floor'].' floor';
		    if($row['terrace'] > 0) {
			$desc .= ' with '.$row['terrace'].' terrace';
		    }
		}
	    }

	    if($row['garden'] > 0) { $desc .= ", with garden,"; }
	    if ($row['balcony'] > 0 ) { $desc .= (($row['garden'] > 0 )? 'and balcony.' : ', with balcony'); }
	    
	    $furnished = false;
	    $result = $this->dbconn->execute_query('SELECT description as furnished FROM pb_furnished WHERE furnished_id ='.
						   $row['furnished']);
	    if(isset($result[0]['furnished']) and $result[0]['furnished'] != '') {
		$desc .= '<br/>Property is '.$result[0]['furnished'];
		$furnished = true;
	    }

	    $result = $this->dbconn->execute_query('SELECT description as lift FROM pb_lift_facility WHERE id ='.$row['lift']);
	    if(isset($result[0]['lift']) and $result[0]['lift'] != '') {
		$desc .= ($furnished ? ', has lift facility ' : '<br/>Property has lift facility');
	    }
	}
	return $desc;

    }

}

?>