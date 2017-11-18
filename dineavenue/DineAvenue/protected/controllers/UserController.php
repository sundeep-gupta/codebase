<?php
class UserController extends DAController {

	/**
	 * @var string the default layout for the views. Defaults to '//layouts/column2', meaning
	 * using two-column layout. See 'protected/views/layouts/column2.php'.
	 */
	public $layout='//layouts/column2';

  public function actions() {
    return array ('captcha' => array('class' => 'CCaptchaAction', 'backColor' => 0xFFFFFF));
  }

	/**
	 * @return array action filters
	 */
	public function filters() {
		return array(
			'accessControl', // perform access control for CRUD operations
		);
	}


	/**
	 * Specifies the access control rules.
	 * This method is used by the 'accessControl' filter.
	 * @return array access control rules
	 */
	public function accessRules() {
		return array(
			array('allow',  // allow all users to perform 'index' and 'view' actions
				'actions'=>array('register', 'index','view', 'login', 'captcha'),
				'users'=>array('*'),
			),
			array('allow', // allow authenticated user to perform 'create' and 'update' actions
				'actions'=>array('update', 'logout'),
				'users'=>array('@'),
			),
			array('allow', // allow admin user to perform 'admin' and 'delete' actions
				'actions'=>array('admin','delete'),
				'users'=>array('admin'),
			),
			array('deny',  // deny all users
				'users'=>array('*'),
			),
		);
	}
    /*
    protected function beforeAction(CAction $action) {
      $name = $action->id;
      $authorized = false;
      if ($name === 'view') {
        $authorized = Yii::app()->user->checkAccess('viewUser');
        if ($authorized) {
          return parent::beforeAction($action);
        } else {
          $this->redirect($this->createUrl('/'));
        }
      }
      return parent::beforeAction($action);
    }
     *
     */
    /**
	 * Displays a particular model.
	 * @param integer $id the ID of the model to be displayed
	 */
	public function actionView($id) {
		$this->render('view',array(
			'model'=>$this->loadModel($id),
		));
	}

	/**
	 * Creates a new model.
	 * If creation is successful, the browser will be redirected to the 'view' page.
	 */
	public function actionRegister()
	{
		$model=new User;

		// Uncomment the following line if AJAX validation is needed
		// $this->performAjaxValidation($model);

		if(isset($_POST['User']))
		{
			$model->attributes=$_POST['User'];
			if($model->save()) {
				$this->redirect(array('view','id'=>$model->id));
      } else {
        echo "Failed to save" ;
      }
		}
		$this->render('register',array('model'=>$model));
	}

	/**
	 * Updates a particular model.
	 * If update is successful, the browser will be redirected to the 'view' page.
	 * @param integer $id the ID of the model to be updated
	 */
	public function actionUpdate($id)
	{
		$model=$this->loadModel($id);

		// Uncomment the following line if AJAX validation is needed
		// $this->performAjaxValidation($model);

		if(isset($_POST['User']))
		{
			$model->attributes=$_POST['User'];
			if($model->save())
				$this->redirect(array('view','id'=>$model->id));
		}

		$this->render('update',array(
			'model'=>$model,
		));
	}

	/**
	 * Deletes a particular model.
	 * If deletion is successful, the browser will be redirected to the 'admin' page.
	 * @param integer $id the ID of the model to be deleted
	 */
	public function actionDelete($id)
	{
		if(Yii::app()->request->isPostRequest)
		{
			// we only allow deletion via POST request
			$this->loadModel($id)->delete();

			// if AJAX request (triggered by deletion via admin grid view), we should not redirect the browser
			if(!isset($_GET['ajax']))
				$this->redirect(isset($_POST['returnUrl']) ? $_POST['returnUrl'] : array('admin'));
		}
		else
			throw new CHttpException(400,'Invalid request. Please do not repeat this request again.');
	}

	/**
	 * Lists all models.
	 */
	public function actionIndex()
	{
		$dataProvider=new CActiveDataProvider('User');
        echo 'Hello';
		$this->render('index',array(
			'dataProvider'=>$dataProvider,
		));
	}

	/**
	 * Manages all models.
	 */
	public function actionAdmin()
	{
		$model=new User('search');
		$model->unsetAttributes();  // clear any default values
		if(isset($_GET['User']))
			$model->attributes=$_GET['User'];

		$this->render('admin',array(
			'model'=>$model,
		));
	}

	/**
	 * Returns the data model based on the primary key given in the GET variable.
	 * If the data model is not found, an HTTP exception will be raised.
	 * @param integer the ID of the model to be loaded
	 */
	public function loadModel($id)
	{
		$model=User::model()->findByPk($id);
		if($model===null)
			throw new CHttpException(404,'The requested page does not exist.');
		return $model;
	}

	/**
	 * Performs the AJAX validation.
	 * @param CModel the model to be validated
	 */
	protected function performAjaxValidation($model)
	{
		if(isset($_POST['ajax']) && $_POST['ajax']==='user-form')
		{
			echo CActiveForm::validate($model);
			Yii::app()->end();
		}
	}
	/**
	 * Displays the login page
	 */
	public function actionLogin() {
		$model = new LoginForm;
        Yii::log("Entered the login form");
		// if it is ajax validation request
		if(isset($_POST['ajax']) && $_POST['ajax']==='login-form')
		{
      echo "AJAX request recieved for login-form",'system.CModule';
			echo CActiveForm::validate($model);
      echo 'validated';
      $this->widget('ext.widgets.istack.X2Login');
			Yii::app()->end();
		}

		// collect user input data

		if(isset($_POST['LoginForm'])) {
			$model->attributes = $_POST['LoginForm'];
      echo $model->validate();

            // validate user input and redirect to the previous page if valid
			if($model->validate() && $model->login()) {
                // TODO : Redirect to old url
                if (Yii::app()->user->returnUrl) {
                  $this->redirect(Yii::app()->user->returnUrl);
                } else {
                  $this->redirect($this->createUrl('/'));
                }
            } else {
              echo "Error in login;";
            }
				//$this->redirect(Yii::app()->user->returnUrl);
		}
    $this->render('login', array('user_model' => $model));
        // display the login form
        //$this->widget('ext.widgets.istack.X2Login');
	}

	public function actionLogout(){
        Yii::app()->user->logout(true);
        # Goto home page.
		$this->redirect($this->createUrl('/'));
	}
}