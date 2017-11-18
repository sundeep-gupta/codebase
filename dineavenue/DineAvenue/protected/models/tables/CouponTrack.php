<?php

/**
 * This is the model class for table "{{coupon_track}}".
 *
 * The followings are the available columns in table '{{coupon_track}}':
 * @property string $id
 * @property string $coupon_code
 * @property string $coupon_id
 * @property string $user_id
 * @property string $name
 * @property string $create_time
 * @property string $email
 */
class CouponTrack extends CActiveRecord
{
	/**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return CouponTrack the static model class
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
		return '{{coupon_track}}';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('coupon_code, coupon_id, create_time', 'required'),
			array('coupon_code, name, email', 'length', 'max'=>128),
			array('coupon_id, user_id', 'length', 'max'=>10),
			array('create_time', 'length', 'max'=>12),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, coupon_code, coupon_id, user_id, name, create_time, email', 'safe', 'on'=>'search'),
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
			'coupon_code' => 'Coupon Code',
			'coupon_id' => 'Coupon',
			'user_id' => 'User',
			'name' => 'Name',
			'create_time' => 'Create Time',
			'email' => 'Email',
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
		$criteria->compare('coupon_code',$this->coupon_code,true);
		$criteria->compare('coupon_id',$this->coupon_id,true);
		$criteria->compare('user_id',$this->user_id,true);
		$criteria->compare('name',$this->name,true);
		$criteria->compare('create_time',$this->create_time,true);
		$criteria->compare('email',$this->email,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
}