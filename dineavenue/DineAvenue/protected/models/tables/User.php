<?php

/**
 * This is the model class for table "{{user}}".
 *
 * The followings are the available columns in table '{{user}}':
 * @property string $id
 * @property string $username
 * @property string $password
 * @property string $email
 * @property string $firstname
 * @property string $lastname
 * @property integer $dob
 * @property string $activkey
 * @property integer $createtime
 * @property integer $lastvisit
 * @property integer $status
 *
 * The followings are the available model relations:
 * @property Article[] $articles
 * @property AuthAssignment[] $authAssignments
 * @property RestaurantGroup[] $restaurantGroups
 * @property UserAddress[] $userAddresses
 * @property UserContacts[] $userContacts
 */
class User extends CActiveRecord
{
  public $password_repeat;
  public $verifyCode;
	/**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return User the static model class
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
		return '{{user}}';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('username, password, email', 'required'),
			array('dob, createtime, lastvisit, status', 'numerical', 'integerOnly'=>true),
			array('username, password, email, activkey', 'length', 'max'=>128),
      array('password', 'compare'),
      array('password_repeat', 'safe'),
      array('verifyCode', 'captcha', 'allowEmpty' => ! CCaptcha::checkRequirements()),
			array('firstname, lastname', 'length', 'max'=>20),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, username, password, email, firstname, lastname, dob, activkey, createtime, lastvisit, status', 'safe', 'on'=>'search'),
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
			'articles' => array(self::HAS_MANY, 'Article', 'user_id'),
			'authAssignments' => array(self::HAS_MANY, 'AuthAssignment', 'userid'),
			'restaurantGroups' => array(self::HAS_MANY, 'RestaurantGroup', 'user_id'),
			'userAddresses' => array(self::HAS_MANY, 'UserAddress', 'user_id'),
			'userContacts' => array(self::HAS_MANY, 'UserContacts', 'user_id'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id' => 'ID',
			'username' => 'Username',
			'password' => 'Password',
			'email' => 'Email',
			'firstname' => 'Firstname',
			'lastname' => 'Lastname',
			'dob' => 'Dob',
			'activkey' => 'Activkey',
			'createtime' => 'Createtime',
			'lastvisit' => 'Lastvisit',
			'status' => 'Status',
      'verifyCode' => 'Verify Captcha'
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
		$criteria->compare('username',$this->username,true);
		$criteria->compare('password',$this->password,true);
		$criteria->compare('email',$this->email,true);
		$criteria->compare('firstname',$this->firstname,true);
		$criteria->compare('lastname',$this->lastname,true);
		$criteria->compare('dob',$this->dob);
		$criteria->compare('activkey',$this->activkey,true);
		$criteria->compare('createtime',$this->createtime);
		$criteria->compare('lastvisit',$this->lastvisit);
		$criteria->compare('status',$this->status);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}


  protected function beforeValidate() {
    if ($this->isNewRecord) {
      $this->activkey = $this->encrypt(microtime() . $this->password);
      $this->createtime = time();
      $this->lastvisit = time();
      $this->status = 0;
    }
    return parent::beforeValidate();
  }

  protected function afterValidate(){
    parent::afterValidate();
    if ($this->isNewRecord) {
      $this->password = $this->encrypt($this->password);
    }
  }

  public function encrypt($value) {
    return md5($value);
  }
}