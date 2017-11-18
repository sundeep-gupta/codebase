<?php

/**
 * This is the model class for table "{{restaurant_menu_details}}".
 *
 * The followings are the available columns in table '{{restaurant_menu_details}}':
 * @property string $id
 * @property string $menu_id
 * @property string $menu_item_id
 * @property string $description
 * @property string $image
 *
 * The followings are the available model relations:
 * @property RestaurantMenu $menu
 * @property FoodItem $menuItem
 * @property RestaurantMenuItemProperties[] $restaurantMenuItemProperties
 * @property RestaurantMenuItemProperties[] $restaurantMenuItemProperties1
 */
class RestaurantMenuDetails extends CActiveRecord
{
	/**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return RestaurantMenuDetails the static model class
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
		return '{{restaurant_menu_details}}';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('menu_id, menu_item_id', 'required'),
			array('menu_id, menu_item_id', 'length', 'max'=>10),
			array('description', 'length', 'max'=>250),
			array('image', 'safe'),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, menu_id, menu_item_id, description, image', 'safe', 'on'=>'search'),
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
			'menu' => array(self::BELONGS_TO, 'RestaurantMenu', 'menu_id'),
			'menuItem' => array(self::BELONGS_TO, 'FoodItem', 'menu_item_id'),
			'restaurantMenuItemProperties' => array(self::HAS_MANY, 'RestaurantMenuItemProperties', 'menu_item_id'),
			'restaurantMenuItemProperties1' => array(self::HAS_MANY, 'RestaurantMenuItemProperties', 'menu_item_id'),
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
			'menu_item_id' => 'Menu Item',
			'description' => 'Description',
			'image' => 'Image',
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
		$criteria->compare('menu_item_id',$this->menu_item_id,true);
		$criteria->compare('description',$this->description,true);
		$criteria->compare('image',$this->image,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
}