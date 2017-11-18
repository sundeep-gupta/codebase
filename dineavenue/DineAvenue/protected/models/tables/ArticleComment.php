<?php

/**
 * This is the model class for table "{{article_comment}}".
 *
 * The followings are the available columns in table '{{article_comment}}':
 * @property string $id
 * @property string $article_id
 * @property string $user_id
 * @property string $createtime
 * @property string $text
 * @property integer $published
 */
class ArticleComment extends CActiveRecord
{
	/**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return ArticleComment the static model class
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
		return '{{article_comment}}';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('id, article_id, user_id, createtime, text, published', 'required'),
			array('published', 'numerical', 'integerOnly'=>true),
			array('id, article_id, user_id, createtime', 'length', 'max'=>10),
			array('text', 'length', 'max'=>300),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, article_id, user_id, createtime, text, published', 'safe', 'on'=>'search'),
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
			'article_id' => 'Article',
			'user_id' => 'User',
			'createtime' => 'Createtime',
			'text' => 'Text',
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
		$criteria->compare('article_id',$this->article_id,true);
		$criteria->compare('user_id',$this->user_id,true);
		$criteria->compare('createtime',$this->createtime,true);
		$criteria->compare('text',$this->text,true);
		$criteria->compare('published',$this->published);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
}