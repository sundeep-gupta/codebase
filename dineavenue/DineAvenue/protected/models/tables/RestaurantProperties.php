<?php

/**
 * This is the model class for table "{{restaurant_properties}}".
 *
 * The followings are the available columns in table '{{restaurant_properties}}':
 * @property string $id
 * @property string $restaurant_id
 * @property string $property_id
 * @property string $value
 *
 * The followings are the available model relations:
 * @property Restaurant $restaurant
 * @property EntityAttributes $property
 */
class RestaurantProperties extends CActiveRecord
{
  
  private $DISPLAY = array('PARKING', 'VEGETARIAN', 'DINING','TAKEAWAY', 'DELIVERY');
    
  const VEGETARIAN = 'VEGETARIAN';
  const NON_VEGETARIAN = 'NONVEGETARIAN';
  const BOOLEAN_TYPE_FIELD = 'VALUE_3';
  const STRING_TYPE_FIELD = 'VALUE_2';
  const NUMBER_TYPE_FIELD = 'VALUE_1';
	/**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return RestaurantProperties the static model class
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
		return '{{restaurant_properties}}';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('restaurant_id, property_id', 'required'),
			array('restaurant_id, property_id', 'length', 'max'=>10),
			array('value', 'length', 'max'=>255),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, restaurant_id, property_id, value', 'safe', 'on'=>'search'),
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
			'restaurant' => array(self::BELONGS_TO, 'Restaurant', 'restaurant_id'),
			'property' => array(self::BELONGS_TO, 'EntityAttributes', 'property_id'),
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
			'property_id' => 'Property',
			'value' => 'Value',
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
		$criteria->compare('restaurant_id',$this->restaurant_id,true);
		$criteria->compare('property_id',$this->property_id,true);
		$criteria->compare('value',$this->value,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

  public function findDisplayPropertiesByRestaurant($restaurant_id) {
      $criteria = new CDbCriteria();
      $criteria->with = array('property');
      $criteria->condition = 'restaurant_id = :restaurant_id AND property_id = property.id';
      $criteria->params = array(':restaurant_id' => $restaurant_id);
      $criteria->addInCondition('property.name', $this->DISPLAY); 
      $this->dbCriteria = $criteria;
      $ra_restaurant_props = $this->findAll();
      return $ra_restaurant_props;
    }

  public function getFacilities($ra_props) {
    $ra_restaurant_properties = array();
    $m_attributes = EntityAttributes::model();
    foreach ($ra_props as $restaurant_property) {
      $ar_attribute = $m_attributes->findByPk($restaurant_property->property_id);
      if ($ar_attribute) {
        if ($ar_attribute->type == EntityAttributes::BOOLEAN_TYPE) {
          $field = RestaurantProperties::BOOLEAN_TYPE_FIELD;
          
          $ra_restaurant_properties[$ar_attribute->name] = false;
          if ($restaurant_property->$field == '1') { 
            $ra_restaurant_properties[$ar_attribute->name] = true;
          }
        } elseif($ar_attribute->type == EntityAttributes::STRING_TYPE) {
          $field = RestaurantProperties::STRING_TYPE_FIELD;
          #$ra_restaurant_properties[$ar_attribute->name] = $restaurant_property->$field;
          $ra_restaurant_properties[$ar_attribute->name] = $restaurant_property->value;
        } elseif ($ar_attribute->type == EntityAttributes::NUMBER_TYPE) {
          $field = RestaurantProperties::NUMBER_TYPE_FIELD;
          #$ra_restaurant_properties[$ar_attribute->name] = $restaurant_property->$field;
          $ra_restaurant_properties[$ar_attribute->name] = $restaurant_property->value;
        }
      }
    }
    return $ra_restaurant_properties;
  }
  
}