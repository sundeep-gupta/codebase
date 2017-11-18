<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of DAController
 *
 * @author skgupta
 */
class DAController extends Controller {
  protected $actions = array('recentPosts' => 'article/recent',
      'recentComments' => 'article/recentComments',
      'recentRestaurants' => 'restaurant/recent',
      'recommendation' => 'article/recommended',
      'popular' => 'article/popular',
      'advertise' => 'restaurant/advertise',
      'viewArticle' => 'article/view',
      'mapSearchResult' => 'restaurant/search',
      'showRestaurantMenu' => 'restaurant/showRestaurantMenu'
      ,'showRestaurantActivities' => 'restaurant/showRestaurantActivities'
      , 'showCoupons' => 'restaurant/showCoupons'
      , 'restaurantMap' => 'restaurant/showRestaurantMap'
      , 'restaurantAlbum' => 'restaurant/showRestaurantAlbum'
      , 'login' => 'user/login'

      );

  public function getActionUrl($action) {
    return $this->actions[$action];
  }
  /**
	 * Returns the data model based on the primary key given in the GET variable.
	 * If the data model is not found, an HTTP exception will be raised.
	 * @param integer the ID of the model to be loaded
	 */
	public function loadArticleModel($id) {
		$model=Article::model()->findByPk($id);
		if($model===null)
			throw new CHttpException(404,'The requested page does not exist.');
		return $model;
	}

  	/**
	 * Returns the data model based on the primary key given in the GET variable.
	 * If the data model is not found, an HTTP exception will be raised.
	 * @param integer the ID of the model to be loaded
	 */
	public function loadCityModel($id) {
		$model=City::model()->findByPk($id);
		if($model===null)
			throw new CHttpException(404,'The requested page does not exist.');
		return $model;
	}

  /**
	 * Returns the data model based on the primary key given in the GET variable.
	 * If the data model is not found, an HTTP exception will be raised.
	 * @param integer the ID of the model to be loaded
	 */
	public function loadCouponModel($id)
	{
		$model=Coupon::model()->findByPk($id);
		if($model===null)
			throw new CHttpException(404,'The requested page does not exist.');
		return $model;
	}


	/**
	 * Returns the data model based on the primary key given in the GET variable.
	 * If the data model is not found, an HTTP exception will be raised.
	 * @param integer the ID of the model to be loaded
	 */
	public function loadCouponRuleModel($id)
	{
		$model=CouponRules::model()->findByPk($id);
		if($model===null)
			throw new CHttpException(404,'The requested page does not exist.');
		return $model;
	}

  	/**
	 * Returns the data model based on the primary key given in the GET variable.
	 * If the data model is not found, an HTTP exception will be raised.
	 * @param integer the ID of the model to be loaded
	 */
	public function loadFoodItemModel($id)
	{
		$model=FoodItem::model()->findByPk($id);
		if($model===null)
			throw new CHttpException(404,'The requested page does not exist.');
		return $model;
	}
	/**
	 * Returns the data model based on the primary key given in the GET variable.
	 * If the data model is not found, an HTTP exception will be raised.
	 * @param integer the ID of the model to be loaded
	 */
	public function loadImageModel($id)
	{
		$model=Image::model()->findByPk($id);
		if($model===null)
			throw new CHttpException(404,'The requested page does not exist.');
		return $model;
	}
	/**
	 * Returns the data model based on the primary key given in the GET variable.
	 * If the data model is not found, an HTTP exception will be raised.
	 * @param integer the ID of the model to be loaded
	 */
	public function loadLocationModel($id)
	{
		$model=Locations::model()->findByPk($id);
		if($model===null)
			throw new CHttpException(404,'The requested page does not exist.');
		return $model;
	}

  /**
	 * Performs the AJAX validation.
	 * @param CModel the model to be validated
	 */
	protected function performAjaxValidation($model) {

		if(!isset($_POST['ajax'])) {
      return;
    }
		if ($_POST['ajax']==='city-form'){
			echo CActiveForm::validate($model);
			Yii::app()->end();
		}
    elseif ($_POST['ajax']==='article-form') {
			echo CActiveForm::validate($model);
			Yii::app()->end();
		}
    elseif($_POST['ajax']==='coupon-form'){
			echo CActiveForm::validate($model);
			Yii::app()->end();
		}
    elseif($_POST['ajax']==='coupon-rules-form') {
			echo CActiveForm::validate($model);
			Yii::app()->end();
		}
    elseif($_POST['ajax']==='food-item-form')
		{
			echo CActiveForm::validate($model);
			Yii::app()->end();
		}
    elseif($_POST['ajax']==='image-form')
		{
			echo CActiveForm::validate($model);
			Yii::app()->end();
		}
    elseif($_POST['ajax']==='locations-form')
		{
			echo CActiveForm::validate($model);
			Yii::app()->end();
		}
	}

  public function getMarkersForRestaurant($location) {
    Yii::import('ext.jquery-gmap.*');
    // add a Javascript event on marker click
    $js = "function(marker, event, data){
            var map = $(this).gmap3('get'),
            infowindow = $(this).gmap3({action:'get', name:'infowindow'});
            if (infowindow){
                infowindow.open(map, marker);
                infowindow.setContent(data);
            } else {
                $(this).gmap3({action:'addinfowindow', anchor:marker, options:{content: data}});
            }
    }";

    $ra_markers = array();
    $ra_address = RestaurantAddress::model()->with('location')->findAll('location.name = ?', array($location));
    $img_restaurant = Yii::app()->request->baseUrl.'/images/rest2.png';
    foreach ($ra_address as $address) {
      $params = array('title' => $address->restaurant->name,
          'icon' => array ('url' => $img_restaurant,
              'anchor' => array ('x' => 1, 'y' => 36),
              ),
          );
      $marker = new EGMap3Marker($params);
      $marker->address = $address->latitude .', ' . $address->longitude;
      $marker->data = $address->restaurant->name;
      $marker->addEvent('click', $js);
      $marker->centerOnMap();
      array_push($ra_markers, $marker);
    }
    return $ra_markers;
  }


}

?>
