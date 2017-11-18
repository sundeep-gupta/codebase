<?php

/**
 * This is the model class for table "{{image}}".
 *
 * The followings are the available columns in table '{{image}}':
 * @property string $id
 * @property string $type
 * @property string $content
 * @property string $size
 * @property string $category
 * @property string $name
 *
 * The followings are the available model relations:
 * @property CouponImages[] $couponImages
 * @property FoodItem[] $x2FoodItems
 * @property Restaurant[] $x2Restaurants
 */
class Image extends CActiveRecord
{
	/**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return Image the static model class
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
		return '{{image}}';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('type, content, size, category, name', 'required'),
			array('type, size, category', 'length', 'max'=>25),
			array('name', 'length', 'max'=>50),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, type, content, size, category, name', 'safe', 'on'=>'search'),
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
			'couponImages' => array(self::HAS_MANY, 'CouponImages', 'image_id'),
			'x2FoodItems' => array(self::MANY_MANY, 'FoodItem', '{{food_item_images}}(image_id, food_item_id)'),
			'x2Restaurants' => array(self::MANY_MANY, 'Restaurant', '{{restaurant_images}}(image_id, restaurant_id)'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id' => 'ID',
			'type' => 'Type',
			'content' => 'Content',
			'size' => 'Size',
			'category' => 'Category',
			'name' => 'Name',
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
		$criteria->compare('type',$this->type,true);
		$criteria->compare('content',$this->content,true);
		$criteria->compare('size',$this->size,true);
		$criteria->compare('category',$this->category,true);
		$criteria->compare('name',$this->name,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
}