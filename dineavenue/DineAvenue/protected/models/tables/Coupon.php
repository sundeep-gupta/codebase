<?php

/**
 * This is the model class for table "{{coupon}}".
 *
 * The followings are the available columns in table '{{coupon}}':
 * @property string $id
 * @property string $description
 * @property string $start_date
 * @property string $end_date
 * @property string $create_time
 * @property string $modified_time
 * @property string $modified_by
 * @property integer $published
 * @property string $discount_type
 * @property string $discount_value
 */
class Coupon extends CActiveRecord
{
	/**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return Coupon the static model class
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
		return '{{coupon}}';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('description, start_date, end_date, create_time, modified_time, modified_by, published, discount_type, discount_value', 'required'),
			array('published', 'numerical', 'integerOnly'=>true),
			array('description', 'length', 'max'=>300),
			array('start_date, end_date, create_time, modified_time', 'length', 'max'=>12),
			array('modified_by, discount_type', 'length', 'max'=>10),
			array('discount_value', 'length', 'max'=>255),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, description, start_date, end_date, create_time, modified_time, modified_by, published, discount_type, discount_value', 'safe', 'on'=>'search'),
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
			'description' => 'Description',
			'start_date' => 'Start Date',
			'end_date' => 'End Date',
			'create_time' => 'Create Time',
			'modified_time' => 'Modified Time',
			'modified_by' => 'Modified By',
			'published' => 'Published',
			'discount_type' => 'Discount Type',
			'discount_value' => 'Discount Value',
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
		$criteria->compare('description',$this->description,true);
		$criteria->compare('start_date',$this->start_date,true);
		$criteria->compare('end_date',$this->end_date,true);
		$criteria->compare('create_time',$this->create_time,true);
		$criteria->compare('modified_time',$this->modified_time,true);
		$criteria->compare('modified_by',$this->modified_by,true);
		$criteria->compare('published',$this->published);
		$criteria->compare('discount_type',$this->discount_type,true);
		$criteria->compare('discount_value',$this->discount_value,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

  protected function beforeValidate() {
    if ($this->isNewRecord) {
      $this->create_time = $this->modified_time = time();
      $this->modified_by = Yii::app()->user->id;
    } else {
      $this->modified_time = time();
      $this->modified_by = Yii::app()->user->id;
    }
  }
  
}