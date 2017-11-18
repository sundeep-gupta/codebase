<?php
  $url = $this->createUrl('restaurant/addToCart');
  $menus = $restaurant->restaurantMenus;
  if (count($menus) > 0) {
    $menuDetailsDataProvider = new CArrayDataProvider($menus[0]->restaurantMenuDetails,
          array('keys' => array('id' => 'id')));
    $this->widget('zii.widgets.CListView', array(
        'dataProvider'=>$menuDetailsDataProvider,
        'itemView'=>'_showmenu',
    ));
  } else {
     echo "No Menu for this restaurant";
  }
/* TODO This is a dirty workaround to initialize the jQuery event handler functions of shopping cart
  added this because when I am calling 'addToCart()' on the POS_READY of the showRestaurant action
   it is not executed.
*/

?>
<script>
  addToCart(<?php echo '\'' . $url . '\''; ?>);
  // so that we have empty cart ;;;
  updateCart(<?php echo '\'' . $url . '\''; ?>);
</script>