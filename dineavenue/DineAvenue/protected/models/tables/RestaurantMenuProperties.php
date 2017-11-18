<?php

/**
 * This is the model class for table "{{restaurant_menu_properties}}".
 *
 * The followings are the available columns in table '{{restaurant_menu_properties}}':
 * @property string $id
 * @property string $menu_id
 * @property string $property_id
 * @property string $value
 *
 * The followings are the available model relations:
 * @property RestaurantMenu $mENU
 * @property FoodItemPropertyObsolete $pROPERTY
 * @property EntityAttributes $property
 */
class RestaurantMenuProperties extends CActiveRecord
{
	/**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return RestaurantMenuProperties the static model class
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
		return '{{restaurant_menu_properties}}';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('menu_id, property_id', 'required'),
			array('menu_id, property_id', 'length', 'max'=>10),
			array('value', 'length', 'max'=>255),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, menu_id, property_id, value', 'safe', 'on'=>'search'),
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
			'mENU' => array(self::BELONGS_TO, 'RestaurantMenu', 'MENU_ID'),
			'pROPERTY' => array(self::BELONGS_TO, 'FoodItemPropertyObsolete', 'PROPERTY_ID'),
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
			'menu_id' => 'Menu',
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
		$criteria->compare('menu_id',$this->menu_id,true);
		$criteria->compare('property_id',$this->property_id,true);
		$criteria->compare('value',$this->value,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
}