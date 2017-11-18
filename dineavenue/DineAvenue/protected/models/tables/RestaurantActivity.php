<?php

/**
 * This is the model class for table "{{restaurant_activity}}".
 *
 * The followings are the available columns in table '{{restaurant_activity}}':
 * @property string $id
 * @property string $restaurant_id
 * @property string $createtime
 * @property string $starttime
 * @property string $endtime
 * @property string $description
 */
class RestaurantActivity extends CActiveRecord
{
	/**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return RestaurantActivity the static model class
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
		return '{{restaurant_activity}}';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('restaurant_id, createtime, starttime, endtime, description', 'required'),
			array('restaurant_id, createtime, starttime, endtime', 'length', 'max'=>10),
			array('description', 'length', 'max'=>250),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, restaurant_id, createtime, starttime, endtime, description', 'safe', 'on'=>'search'),
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
			'createtime' => 'Createtime',
			'starttime' => 'Starttime',
			'endtime' => 'Endtime',
			'description' => 'Description',
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
		$criteria->compare('createtime',$this->createtime,true);
		$criteria->compare('starttime',$this->starttime,true);
		$criteria->compare('endtime',$this->endtime,true);
		$criteria->compare('description',$this->description,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
}