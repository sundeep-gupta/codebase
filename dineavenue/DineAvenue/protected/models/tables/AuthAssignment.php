<?php

/**
 * This is the model class for table "{{auth_assignment}}".
 *
 * The followings are the available columns in table '{{auth_assignment}}':
 * @property string $id
 * @property string $itemname
 * @property string $userid
 * @property string $role_id
 * @property string $bizrule
 *
 * The followings are the available model relations:
 * @property User $user
 * @property AuthItem $role
 */
class AuthAssignment extends CActiveRecord
{
	/**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return AuthAssignment the static model class
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
		return '{{auth_assignment}}';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('userid, role_id, bizrule', 'required'),
			array('itemname', 'length', 'max'=>64),
			array('userid, role_id', 'length', 'max'=>10),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, itemname, userid, role_id, bizrule', 'safe', 'on'=>'search'),
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
			'user' => array(self::BELONGS_TO, 'User', 'userid'),
			'role' => array(self::BELONGS_TO, 'AuthItem', 'role_id'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id' => 'ID',
			'itemname' => 'Itemname',
			'userid' => 'Userid',
			'role_id' => 'Role',
			'bizrule' => 'Bizrule',
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
		$criteria->compare('itemname',$this->itemname,true);
		$criteria->compare('userid',$this->userid,true);
		$criteria->compare('role_id',$this->role_id,true);
		$criteria->compare('bizrule',$this->bizrule,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
}