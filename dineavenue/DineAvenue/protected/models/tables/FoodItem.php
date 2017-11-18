<?php

/**
 * This is the model class for table "{{food_item}}".
 *
 * The followings are the available columns in table '{{food_item}}':
 * @property string $id
 * @property string $name
 * @property string $description
 * @property string $category_id
 *
 * The followings are the available model relations:
 * @property FoodItemCategory $cATEGORY
 * @property Image[] $x2Images
 * @property RestaurantMenuDetails[] $restaurantMenuDetails
 */
class FoodItem extends CActiveRecord
{
	/**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return FoodItem the static model class
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
		return '{{food_item}}';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('name, description, category_id', 'required'),
			array('name', 'length', 'max'=>60),
			array('description', 'length', 'max'=>250),
			array('category_id', 'length', 'max'=>10),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, name, description, category_id', 'safe', 'on'=>'search'),
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
			'cATEGORY' => array(self::BELONGS_TO, 'FoodItemCategory', 'CATEGORY_ID'),
			'x2Images' => array(self::MANY_MANY, 'Image', '{{food_item_images}}(food_item_id, image_id)'),
			'restaurantMenuDetails' => array(self::HAS_MANY, 'RestaurantMenuDetails', 'MENU_ITEM_ID'),
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
			'description' => 'Description',
			'category_id' => 'Category',
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
		$criteria->compare('description',$this->description,true);
		$criteria->compare('category_id',$this->category_id,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
}