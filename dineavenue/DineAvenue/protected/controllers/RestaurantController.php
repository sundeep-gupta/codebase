<?php
Yii::import('ext.yii-mail.YiiMailMessage');

class RestaurantController extends DAController {
  public $search_form = null;
  public function filters() {
      return array('accessControl');
  }

 public function accessRules() {
      return array(
          array('allow', 'actions' => array('showRestaurant', 'showRestaurantMenu', 'showRestaurantActivities'
                  , 'showCoupons','recent', 'advertise', 'addToCart', 'resetCart', 'checkout','SelectCity','ChangeCity')
              , 'users' => array('*')),
          array('allow', 'actions' => array('search', 'index', 'displayImage')),
          array('deny', 'users' => array('*'))
      );
  }


  /**
	 * Declares class-based actions.
	 */
	public function actions()
	{
		return array(
			// captcha action renders the CAPTCHA image displayed on the contact page
			'captcha'=>array(
				'class'=>'CCaptchaAction',
				'backColor'=>0xFFFFFF,
			),
			// page action renders "static" pages stored under 'protected/views/site/pages'
			// They can be accessed via: index.php?r=site/page&view=FileName
			'page'=>array(
				'class'=>'CViewAction',
			),
		);
	}

	/**
	 * This is the default 'index' action that is invoked
	 * when an action is not explicitly requested by users.
	 */
	public function actionIndex() {
    /*
    $message = new YiiMailMessage;
    $message->setBody('My text');
    $message->setTo(array('harshasanghi@gmail.com' => 'DineAvenue'));
    $message->from = Yii::app()->params['adminEmail'];
    Yii::app()->mail->send($message);
     *
     */

    $recentPostsUrl = $this->createUrl($this->getActionUrl('recentPosts'));
    $recentRestaurants = $this->createUrl($this->getActionUrl('recentRestaurants'));
    $recentComments = $this->createUrl($this->getActionUrl('recentComments'));
    $recommendation = $this->createUrl($this->getActionUrl('recommendation'));
    $popular = $this->createUrl($this->getActionUrl('popular'));
    $advertise = $this->createUrl($this->getActionUrl('advertise'));

//    Yii::app()->clientScript->registerScriptFile(Yii::app()->theme->baseUrl.'/js/dineavenue.js');
    Yii::app()->clientScript->registerScript('testscript',"loadRecentPosts('" . $recentPostsUrl."');"
            , CClientScript::POS_READY);
    Yii::app()->clientScript->registerScript('loadRestaurants','loadRecentRestaurants(\''.$recentRestaurants.'\');'
            ,  CClientScript::POS_READY);
    Yii::app()->clientScript->registerScript('loadComments','loadRecentComments(\''.$recentComments.'\');'
            ,  CClientScript::POS_READY);
    Yii::app()->clientScript->registerScript('recommendation','loadRecommendation(\''.$recommendation.'\');'
            ,  CClientScript::POS_READY);
    Yii::app()->clientScript->registerScript('popular','loadPopularPosts(\''.$popular.'\');'
            ,  CClientScript::POS_READY);
    Yii::app()->clientScript->registerScript('advertise','loadAdvertise(\''.$advertise.'\');'
            ,  CClientScript::POS_READY);

		// renders the view file 'protected/views/site/index.php'
		// using the default layout 'protected/views/layouts/main.php'
    $dp_searchByType = $this->getDPForSearchByType();
    $dataProvider = new CActiveDataProvider('FoodItem');
    $this->search_form = new SearchForm();
    $this->render('index', array('dataProvider' => $dataProvider,
        'dp_searchByType' => $dp_searchByType,
        'location_model' => new Locations(),
        'restaurant' => new Restaurant(),
        'm_cusine' => new Cusine()));

    }

	/**
	 * This is the action to handle external exceptions.
	 */
	public function actionError()
	{
	    if($error=Yii::app()->errorHandler->error)
	    {
	    	if(Yii::app()->request->isAjaxRequest)
	    		echo $error['message'];
	    	else
	        	$this->render('error', $error);
	    }
	}

	/**
	 * Displays the contact page
	 */
	public function actionContact()
	{
		$model=new ContactForm;
		if(isset($_POST['ContactForm']))
		{
			$model->attributes=$_POST['ContactForm'];
			if($model->validate())
			{
				$headers="From: {$model->email}\r\nReply-To: {$model->email}";
				mail(Yii::app()->params['adminEmail'],$model->subject,$model->body,$headers);
				Yii::app()->user->setFlash('contact','Thank you for contacting us. We will respond to you as soon as possible.');
				$this->refresh();
			}
		}
		$this->render('contact',array('model'=>$model));
	}

	/**
	 * Displays the login page
	 */
	public function actionLogin()
	{
		$model=new LoginForm;

		// if it is ajax validation request
		if(isset($_POST['ajax']) && $_POST['ajax']==='login-form')
		{
			echo CActiveForm::validate($model);
			Yii::app()->end();
		}

		// collect user input data
		if(isset($_POST['LoginForm']))
		{
			$model->attributes=$_POST['LoginForm'];
			// validate user input and redirect to the previous page if valid
			if($model->validate() && $model->login())
				$this->redirect(Yii::app()->user->returnUrl);
		}
		// display the login form
		$this->render('login',array('model'=>$model));
	}

	/**
	 * Logs out the current user and redirect to homepage.
	 */
	public function actionLogout() {
		Yii::app()->user->logout();
		$this->redirect(Yii::app()->homeUrl);
	}

  public function actionShowArticle() {
    echo "Not Yet Implemented!";
  }

  public function actionAddComment() {
    echo "Not yet Implemented!";
  }

  public function actionShowComments() {
    echo "Not Yet Implemented";
  }

  public function actionSetArticleRating() {
    echo "Not Yet Implemented";
  }

  public function actionGetArticleRating() {
    echo "Not Yet Implemented";
  }

  public function actionShowCoupons($id) {
    if (!Yii::app()->request->getIsAjaxRequest()) {
      echo "This action is supported on Ajax requests only";
      return;
    }
    $this->renderPartial('showCoupons', array('restaurant' =>Restaurant::model()->findByPk($id)));

  }

  public function actionGenerateCoupon($id) {
    echo "Not Yet Implemented!";
  }

  public function actionRedeemCoupon($id) {
    echo "Not Yet Implemented!";
  }

  public function actionValidateCoupon($id) {
    echo "Validation code unavailable....";
  }

  public function displayImage($model, $id) {
    echo "Yet to Implement!!!";
  }

  public function actionShowRestaurant($id) {
    /* if there is no ID defined, we need to redirect to home page */
    if (!isset($id) || empty($id)) {
      $this->redirect($this->createUrl('restaurant'));
    }
    $ra_restaurant = Restaurant::model()->findBySmartName($id);

    /* if id does nt match the restaurant group's smart name, then try to get from the restaurant's id */
    if (count($ra_restaurant) == 0) {
      $ar_restaurant = Restaurant::model()->find('id = ?', array($_GET['id']));
      if ($ar_restaurant) {
        array_push($ra_restaurant, $ar_restaurant);
      }
    }

    /* iF multiple rows, listing of restaurants, otherwise directly go to the home page of restaurant */
    if(count($ra_restaurant) > 1) {
      $dataProvider = new CArrayDataProvider($this->getRestaurantDetails($ra_restaurant), array('id'=>'id'));
      $this->getController()->render('search', array('dataProvider'=> $dataProvider));
    } elseif(count($ra_restaurant) == 1) {
      $this->registerScripts($ra_restaurant[0]);
      Yii::app()->clientScript->registerScriptFile(Yii::app()->theme->baseUrl . '/js/simpleCart.js'
          , CClientScript::POS_HEAD);
      #Yii::app()->clientScript->registerCssFile(Yii::app()->theme->baseUrl . '/css/simpleCart/scart.css');
      Yii::app()->clientScript->registerCssFile(Yii::app()->theme->baseUrl . '/css/simpleCart/scartstyle.css');
      $this->render('showRestaurant', array('restaurant'=> $ra_restaurant[0]));
    } else {
      $this->redirect(Yii::app()->request->baseUrl);
    }
  }

  public function actionShowRestaurantMenu($id) {
    if (!Yii::app()->request->getIsAjaxRequest()) {
      echo "This action is supported on Ajax requests only";
      return;
    }
    $this->renderPartial('showMenu', array('restaurant' =>Restaurant::model()->findByPk($id)
            ,'isGuest' => Yii::app()->user->name == 'Guest'));
  }
  public function actionShowRestaurantAlbum($id) {
    if (!Yii::app()->request->getIsAjaxRequest()) {
      echo "This action is supported on Ajax requests only";
      return;
    }
    $this->renderPartial('restaurantAlbum', array('restaurant' =>Restaurant::model()->findByPk($id)));
  }

  public function actionShowRestaurantActivities($id) {
    if (!Yii::app()->request->getIsAjaxRequest()) {
      echo "This action is supported on Ajax requests only";
      return;
    }
    $this->renderPartial('showActivities', array('restaurant' =>Restaurant::model()->findByPk($id)));
  }

  public function actionShowRestaurantMap($id) {
    if (!Yii::app()->request->getIsAjaxRequest()) {
      echo "This action is supported on Ajax requests only";
      return;
    }
    $this->renderPartial('restaurantMap', array('restaurant' =>Restaurant::model()->findByPk($id)));
  }

  public function actionOrder() {
    echo "Ordering is not implemented yet!!!";
  }

  public function actionSearch($map = NULL, $zipsearch = NULL, $locations = NULL, $cuisine = NULL) {
    $data = NULL;
    if (!isset($zipsearch) && isset($_POST['zipsearch'])) {
      $zipsearch = $_POST['zipsearch'];
    }

    if (!isset($locations) && isset($_POST['Locations'])) {
      $locations = $_POST['Locations'];
    }
    if (!isset($cuisine) && isset($_POST['Cusine'])) {
      $cuisine = $_POST['Cusine'];
    }

    if (isset($map)) {
      $markers = $this->getMarkersForRestaurant($_GET['map']);
      $this->renderPartial('mapsearch', array('markers' => $markers));
      return;
    }
    if (!empty($zipsearch)) {
      $ra = RestaurantAddress::model()->findByZipOrItemServed($zipsearch);
      $data = $this->getRestaurantDetails($ra);
    }

    $ra_locations = array(); $ra_cuisines = array();
    if(!empty($locations) && !empty($locations['name'])) {
      $ra_locations = $locations['name'];

    }
    if(isset($cuisine) && isset($cuisine['name'])) {
      $ra_cuisines = $cuisine['name'];
    }
    if ($data == NULL || count($data) == 0) {

      if (count($ra_locations) == 0 && count($ra_cuisines) == 0) {
        $this->redirect($this->createUrl('/'));
      } else {
        $data = $this->getRestaurantDetails(
                RestaurantAddress::model()->findByLocationOrCuisineServed($ra_locations, $ra_cuisines));
      }
    }
    $ra_search_locations = Locations::model()->findAllByAttributes(array('id' => $ra_locations));
    $ra_search_item = Cusine::model()->findAllByAttributes(array('id' => $ra_cuisines));
    $dataProvider = new CArrayDataProvider($data, array('id' => 'id',));
    $this->render('search', array('dataProvider' => $dataProvider, 'ra_search_item' => $ra_search_item
            , 'ra_search_locations' => $ra_search_locations));
  }

  public function actionRecent() {
    $this->renderPartial('recent', array(
        'restaurant' => new Restaurant()));
  }

  public function actionAdvertise() {
    $this->renderPartial('advertise');
  }

  public function actionAddToCart() {

    /* Store the variables from $_POST locally
     * TODO : Validate the values... maybe some filters / validators ?
     *          Do we need to capture restaurant details as well ?
     *    coz ordering from multiple vendors in single order is not possible :(
     */
    //print_r($_POST['quantity']);
  //  return;
    $quantity = 0;
    if (isset($_POST['quantity'])) {
      $quantity = $_POST['quantity'];
    }
    $price = 0;
    if (isset($_POST['price'])) {
      $price = $_POST['price'];
    }
    $id = null;
    if (isset($_POST['id'])) {
      $id = $_POST['id'];
    }
    /*
    if ($id == null) {
      echo "No ID set some problem with POST";
      return;
    } */
    /* Get the cart from the session Information */
    if (!Yii::app()->session->getIsStarted()) {
      # TODO : close the session...
      Yii::app()->session->open();
    }
    if (Yii::app()->session->get('cart') == null) {
      Yii::app()->session->add('cart',new ShoppingCart());
    }
    $cart = Yii::app()->session->get('cart');

    /* Check if the cartItem is already in cart, if not
     * create one, add it to cart. Do it only if $id is not null
     */
    if ($id != null) {
      $cartItem = $cart->getCartItem($id);
      if ($cartItem == null) {
        $cartItem = new CartItem($id, $quantity, $price);
        $cart->addCartItem($cartItem);
      } else {
        $cartItem->alterQuantity($quantity);
      }
    }
    /* Now return the cart in JSON format */
    echo CJSON::encode($cart->toArray());

  }

  public function actionResetCart() {
    /* Get the cart from the session Information */
    if (!Yii::app()->session->getIsStarted()) {
      # TODO : close the session...
      Yii::app()->session->open();
    }
    $cart = Yii::app()->session->get('cart');
    if ($cart != null) {
      Yii::app()->session->remove('cart');
    }
    echo 'OK';
    return ;
  }

  public function actionCheckout() {
    $cart = Yii::app()->session->get('cart');
    $this->renderPartial('checkout', array('cart' => $cart));
  }
  private function getDPForSearchByType() {
    $model = new FoodItem();
    $ar_fi_names = $model->findAll();
    $a_searchbytype = array();
    foreach ($ar_fi_names as $ar_fi_name) {
      array_push($a_searchbytype, $ar_fi_name->getAttribute('name'));
    }
    $model = new Locations();
    # TODO : City specific search... Cookies here
    $ar_loc_zip = $model->findAll('city_id = ?', array('1'));
    foreach ($ar_loc_zip as $ar_loc) {
      array_push($a_searchbytype, $ar_loc->getAttribute('zip'));
      foreach ($ar_loc->restaurantAddresses as $restaurantAddress) {
        array_push($a_searchbytype, $restaurantAddress->restaurant->name);
      }
    }
    return $a_searchbytype;
  }

  private function getRestaurantDetails($ra_address){
    $data = array();
    foreach ($ra_address as $address) {
      $row = array();
      $row['id'] = $address->restaurant_id;
      $row['restaurant_name'] = $address->restaurant->name;
      $row['line1'] = $address->line1;
      $row['line2'] = $address->line2;
      $row['location'] = $address->location->name;
      $row['landmark'] = $address->landmark;
      $row['city'] = $address->location->city->name;
      $row['zipcode'] = $address->zipcode;
      $ra_contacts = RestaurantContacts::model()->findAllByAttributes(
              array('restaurant_id' => $address->restaurant_id, 'contact_type' => RestaurantContacts::PHONE));
      if (count($ra_contacts) > 0) {
        $row['phone'] = $ra_contacts[0]->contact_details;
      }
      $ra_props = RestaurantProperties::model()->findDisplayPropertiesByRestaurant($address->restaurant_id);
      $row['facilities'] = RestaurantProperties::getFacilities($ra_props);
      array_push($data,$row);
    }
    return $data;
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

  protected function registerScripts($restaurant) {
      /* All those things that gets loaded using ajax */
      $restaurantMenuUrl = $this->createUrl($this->getActionUrl('showRestaurantMenu')
              , array('id' => $restaurant->id));
      Yii::app()->clientScript->registerScript('showMenu',"loadRestaurantMenu('" . $restaurantMenuUrl."');"
            , CClientScript::POS_READY);

      $restaurantMenuUrl = $this->createUrl($this->getActionUrl('showRestaurantActivities')
              , array('id' => $restaurant->id));
      Yii::app()->clientScript->registerScript('showActivities',"loadRestaurantActivities('" . $restaurantMenuUrl."');"
            , CClientScript::POS_READY);

      $restaurantCouponUrl = $this->createUrl($this->getActionUrl('showCoupons')
              , array('id' => $restaurant->id));
      Yii::app()->clientScript->registerScript('showCoupons',"loadRestaurantCoupon('" . $restaurantCouponUrl."');"
            , CClientScript::POS_READY);

      $restaurantAlbumUrl = $this->createUrl($this->getActionUrl('restaurantAlbum')
              , array('id' => $restaurant->id));
      Yii::app()->clientScript->registerScript('restaurantAlbum',"loadRestaurantAlbum('" . $restaurantCouponUrl."');"
            , CClientScript::POS_READY);

      /* Maps in ajax is failing.. need to find out why ?
      $restaurantMapUrl = $this->createUrl($this->getActionUrl('restaurantMap')
              , array('id' => $restaurant->id));
      Yii::app()->clientScript->registerScript('showMap',"loadRestaurantMap('" . $restaurantMapUrl."');"
            , CClientScript::POS_READY);

      */

  $feedback_javascript = "$(document).ready(function() {
    $(\".mainCompose\").hide();
    $('.loader').hide();
    $('#errortxt').hide();

    $('.button-2').click(function() {
    	$('.mainCompose').slideToggle();
    });

    $('.sendbtn').click(function(e) {
    	e.preventDefault();
    	$('.sendbtn').hide();
    	$('.loader').show();

    	if($('#mymsg').val() == \"\") {
			$('#errortxt').show();
			$('.sendbtn').show();
			$('.loader').hide();
    	}
    	else {
    		$('sendbtn').hide();
    		$('.loader').show();
    		$('#errortxt').hide();

    		var formQueryString = $('#sendprivatemsg').serialize(); // form data for ajax input
    		finalSend();
    	}

    	// possibly include Ajax calls here to external PHP
    	function finalSend() {
    		$('.mainCompose').delay(1000).slideToggle('slow', function() {
    			$('#composeicon').addClass('sent').removeClass('button-2').hide();

    			// hide original link and display confirmation icon
    			$('#composebtn').append('<img src=\"img/check-sent.png\" />');
    		});
    	}
    });
});";
//==============================header=================================-->
  $javascript = "$(document).ready(function() {
    $(\".mainCompose\").hide();
    $('.loader').hide();
    $('#errortxt').hide();

    $('.button-2').click(function() {
    	$('.mainCompose').slideToggle();
    });

    $('.sendbtn').click(function(e) {
    	e.preventDefault();
    	$('.sendbtn').hide();
    	$('.loader').show();

    	if($('#mymsg').val() == \"\") {
			$('#errortxt').show();
			$('.sendbtn').show();
			$('.loader').hide();
    	}
    	else {
    		$('sendbtn').hide();
    		$('.loader').show();
    		$('#errortxt').hide();

    		var formQueryString = $('#sendprivatemsg').serialize(); // form data for ajax input
    		finalSend();
    	}

    	// possibly include Ajax calls here to external PHP
    	function finalSend() {
    		$('.mainCompose').delay(1000).slideToggle('slow', function() {
    			$('#composeicon').addClass('sent').removeClass('button-2').hide();

    			// hide original link and display confirmation icon
    			$('#composebtn').append('<img src=\"img/check-sent.png\" />');
    		});
    	}
    });
});";

      Yii::app()->clientScript->registerCssFile(Yii::app()->theme->baseUrl.'/css/modal.css');

      //Yii::app()->clientScript->registerScript('about-script', $javascript, CClientScript::POS_HEAD);
      Yii::app()->clientScript->registerScript('about-script', 'about()', CClientScript::POS_READY);
      //Yii::app()->clientScript->registerScript('feedback-script', $feedback_javascript, CClientScript::POS_HEAD);
  }

  /**This function is used for selecting the City
   *and setting Cookie for selected city
   *
   *Author: Harpreet Singh
   */

  	public function actionSelectCity()
	{
		$model=new City;
		$this->performAjaxValidation($model);
		if(!isset(Yii::app()->request->cookies['selected_city']))
		{
			if(isset($_POST['City']))
			{
				$model->attributes=$_POST['City'];
				if($_POST['City']['id']!==NULL)
				{
					$id=$_POST['City']['id'];
					$value_1=$model->getNameById($id);
					if ($value_1) {
    					$value_name=$value_1->name;
    					Yii::app()->request->cookies['selected_city'] = new CHttpCookie('selected_city', $value_name);

					}
					$base_url=Yii::app()->request->baseUrl;
				}
						$this->redirect( $base_url);
			}
			else
			{
				$this->render('index',array('model'=>$model));

			}
		}
		else
		{
		$base_url=Yii::app()->request->baseUrl;
		$this->redirect($base_url);
		}
	}


  /**This function is used for updating the City
   *when user clicks on the "change city" link
   *and updates the cookie value with new city selected
   *
   *Author: Harpreet Singh
   *
   */

	public function actionChangeCity()
	{
		$model=new City;
		$this->performAjaxValidation($model);
		if(isset($_POST['City']))
			{
				$model->attributes=$_POST['City'];
				if($_POST['City']['id']!==NULL)
				{
					$id=$_POST['City']['id'];
					$value_1 = $model->getNameById($id);
					if ($value_1) {
    					$value_name = $value_1->name;
    					$cookie = Yii::app()->request->getCookies();
    					unset($cookie['Selected_City']);
    					Yii::app()->request->cookies['selected_city'] = new CHttpCookie('selected_city', $value_name);

					}
					$base_url=Yii::app()->request->baseUrl;
				}
				$this->redirect( $base_url);
			}
			else
			{
				$base_url=Yii::app()->request->baseUrl;
				$this->redirect($base_url);
			}
	}
}