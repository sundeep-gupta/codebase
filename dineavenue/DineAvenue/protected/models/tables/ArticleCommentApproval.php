<?php

/**
 * This is the model class for table "{{article_comment_approval}}".
 *
 * The followings are the available columns in table '{{article_comment_approval}}':
 * @property string $id
 * @property string $comment_id
 * @property string $submittime
 * @property string $approver_id
 * @property string $approvetime
 * @property integer $approved
 */
class ArticleCommentApproval extends CActiveRecord
{
	/**
	 * Returns the static model of the specified AR class.
	 * @param string $className active record class name.
	 * @return ArticleCommentApproval the static model class
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
		return '{{article_comment_approval}}';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('comment_id, submittime, approver_id, approvetime, approved', 'required'),
			array('approved', 'numerical', 'integerOnly'=>true),
			array('comment_id, submittime, approver_id, approvetime', 'length', 'max'=>10),
			// The following rule is used by search().
			// Please remove those attributes that should not be searched.
			array('id, comment_id, submittime, approver_id, approvetime, approved', 'safe', 'on'=>'search'),
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
			'comment_id' => 'Comment',
			'submittime' => 'Submittime',
			'approver_id' => 'Approver',
			'approvetime' => 'Approvetime',
			'approved' => 'Approved',
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
		$criteria->compare('comment_id',$this->comment_id,true);
		$criteria->compare('submittime',$this->submittime,true);
		$criteria->compare('approver_id',$this->approver_id,true);
		$criteria->compare('approvetime',$this->approvetime,true);
		$criteria->compare('approved',$this->approved);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}
}