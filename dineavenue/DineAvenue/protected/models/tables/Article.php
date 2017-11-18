<?php

/**
 * This is the model class for table "{{article}}".
 *
 * The followings are the available columns in table '{{article}}':
 * @property string $id
 * @property string $user_id
 * @property string $title
 * @property string $text
 * @property string $createtime
 * @property string $modifiedtime
 * @property string $visits
 * @property integer $published
 *
 * The followings are the available model relations:
 * @property User $user
 */
class Article extends CActiveRecord
{
	/**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return Article the static model class
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
		return '{{article}}';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('user_id, title, text, createtime, modifiedtime, visits, published', 'required'),
			array('published', 'numerical', 'integerOnly'=>true),
			array('user_id, createtime, modifiedtime, visits', 'length', 'max'=>10),
			array('title', 'length', 'max'=>50),
			array('text', 'length', 'max'=>5000),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, user_id, title, text, createtime, modifiedtime, visits, published', 'safe', 'on'=>'search'),
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
			'user' => array(self::BELONGS_TO, 'User', 'user_id'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id' => 'ID',
			'user_id' => 'User',
			'title' => 'Title',
			'text' => 'Text',
			'createtime' => 'Createtime',
			'modifiedtime' => 'Modifiedtime',
			'visits' => 'Visits',
			'published' => 'Published',
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
		$criteria->compare('user_id',$this->user_id,true);
		$criteria->compare('title',$this->title,true);
		$criteria->compare('text',$this->text,true);
		$criteria->compare('createtime',$this->createtime,true);
		$criteria->compare('modifiedtime',$this->modifiedtime,true);
		$criteria->compare('visits',$this->visits,true);
		$criteria->compare('published',$this->published);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

  public function findAllRecentPosts() {
    return Article::model()->findAll();
  }
  
  protected function beforeValidate() {
      
      if ($this->isNewRecord) {
        $this->user_id = Yii::app()->user->id;
        $this->createtime = $this->modifiedtime = time();
        $this->visits = 0;
      } else {
        $this->modifiedtime = time();
      }
      $this->published = 0;
      echo "Returning from beforeSave()";
      return parent::beforeValidate();
    }
}