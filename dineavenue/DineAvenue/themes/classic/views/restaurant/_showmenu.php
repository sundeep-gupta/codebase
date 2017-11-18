<?php
  $isGuest = Yii::app()->user->name != 'Guest';
    // TODO : I don't like business logic inside the views... remove it asap
  $ra_required = array('SERVES', 'PRICE', 'SPICY', 'SPECIAL', 'VEGETARIAN');
  $ra_values = array('SERVES' => '4', 'PRICE' => '10', 'SPICY' => '2' , 'SPECIAL' => '0', 'VEGETARIAN' => '1');
  $menu_detail_id = $data->id;
  $menu_item_name = $data->menuItem->name;
  $menu_item_desc = $data->description;
  if (strlen($menu_item_desc) == 0) {
    $menu_item_desc = $data->menuItem->description;;
  }
  $menuItemProperties = $data->restaurantMenuItemProperties;
  foreach ($menuItemProperties as $menuItemProperty) {
    if (in_array($menuItemProperty->property->name, $ra_required)) {
      $ra_values[$menuItemProperty->property->name] = $menuItemProperty->value;
    }
  }
  if ($ra_values['VEGETARIAN'] == '1') {
      $ra_values['VEGETARIAN'] = Yii::app()->theme->baseUrl.'/images/restaurant/VEGETARIAN18.png';
  } else {
      $ra_values['VEGETARIAN'] = Yii::app()->theme->baseUrl.'/images/restaurant/NONVEGETARIAN18.png';
  }
  $ra_values['SPICY'] = Yii::app()->theme->baseUrl.'/images/restaurant/spicy'.$ra_values['SPICY'].'.png';
?>
<div class="menuItemList">
  <!-- <div class="simpleCart_shelfItem"> -->
  <div id="<?php echo "menuItem_" . $menu_detail_id; ?>" class="menuItemName">
    <!-- <div class="item_name"> -->
      <?php echo $menu_item_name; ?>
    <!-- </div> -->
  </div>
  <div class="menuItemProperties">
<?php
  if ($ra_values['SPECIAL'] == 1) {
    echo CHtml::image(Yii::app()->theme->baseUrl.'/images/restaurant/speciality18.png');
  }
  else {
      echo CHtml::image(Yii::app()->theme->baseUrl.'/images/restaurant/speciality18N.png');
  }
  echo CHtml::image($ra_values['SPICY']);
  echo CHtml::image($ra_values['VEGETARIAN']);
  echo "Serves ". $ra_values['SERVES'];
?>
  </div>
  <div class="menuItemCostSymbol">
    <?php
      echo CHtml::image(Yii::app()->theme->baseUrl.'/images/restaurant/rupee18.png');
    ?>
  </div>
  <div class="menuItemCost"><div class="item_price"><?php echo $ra_values['PRICE']; ?></div></div>

  <?php
    if (!$isGuest) {
      #echo '<div id="order-checkbox">';
      #echo '<input type="button" class="item_add" value="+"></input>';
      #echo '</div>';
      echo '<div class="add_to_cart">+</div>';
    }
  ?>
</div>
<!-- </div> -->