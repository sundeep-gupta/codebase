<?php

/**
 * This is the model class for table "{{coupon_redeem}}".
 *
 * The followings are the available columns in table '{{coupon_redeem}}':
 * @property string $id
 * @property string $coupon_code_id
 * @property string $redeem_time
 * @property string $redeem_ip
 * @property string $order_id
 */
class CouponRedeem extends CActiveRecord
{
	/**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return CouponRedeem the static model class
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
		return '{{coupon_redeem}}';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('coupon_code_id, redeem_time, order_id', 'required'),
			array('coupon_code_id, order_id', 'length', 'max'=>10),
			array('redeem_time', 'length', 'max'=>12),
			array('redeem_ip', 'length', 'max'=>100),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, coupon_code_id, redeem_time, redeem_ip, order_id', 'safe', 'on'=>'search'),
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
			'coupon_code_id' => 'Coupon Code',
			'redeem_time' => 'Redeem Time',
			'redeem_ip' => 'Redeem Ip',
			'order_id' => 'Order',
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
		$criteria->compare('coupon_code_id',$this->coupon_code_id,true);
		$criteria->compare('redeem_time',$this->redeem_time,true);
		$criteria->compare('redeem_ip',$this->redeem_ip,true);
		$criteria->compare('order_id',$this->order_id,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
}