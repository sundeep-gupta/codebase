<?php
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
        'streetViewControl' => false,
        'mapTypeControl' => false,
        'zoom' => 10,
        );

  $gmap->setOptions($options);
  $gmap->add($marker);
  if(isset($gmap)) {
    $gmap->renderMap();
  } else {
    echo "No map";
  }
?>
