<?php

/**
 * This is the model class for table "{{entity_attributes}}".
 *
 * The followings are the available columns in table '{{entity_attributes}}':
 * @property string $id
 * @property string $entity_id
 * @property string $name
 * @property string $type
 *
 * The followings are the available model relations:
 * @property Entity $entity
 * @property RestaurantFeedbackProperties[] $restaurantFeedbackProperties
 * @property RestaurantMenuItemProperties[] $restaurantMenuItemProperties
 * @property RestaurantMenuProperties[] $restaurantMenuProperties
 * @property RestaurantProperties[] $restaurantProperties
 */
class EntityAttributes extends CActiveRecord
{
    const BOOLEAN_TYPE = '3';
  const STRING_TYPE = '2';
  const NUMBER_TYPE = '1';
	/**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return EntityAttributes the static model class
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
		return '{{entity_attributes}}';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('entity_id, name, type', 'required'),
			array('entity_id', 'length', 'max'=>10),
			array('name', 'length', 'max'=>50),
			array('type', 'length', 'max'=>20),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, entity_id, name, type', 'safe', 'on'=>'search'),
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
			'entity' => array(self::BELONGS_TO, 'Entity', 'entity_id'),
			'restaurantFeedbackProperties' => array(self::HAS_MANY, 'RestaurantFeedbackProperties', 'feedback_id'),
			'restaurantMenuItemProperties' => array(self::HAS_MANY, 'RestaurantMenuItemProperties', 'property_id'),
			'restaurantMenuProperties' => array(self::HAS_MANY, 'RestaurantMenuProperties', 'property_id'),
			'restaurantProperties' => array(self::HAS_MANY, 'RestaurantProperties', 'PROPERTY_ID'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id' => 'ID',
			'entity_id' => 'Entity',
			'name' => 'Name',
			'type' => 'Type',
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
		$criteria->compare('entity_id',$this->entity_id,true);
		$criteria->compare('name',$this->name,true);
		$criteria->compare('type',$this->type,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
}