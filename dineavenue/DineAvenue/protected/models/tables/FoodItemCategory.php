<?php

/**
 * This is the model class for table "{{food_item_category}}".
 *
 * The followings are the available columns in table '{{food_item_category}}':
 * @property string $ID
 * @property string $NAME
 * @property string $PARENT_CATEGORY
 * @property string $DESCRIPTION
 *
 * The followings are the available model relations:
 * @property FoodItem[] $foodItems
 */
class FoodItemCategory extends CActiveRecord
{
	/**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return FoodItemCategory the static model class
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
		return '{{food_item_category}}';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('NAME', 'required'),
			array('NAME', 'length', 'max'=>50),
			array('PARENT_CATEGORY', 'length', 'max'=>10),
			array('DESCRIPTION', 'length', 'max'=>250),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('ID, NAME, PARENT_CATEGORY, DESCRIPTION', 'safe', 'on'=>'search'),
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
			'foodItems' => array(self::HAS_MANY, 'FoodItem', 'CATEGORY_ID'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'ID' => 'ID',
			'NAME' => 'Name',
			'PARENT_CATEGORY' => 'Parent Category',
			'DESCRIPTION' => 'Description',
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

		$criteria->compare('ID',$this->ID,true);
		$criteria->compare('NAME',$this->NAME,true);
		$criteria->compare('PARENT_CATEGORY',$this->PARENT_CATEGORY,true);
		$criteria->compare('DESCRIPTION',$this->DESCRIPTION,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
}