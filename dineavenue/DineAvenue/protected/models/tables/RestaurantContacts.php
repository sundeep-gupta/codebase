<?php

/**
 * This is the model class for table "{{restaurant_contacts}}".
 *
 * The followings are the available columns in table '{{restaurant_contacts}}':
 * @property integer $id
 * @property string $restaurant_id
 * @property string $contact_type
 * @property string $contact_details
 *
 * The followings are the available model relations:
 * @property Restaurant $rESTAURANT
 * @property Restaurant $restaurant
 */
class RestaurantContacts extends CActiveRecord
{
  
    const PHONE = 1;
	/**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return RestaurantContacts the static model class
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
		return '{{restaurant_contacts}}';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('id, restaurant_id, contact_details', 'required'),
			array('id', 'numerical', 'integerOnly'=>true),
			array('restaurant_id, contact_type', 'length', 'max'=>10),
			array('contact_details', 'length', 'max'=>100),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, restaurant_id, contact_type, contact_details', 'safe', 'on'=>'search'),
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
			'rESTAURANT' => array(self::BELONGS_TO, 'Restaurant', 'RESTAURANT_ID'),
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
			'contact_type' => 'Contact Type',
			'contact_details' => 'Contact Details',
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
		$criteria->compare('contact_type',$this->contact_type,true);
		$criteria->compare('contact_details',$this->contact_details,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
}