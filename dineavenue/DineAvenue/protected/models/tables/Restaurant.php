<?php

/**
 * This is the model class for table "{{restaurant}}".
 *
 * The followings are the available columns in table '{{restaurant}}':
 * @property string $id
 * @property string $name
 * @property string $group_id
 * @property string $createtime
 * @property string $about
 *
 * The followings are the available model relations:
 * @property RestaurantGroup $group
 * @property RestaurantAddress[] $restaurantAddresses
 * @property RestaurantContacts[] $restaurantContacts
 * @property RestaurantContacts[] $restaurantContacts1
 * @property Image[] $x2Images
 * @property RestaurantMenu[] $restaurantMenus
 * @property RestaurantProperties[] $restaurantProperties
 */
class Restaurant extends CActiveRecord
{
	/**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return Restaurant the static model class
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
		return '{{restaurant}}';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('name, group_id, about', 'required'),
			array('name', 'length', 'max'=>60),
			array('group_id, createtime', 'length', 'max'=>10),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, name, group_id, createtime, about', 'safe', 'on'=>'search'),
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
			'group' => array(self::BELONGS_TO, 'RestaurantGroup', 'group_id'),
			'restaurantAddresses' => array(self::HAS_MANY, 'RestaurantAddress', 'restaurant_id'),
			'restaurantContacts' => array(self::HAS_MANY, 'RestaurantContacts', 'restaurant_id'),
			'restaurantContacts1' => array(self::HAS_MANY, 'RestaurantContacts', 'restaurant_id'),
			'x2Images' => array(self::MANY_MANY, 'Image', '{{restaurant_images}}(restaurant_id, image_id)'),
			'restaurantMenus' => array(self::HAS_MANY, 'RestaurantMenu', 'restaurant_id'),
			'restaurantProperties' => array(self::HAS_MANY, 'RestaurantProperties', 'restaurant_id'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id' => 'ID',
			'name' => 'Name',
			'group_id' => 'Group',
			'createtime' => 'Createtime',
			'about' => 'About',
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

		$criteria->compare('id',$this->id,true);
		$criteria->compare('name',$this->name,true);
		$criteria->compare('group_id',$this->group_id,true);
		$criteria->compare('createtime',$this->createtime,true);
		$criteria->compare('about',$this->about,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

   
  public function findBySmartName ($id) {
    $ra_restaurant_group = RestaurantGroup::model()->findAllByAttributes(array(), 'smart_name = :smart_name'
            , array('smart_name' => $id));
    $ra_restaurant = array();
    foreach ($ra_restaurant_group as $restaurant_group) {
      $ra_restaurant = array_merge($ra_restaurant, $restaurant_group->restaurants);
    }
    #$criteria->addCondition('group.id = restaurant.group_id AND group.smart_name LIKE :smart_name'
    #        , array('smart_name' => '%'. $id .'%'));
    $restaurant = Restaurant::model()->findByPk($id);
    if(!empty($restaurant)) {
      array_push($ra_restaurant, $restaurant);
    }
    $rh_restaurant = array();
    foreach ($ra_restaurant as $restaurant) {
      $rh_restaurant[$restaurant->id] = $restaurant;
    }
    $ra_restaurant = array_values($rh_restaurant);
    return $ra_restaurant;
  }
  
}