<?php

/**
 * This is the model class for table "{{restaurant_address}}".
 *
 * The followings are the available columns in table '{{restaurant_address}}':
 * @property integer $id
 * @property string $restaurant_id
 * @property string $line1
 * @property string $line2
 * @property string $landmark
 * @property string $location_id
 * @property string $latitude
 * @property string $longitude
 * @property string $zipcode
 *
 * The followings are the available model relations:
 * @property Locations $location
 * @property Restaurant $restaurant
 */
class RestaurantAddress extends CActiveRecord
{
	/**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return RestaurantAddress the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}

	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return '{{restaurant_address}}';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('line1, line2, landmark, location_id, latitude, longitude, zipcode', 'required'),
			array('restaurant_id, location_id', 'length', 'max'=>10),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, restaurant_id, line1, line2, landmark, location_id, latitude, longitude, zipcode', 'safe', 'on'=>'search'),
		);
	}

	/**
	 * @return array relational rules.
	 */
	public function relations()
	{
		// NOTE: you may need to adjust the relation name and the related
		// class name for the relations automatically generated below.
		return array(
			'location' => array(self::BELONGS_TO, 'Locations', 'location_id'),
			'restaurant' => array(self::BELONGS_TO, 'Restaurant', 'restaurant_id'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id' => 'ID',
			'restaurant_id' => 'Restaurant',
			'line1' => 'Line1',
			'line2' => 'Line2',
			'landmark' => 'Landmark',
			'location_id' => 'Location',
			'latitude' => 'Latitude',
			'longitude' => 'Longitude',
			'zipcode' => 'Zipcode',
		);
	}

	/**
	 * Retrieves a list of models based on the current search/filter conditions.
	 * @return CActiveDataProvider the data provider that can return the models based on the search/filter conditions.
	 */
	public function search()
	{
		// Warning: Please modify the following code to remove attributes that
		// should not be searched.

		$criteria=new CDbCriteria;

		$criteria->compare('id',$this->id);
		$criteria->compare('restaurant_id',$this->restaurant_id,true);
		$criteria->compare('line1',$this->line1,true);
		$criteria->compare('line2',$this->line2,true);
		$criteria->compare('landmark',$this->landmark,true);
		$criteria->compare('location_id',$this->location_id,true);
		$criteria->compare('latitude',$this->latitude,true);
		$criteria->compare('longitude',$this->longitude,true);
		$criteria->compare('zipcode',$this->zipcode,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
  
  /* TODO : Remove the SQL statements and have DAO operations */
  public function findByZipOrItemServed($q) {
    
    $ra_address = array();
    $ra_restaurants = Restaurant::model()->findAllByAttributes(array(), 'name = :name', array('name' => $q));
    //$ra_address = Restaurant::model()->findAllByAttributes(array('name' => ':name'), '', array('name' => $q));
    $ra_restaurant_groups = RestaurantGroup::model()->findAllByAttributes(array(), 'name like :name'
            , array('name' => '%'. $q .'%'));
    $ra_locations = Locations::model()->findAllByAttributes(array(),'zip = :zip', array('zip' => $q));
    
    $ra_food_item = FoodItem::model()->findAllByAttributes(array(), 'name = :name', array('name' => $q) );
    foreach ($ra_restaurants as $restaurant) {
      array_push($ra_address, $restaurant->restaurantAddresses[0]);
    }
    foreach ($ra_restaurant_groups as $restaurant_group) {
      foreach ($restaurant_group->restaurants as $restaurant) {
        array_push($ra_address, $restaurant->restaurantAddresses[0]);
      }
    }
    foreach ($ra_locations as $location) {
      $ra_address = array_merge($ra_address, $location->restaurantAddresses);
    }
    foreach ($ra_food_item as $food_item) {
      foreach ($food_item->restaurantMenuDetails as $menu_details) {
        foreach ($menu_details as $menu_detail) {
          array_push($ra_address, $menu_detail->restaurantMenu->restaurant->restaurantAddresses[0]);
        }
      }
    }
    /*
    $params = array();
    $inner_sql1 = "SELECT ID FROM X2_FOOD_ITEM WHERE NAME LIKE :name";
    $inner_sql2 = "SELECT RESTAURANT_ID FROM X2_RESTAURANT_MENU_DETAILS WHERE MENU_ITEM_ID IN ($inner_sql1)";
    $sql = "SELECT * FROM " . $this->tableName() . " WHERE ZIPCODE = :zip OR RESTAURANT_ID IN ($inner_sql2)";
    $params[':zip'] = $q;
    $params[':name'] = $q;
    echo $sql;
    $ra_address = $this->findAllBySql($sql, $params);
     * 
     */
    //print_r($ra_address);
    return $ra_address;

  }

       /** TODO : improve these functions.. remove SQL.. use DAO **/
  public function findByLocationOrCuisineServed($ra_location_id, $ra_item_id) {
    if (!isset($ra_location_id) && ! isset($ra_item_id)) {
      return;
    }
    $params = array();

    $sql = "SELECT * FROM " . $this->tableName() . " WHERE ";
    if (isset($ra_location_id) && count($ra_location_id) > 0) {

      $sql .= "LOCATION_ID IN (" . join (',', $ra_location_id) . ")";
      # $params[':locations'] = join(', ', $ra_location_id);
    }
    if (isset($ra_item_id) && count($ra_item_id) > 0) {

      //$sql3 = "SELECT id from {{FOOD_ITEM}} WHERE "
    #  $params[':fooditems'] = join("," ,$ra_item_id);
      $sql2 = "SELECT RESTAURANT_ID FROM X2_RESTAURANT_MENU_DETAILS WHERE MENU_ITEM_ID IN ("
          . join(",", $ra_item_id) . ")";
      if(isset($ra_location_id)&& count($ra_location_id) > 0) {
        $sql .= "OR ";
      }
      $sql .= "RESTAURANT_ID IN ($sql2)";
    }
    $ra_address = $this->findAllBySql($sql);
    return $ra_address;

  }

}