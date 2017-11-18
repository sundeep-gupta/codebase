<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of SearchForm
 *
 * @author skgupta
 */
class SearchForm extends CFormModel {
  //put your code here
    public $city;
    public $locations;
    public $items;
    
	
	/**
	 * Declares the validation rules.
	 * The rules state that username and password are required,
	 * and password needs to be authenticated.
	 */
	public function rules() {
		return array();

	}

	/**
	 * Declares attribute labels.
	 */
	public function attributeLabels()
	{
		return array(
			'city'=>'Select City',
            'locations' => 'Select Location',
            'items' => 'Select Item',
		);
	}
    public function search() {
      // store the restaurant listings here after querying the db...
      /*$search_result = array('name' => 'Malabar Hills',
          'address' => 'Door 9, 6th Cross, Murugeshpalya',
          'rest_properies' => array ('rating' => '4.5', 'parking' => true, 
              'credit_card' => true,
              'takeaway' => true,
              'home delivery' => true,
              'price rating' => 6,
              'menu' => true,
              'serves non-veg' => true,
              'online order' => true,
              'online reservation' => true,
              ),
          'offers' => array()
          );
      
      return $search_result;*/
    }
}

?>
