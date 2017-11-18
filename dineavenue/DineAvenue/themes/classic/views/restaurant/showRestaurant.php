<?php
  $decrement_png = Yii::app()->theme->baseUrl + '/images/simpleCart/decrement.png';
  $increment_png = Yii::app()->theme->baseUrl + '/images/simpleCart/increment.png';
  $shoppingCartJs = "simpleCart({
		//Setting the Cart Columns for the sidebar cart display.
		cartColumns: [
			//A custom cart column for putting the quantity and increment and decrement items in one div for easier styling.
			{ view: function(item, column){
				return	\"<span>\"+item.get('quantity')+\"</span>\" +
						\"<div>\" +
							\"<a href='javascript:;' class='simpleCart_increment'><img src='" + $increment_png + "' title='+1' alt='arrow up'/></a>\" +
							\"<a href='javascript:;' class='simpleCart_decrement'><img src='" + $decrement_png + "' title='-1' alt='arrow down'/></a>\" +
						\"</div>\";
			}, attr: 'custom' },
			//Name of the item
			{ attr: \"name\" , label: false },
			//Subtotal of that row (quantity of that item * the price)
			{ view: 'currency', attr: \"total\" , label: false  }
		],
		cartStyle: 'div'
	});";
  Yii::app()->clientScript->registerScript('shoppingCartJS', $shoppingCartJs, CClientScript::POS_END);
  Yii::import('ext.jquery-gmap.*');

  $img_restaurant = Yii::app()->theme->baseUrl.'/images/rest2.png';
  $latitude = $restaurant->restaurantAddresses[0]->latitude;
  $longitude = $restaurant->restaurantAddresses[0]->longitude;
  $params = array('title' => $restaurant->name,
    'icon' => array ('url' => $img_restaurant,
    'anchor' => array ('x' => 1, 'y' => 36),
    ),
  );
  $marker = new EGMap3Marker($params);
  $marker->address = $latitude .', ' . $longitude;
  $marker->centerOnMap();

  $gmap = new EGmap3Widget();
  $gmap->setSize(120, 120);
  $options = array(
        'id' => 'myId',
        'streetViewControl' => false,
        'mapTypeControl' => false,
        'zoom' => 10,
        );

  $gmap->setOptions($options);
  $gmap->add($marker);

  $this->beginContent('//layouts/header');
  $this->endContent();

  $food_model = new FoodItem();
  $w_categories = $this->widget('ext.widgets.EchMultiselect', array(
    'model' => $food_model,
    'dropDownAttribute' => 'name',
    'data' => $data= CHtml::listData($food_model->findAll(), 'id', 'name'),
    'dropDownHtmlOptions'=> array(
        'style'=>'width:100px;',
    ),
    'options' => array('header' => 'Select',
        'noneSelectedText' => 'Filter by Category',
        'selectedList' => 1,
        'minWidth'=>125,
        'label' => 'Select Category',
        'multiple' => false,
        'position'=>array('my'=>'left bottom', 'at'=>'left top'),)
  ), true);
  $w_vegetarian = $this->widget('ext.widgets.EchMultiselect', array(
    'model' => $food_model,
    'dropDownAttribute' => 'description',
    'data' => $data= CHtml::listData($food_model->findAll(), 'id', 'name'),
    'dropDownHtmlOptions'=> array(
        'style'=>'width:100px;',
    ),
    'options' => array('header' => 'Select Location',
        'noneSelectedText' => 'Filter by Category',
        'selectedList' => 1,
        'minWidth'=>125,
        'label' => 'Select Category',
        'multiple' => false,
        'position'=>array('my'=>'left bottom', 'at'=>'left top'),)
  ), true);
 ?>
<div class="bg">
  <?php $this->renderPartial('__showRestaurantHeader', array('restaurant' => $restaurant)); ?>
  <section id="content">
    <div class="main">
      <div class="container_12">
        <div class="wrapper margin-bot">
          <article class="grid_2">
            <div id="restaurant-about">
              <a id="btn_about" class="button-2" href="#" rel="modal-profile">About</a>
              <div class="modal-lightsout"></div>
              <div class="modal-profile">
                <a href="#" title="Close profile window" class="modal-close-profile">
                  <img src="<?php echo Yii::app()->theme->baseUrl.'/images/restaurant/modal/close.png'; ?>"
                       alt="Close profile window" />
                </a>
                <h1 class="restName"><?php echo $restaurant->name; ?></h1>
                <p class="restAbout"><?php echo $restaurant->about;?></p>
              </div>
            </div>
            <div id="restaurant-feedback">Feedback Loading ... </div>
            <div id="restaurant-activities">Loading... </div>
          </article>

          <article class="grid_8">
            <div id="filters">
              <div>
                <div id="serach_box"> <label> Filter : </label><input width="200" type="text" id="q" name="q" />
                  <span><?php echo $w_categories; echo $w_vegetarian;?></span>
                </div>
                <div class="filters speciality">
                  <input type="checkbox" name="combo" id="combo" value="1">Combo</input>
                  <input type="checkbox" name="speciality" id="speciality" value="1">Specialities</input>
                </div>
              </div>
            </div>
            <div class="wrapper">
              <article class="grid_6 alpha">
                <div class="filter message">Filters selected</div>
                <div id="restaurant-menu"> Loading... </div>
              </article>
              <article class="grid_2 omega">
                  <div id ="restaurant-map" class="indent-left"><?php echo $gmap->renderMap(); ?></div>
              </article>
              <article class="">
                <!-- The Shopping cart code begins here....
                <div class="rm">
                  <div id="cartPopoverI">
                    <div class="simpleCart_items"></div>
                      <div id="cartData" class="clearfix">
                        <div class="left"><strong>Items: </strong><span class="simpleCart_quantity"></span></div>
                        <div class="right"><strong>Total INR: </strong><span class="simpleCart_total"></span></div>
                      </div>
                      <div id="popoverButtons" class="clearfix">
                        <a href="javascript:;" class="simpleCart_empty">Empty</a>
                        <a href="javascript:;" class="simpleCart_checkout hudbtn primary right">Checkout</a>
                      </div>
                  </div>
                </div>
                <!-- End of Shopping Cart Code -->
              </article>
              <article>
                <div id="shopping_cart">

                </div>
              </article>
            </div>
          </article>
        </div>
      </div>
    </div>
  </section>
</div>