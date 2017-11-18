<?php

class AdminController extends DAController {
	/**
	 * @var string the default layout for the views. Defaults to '//layouts/column2', meaning
	 * using two-column layout. See 'protected/views/layouts/column2.php'.
	 */
	public $layout='//layouts/column2';
  
  public $defaultAction = "adminCoupons";

	/**
	 * @return array action filters
   */
	public function filters()
	{
		return array(
			'accessControl', // perform access control for CRUD operations
		);
	}


	/**
	 * Specifies the access control rules.
	 * This method is used by the 'accessControl' filter.
	 * @return array access control rules
	 */
	public function accessRules()
	{
		return array(
			array('allow',  // allow all users to perform 'index' and 'view' actions
				'actions'=>array(
            'addArticle', 'addCoupon', 'addCouponRule', 'addCity',  'addFoodItem', 'addImage', 'addLocation'
            
            , 'adminArticles', 'adminCities', 'adminCouponRules','adminCoupons', 'adminFoodItems', 'adminImages'
            , 'adminLocations', 'approveArticle', 'approveComment'
            
            , 'deleteArticle', 'deleteCity', 'deleteCoupon', 'deleteCouponRule', 'deleteFoodItem', 'deleteImage'
            , 'deleteLocation'
            
            , 'editArticle', 'editCity', 'editCoupon', 'editCouponRole', 'editFoodItem', 'editImage', 'editLocation'
            
            , 'listArticles', 'listCities', 'listCoupons', 'listUnapproveArticles', 'listCouponRoles', 'listUnapprovedComments'
            
            , 'viewArticle', 'viewCity', 'viewCoupon', 'viewCouponRole', 'viewFoodItem', 'viewImage', 'viewLocation'
            , 'viewLocations'
            ),
				'users'=>array('admin'),
			),
        /*
			array('allow', // allow authenticated user to perform 'create' and 'update' actions
				'actions'=>array('create','update', 'viewArticle'),
				'users'=>array('@'),
			),
			array('allow', // allow admin user to perform 'admin' and 'delete' actions
				'actions'=>array('admin','delete'),
				'users'=>array('admin'),
			),*/
			array('deny',  // deny all users
				'users'=>array('*'),
			),
		);
	}

	/**
	 * Creates a new model.
	 * If creation is successful, the browser will be redirected to the 'view' page.
	 */
	public function actionAddArticle()
	{
		$model=new Article;

		// Uncomment the following line if AJAX validation is needed
		// $this->performAjaxValidation($model);

		if(isset($_POST['Article']))
		{
			$model->attributes=$_POST['Article'];
			if($model->save())
				$this->redirect(array('viewArticle','id'=>$model->id));
		}

		$this->render('addArticle',array(
			'model'=>$model,
		));
	}

	/**
	 * Updates a particular model.
	 * If update is successful, the browser will be redirected to the 'view' page.
	 * @param integer $id the ID of the model to be updated
	 */
	public function actionEditArticle($id)
	{
		$model=$this->loadArticleModel($id);

		// Uncomment the following line if AJAX validation is needed
		// $this->performAjaxValidation($model);

		if(isset($_POST['Article']))
		{
			$model->attributes=$_POST['Article'];
			if($model->save())
				$this->redirect(array('viewArticle','id'=>$model->id));
		}

		$this->render('editArticle',array(
			'model'=>$model,
		));
	}

	/**
	 * Deletes a particular model.
	 * If deletion is successful, the browser will be redirected to the 'admin' page.
	 * @param integer $id the ID of the model to be deleted
	 */
	public function actionDeleteArticle($id)
	{
		if(Yii::app()->request->isPostRequest)
		{
			// we only allow deletion via POST request
			$this->loadArticleModel($id)->delete();

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
	public function actionListArticles()
	{
		$dataProvider=new CActiveDataProvider('Article');
		$this->render('listArticles',array(
			'dataProvider'=>$dataProvider,
		));
	}

  public function actionViewArticle($id) {
    
		$this->render('viewArticle',array(
			'model'=>$this->loadArticleModel($id),
		));
  }

	/**
	 * Manages all models.
	 */
	public function actionAdminArticles() {
		$model=new Article('search');
		$model->unsetAttributes();  // clear any default values
		if(isset($_GET['Article']))
			$model->attributes=$_GET['Article'];

		$this->render('adminArticles',array(
			'model'=>$model,
		));
	}
  

  public function actionListUnapprovedArticles() {
    echo "Action not yet implemented!";
    return;
  }
  
  public function actionApproveArticle($id) {
    echo "Action not yet implemented !";
  }
  
  public function actionApproveComment($id) {
    echo "Not yet implemented!";
  }
  
  public function actionListUnapprovedComments()  {
    echo "Yet to implement!";
  }

	/**
	 * Creates a new model.
	 * If creation is successful, the browser will be redirected to the 'view' page.
	 */
	public function actionAddCity()
	{
		$model=new City;

		// Uncomment the following line if AJAX validation is needed
		// $this->performAjaxValidation($model);

		if(isset($_POST['City']))
		{
			$model->attributes=$_POST['City'];
			if($model->save())
				$this->redirect(array('listCities'));
		}

		$this->render('addCity',array(
			'model'=>$model,
		));
	}

	/**
	 * Updates a particular model.
	 * If update is successful, the browser will be redirected to the 'view' page.
	 * @param integer $id the ID of the model to be updated
	 */
	public function actionEditCity($id)
	{
		$model=$this->loadCityModel($id);

		// Uncomment the following line if AJAX validation is needed
		// $this->performAjaxValidation($model);

		if(isset($_POST['City']))
		{
			$model->attributes=$_POST['City'];
			if($model->save())
				$this->redirect(array('listCities'));
		}

		$this->render('editCity',array(
			'model'=>$model,
		));
	}

	/**
	 * Deletes a particular model.
	 * If deletion is successful, the browser will be redirected to the 'admin' page.
	 * @param integer $id the ID of the model to be deleted
	 */
	public function actionDeleteCity($id)
	{
		if(Yii::app()->request->isPostRequest)
		{
			// we only allow deletion via POST request
			$this->loadCityModel($id)->delete();

			// if AJAX request (triggered by deletion via admin grid view), we should not redirect the browser
			if(!isset($_GET['ajax']))
				$this->redirect(isset($_POST['returnUrl']) ? $_POST['returnUrl'] : array('adminCities'));
		}
		else
			throw new CHttpException(400,'Invalid request. Please do not repeat this request again.');
	}

	/**
	 * Lists all models.
	 */
	public function actionListCities()
	{
		$dataProvider=new CActiveDataProvider('City');
		$this->render('listCities',array(
			'dataProvider'=>$dataProvider,
		));
	}

	/**
	 * Manages all models.
	 */
	public function actionAdminCities()
	{
		$model=new City('search');
		$model->unsetAttributes();  // clear any default values
		if(isset($_GET['City']))
			$model->attributes=$_GET['City'];

		$this->render('adminCities',array(
			'model'=>$model,
		));
	}
	/**
	 * Displays a particular model.
	 * @param integer $id the ID of the model to be displayed
	 */
	public function actionViewCity($id)
	{
		$this->render('viewCity',array(
			'model'=>$this->loadCityModel($id),
		));
	}

	/**
	 * Displays a particular model.
	 * @param integer $id the ID of the model to be displayed
	 */
	public function actionViewCoupon($id)
	{
		$this->render('viewCoupon',array(
			'model'=>$this->loadCouponModel($id),
		));
	}

	/**
	 * Creates a new model.
	 * If creation is successful, the browser will be redirected to the 'view' page.
	 */
	public function actionAddCoupon()
	{
		$model=new Coupon;

		// Uncomment the following line if AJAX validation is needed
		// $this->performAjaxValidation($model);

		if(isset($_POST['Coupon']))
		{
			$model->attributes=$_POST['Coupon'];
			if($model->save())
				$this->redirect(array('viewCoupon','id'=>$model->id));
		}

		$this->render('addCoupon',array(
			'model'=>$model,
		));
	}

	/**
	 * Updates a particular model.
	 * If update is successful, the browser will be redirected to the 'view' page.
	 * @param integer $id the ID of the model to be updated
	 */
	public function actionEditCoupon($id)
	{
		$model=$this->loadCouponModel($id);

		// Uncomment the following line if AJAX validation is needed
		// $this->performAjaxValidation($model);

		if(isset($_POST['Coupon']))
		{
			$model->attributes=$_POST['Coupon'];
			if($model->save())
				$this->redirect(array('viewCoupon','id'=>$model->id));
		}

		$this->render('editCoupon',array(
			'model'=>$model,
		));
	}

	/**
	 * Deletes a particular model.
	 * If deletion is successful, the browser will be redirected to the 'admin' page.
	 * @param integer $id the ID of the model to be deleted
	 */
	public function actionDeleteCoupon($id)
	{
		if(Yii::app()->request->isPostRequest)
		{
			// we only allow deletion via POST request
			$this->loadCouponModel($id)->delete();

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
	public function actionListCoupons()
	{
		$dataProvider=new CActiveDataProvider('Coupon');
		$this->render('listCoupons',array(
			'dataProvider'=>$dataProvider,
		));
	}

	/**
	 * Manages all models.
	 */
	public function actionAdminCoupons()
	{
		$model=new Coupon('search');
		$model->unsetAttributes();  // clear any default values
		if(isset($_GET['Coupon']))
			$model->attributes=$_GET['Coupon'];

		$this->render('adminCoupons',array(
			'model'=>$model,
		));
	}

  
	/**
	 * Displays a particular model.
	 * @param integer $id the ID of the model to be displayed
	 */
	public function actionViewCouponRule($id)
	{
		$this->render('viewCouponRule',array(
			'model'=>$this->loadCouponRuleModel($id),
		));
	}

	/**
	 * Creates a new model.
	 * If creation is successful, the browser will be redirected to the 'view' page.
	 */
	public function actionAddCouponRule()
	{
		$model=new CouponRules;

		// Uncomment the following line if AJAX validation is needed
		// $this->performAjaxValidation($model);

		if(isset($_POST['CouponRules']))
		{
			$model->attributes=$_POST['CouponRules'];
			if($model->save())
				$this->redirect(array('viewCouponRule','id'=>$model->id));
		}

		$this->render('addCouponRule',array(
			'model'=>$model,
		));
	}

	/**
	 * Updates a particular model.
	 * If update is successful, the browser will be redirected to the 'view' page.
	 * @param integer $id the ID of the model to be updated
	 */
	public function actionEditCouponRule($id)
	{
		$model=$this->loadRuleModel($id);

		// Uncomment the following line if AJAX validation is needed
		// $this->performAjaxValidation($model);

		if(isset($_POST['CouponRules']))
		{
			$model->attributes=$_POST['CouponRules'];
			if($model->save())
				$this->redirect(array('viewCouponRule','id'=>$model->id));
		}

		$this->render('editCouponRule',array(
			'model'=>$model,
		));
	}

	/**
	 * Deletes a particular model.
	 * If deletion is successful, the browser will be redirected to the 'admin' page.
	 * @param integer $id the ID of the model to be deleted
	 */
	public function actionDeleteCouponRule($id)
	{
		if(Yii::app()->request->isPostRequest)
		{
			// we only allow deletion via POST request
			$this->loadRuleModel($id)->delete();

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
	public function actionListCouponRules()
	{
		$dataProvider=new CActiveDataProvider('CouponRules');
		$this->render('listCouponRules',array(
			'dataProvider'=>$dataProvider,
		));
	}

	/**
	 * Manages all models.
	 */
	public function actionAdminCouponRules()
	{
		$model=new CouponRules('search');
		$model->unsetAttributes();  // clear any default values
		if(isset($_GET['CouponRules']))
			$model->attributes=$_GET['CouponRules'];

		$this->render('adminCouponRules',array(
			'model'=>$model,
		));
	}


	/**
	 * Displays a particular model.
	 * @param integer $id the ID of the model to be displayed
	 */
	public function actionViewFoodItem($id)
	{
		$this->render('viewFoodItem',array(
			'model'=>$this->loadFoodItemModel($id),
		));
	}

	/**
	 * Creates a new model.
	 * If creation is successful, the browser will be redirected to the 'view' page.
	 */
	public function actionAddFoodItem()
	{
		$model=new FoodItem;

		// Uncomment the following line if AJAX validation is needed
		// $this->performAjaxValidation($model);

		if(isset($_POST['FoodItem']))
		{
			$model->attributes=$_POST['FoodItem'];
			if($model->save())
				$this->redirect(array('viewFoodItem','id'=>$model->id));
		}

		$this->render('addFoodItem',array(
			'model'=>$model,
		));
	}

	/**
	 * Updates a particular model.
	 * If update is successful, the browser will be redirected to the 'view' page.
	 * @param integer $id the ID of the model to be updated
	 */
	public function actionEditFoodItem($id)
	{
		$model=$this->loadFoodItemModel($id);

		// Uncomment the following line if AJAX validation is needed
		// $this->performAjaxValidation($model);

		if(isset($_POST['FoodItem']))
		{
			$model->attributes=$_POST['FoodItem'];
			if($model->save())
				$this->redirect(array('viewFoodItem','id'=>$model->id));
		}

		$this->render('editFoodItem',array(
			'model'=>$model,
		));
	}

	/**
	 * Deletes a particular model.
	 * If deletion is successful, the browser will be redirected to the 'admin' page.
	 * @param integer $id the ID of the model to be deleted
	 */
	public function actionDeleteFoodItem($id)
	{
		if(Yii::app()->request->isPostRequest)
		{
			// we only allow deletion via POST request
			$this->loadFoodItemModel($id)->delete();

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
	public function actionViewFoodItems()
	{
		$dataProvider=new CActiveDataProvider('FoodItem');
		$this->render('viewFoodItems',array(
			'dataProvider'=>$dataProvider,
		));
	}

	/**
	 * Manages all models.
	 */
	public function actionAdminFoodItems()
	{
		$model=new FoodItem('search');
		$model->unsetAttributes();  // clear any default values
		if(isset($_GET['FoodItem']))
			$model->attributes=$_GET['FoodItem'];

		$this->render('adminFoodItems',array(
			'model'=>$model,
		));
	}

	/**
	 * Displays a particular model.
	 * @param integer $id the ID of the model to be displayed
	 */
	public function actionViewImage($id)
	{
		$this->render('viewImage',array(
			'model'=>$this->loadImageModel($id),
		));
	}

	/**
	 * Creates a new model.
	 * If creation is successful, the browser will be redirected to the 'view' page.
	 */
	public function actionAddImage()
	{
		$model=new Image;

		// Uncomment the following line if AJAX validation is needed
		// $this->performAjaxValidation($model);

		if(isset($_POST['Image']))
		{
			$model->attributes=$_POST['Image'];
			if($model->save())
				$this->redirect(array('viewImage','id'=>$model->id));
		}

		$this->render('addImage',array(
			'model'=>$model,
		));
	}

	/**
	 * Updates a particular model.
	 * If update is successful, the browser will be redirected to the 'view' page.
	 * @param integer $id the ID of the model to be updated
	 */
	public function actionEditImage($id)
	{
		$model=$this->loadImageModel($id);

		// Uncomment the following line if AJAX validation is needed
		// $this->performAjaxValidation($model);

		if(isset($_POST['Image']))
		{
			$model->attributes=$_POST['Image'];
			if($model->save())
				$this->redirect(array('view','id'=>$model->id));
		}

		$this->render('editImage',array(
			'model'=>$model,
		));
	}

	/**
	 * Deletes a particular model.
	 * If deletion is successful, the browser will be redirected to the 'admin' page.
	 * @param integer $id the ID of the model to be deleted
	 */
	public function actionDeleteImage($id)
	{
		if(Yii::app()->request->isPostRequest)
		{
			// we only allow deletion via POST request
			$this->loadImageModel($id)->delete();

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
	public function actionViewImages()
	{
		$dataProvider=new CActiveDataProvider('Image');
		$this->render('viewImages',array(
			'dataProvider'=>$dataProvider,
		));
	}
	/**
	 * Manages all models.
	 */
	public function actionAdminImages()
	{
		$model=new Image('search');
		$model->unsetAttributes();  // clear any default values
		if(isset($_GET['Image']))
			$model->attributes=$_GET['Image'];

		$this->render('adminImages',array(
			'model'=>$model,
		));
	}

	/**
	 * Displays a particular model.
	 * @param integer $id the ID of the model to be displayed
	 */
	public function actionViewLocation($id)
	{
		$this->render('viewLocation',array(
			'model'=>$this->loadLocationModel($id),
		));
	}

	/**
	 * Creates a new model.
	 * If creation is successful, the browser will be redirected to the 'view' page.
	 */
	public function actionAddLocation()
	{
		$model=new Locations;

		// Uncomment the following line if AJAX validation is needed
		// $this->performAjaxValidation($model);

		if(isset($_POST['Locations']))
		{
			$model->attributes=$_POST['Locations'];
			if($model->save())
				$this->redirect(array('viewLocation','id'=>$model->id));
		}

		$this->render('addLocation',array(
			'model'=>$model,
		));
	}

	/**
	 * Updates a particular model.
	 * If update is successful, the browser will be redirected to the 'view' page.
	 * @param integer $id the ID of the model to be updated
	 */
	public function actionEditLocation($id)
	{
		$model=$this->loadLocationModel($id);

		// Uncomment the following line if AJAX validation is needed
		// $this->performAjaxValidation($model);

		if(isset($_POST['Locations']))
		{
			$model->attributes=$_POST['Locations'];
			if($model->save())
				$this->redirect(array('view','id'=>$model->id));
		}

		$this->render('editLocation',array(
			'model'=>$model,
		));
	}

	/**
	 * Deletes a particular model.
	 * If deletion is successful, the browser will be redirected to the 'admin' page.
	 * @param integer $id the ID of the model to be deleted
	 */
	public function actionDeleteLocation($id)
	{
		if(Yii::app()->request->isPostRequest)
		{
			// we only allow deletion via POST request
			$this->loadLocationModel($id)->delete();

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
	public function actionViewLocations()
	{
		$dataProvider=new CActiveDataProvider('Locations');
		$this->render('viewLocation',array(
			'dataProvider'=>$dataProvider,
		));
	}

	/**
	 * Manages all models.
	 */
	public function actionAdminLocations()
	{
		$model=new Locations('search');
		$model->unsetAttributes();  // clear any default values
		if(isset($_GET['Locations']))
			$model->attributes=$_GET['Locations'];

		$this->render('adminLocations',array(
			'model'=>$model,
		));
	}
  
  
}
