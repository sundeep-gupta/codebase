<?php
  $ra_phone = array('img' => Yii::app()->theme->baseUrl . '/images/restaurant/phone_2_32.png',
          'alt' => 'Phone', 'text' => $data['phone']);
  $facilities = $data['facilities'];
  $rh_restaurant_properties = array();
  foreach ($facilities as $property_name => $value) {
    if ($value == true) {
      array_push($rh_restaurant_properties, array(
                'img_src' => Yii::app()->theme->baseUrl.'/images/restaurant/'.$property_name . '.png',
                'img_alt' => $property_name,
                'img_htmlOptions' => array('class' => 'iconHight2')
              ));   
    } else {
      if ($property_name == RestaurantProperties::VEGETARIAN) {
              $property_name = RestaurantProperties::NON_VEGETARIAN;
              $rh_restaurant_properties[] = array(
                'img_src' => Yii::app()->theme->baseUrl.'/images/restaurant/'.$property_name . '.png',
                'img_alt' => $property_name,
                'img_htmlOptions' => array('class' => 'iconHight2')
              );      
      }
    }
  }
  //$rh_restaurant_properties = getRestaurantProperties($data['id']);
    $rh_restaurant_actionable_properties = array(
        array('img_src' => Yii::app()->theme->baseUrl.'/images/restaurant/specialoffer.png',
            'img_alt' => 'Special offer',
            'img_htmlOptions' => array('class' => 'iconHight3'),
            'url' => Yii::app()->request->baseUrl,
            ),
        array('img_src' => Yii::app()->theme->baseUrl.'/images/restaurant/menu2.png',
            'img_alt' => 'Menu',
            'img_htmlOptions' => array('class' => 'iconHight3'),
            'url' => Yii::app()->request->baseUrl
            ),
        array('img_src' => Yii::app()->theme->baseUrl.'/images/restaurant/map2.png',
            'img_alt' => 'Map',
            'img_htmlOptions' => array('class' => 'iconHight3'),
            'url' => Yii::app()->request->baseUrl,
            ),
        array('img_src' => Yii::app()->theme->baseUrl.'/images/restaurant/opensign.png',
            'img_alt' => 'Open/Closed',
            'img_htmlOptions' => array('class' => 'iconHight3'),
            'url' => Yii::app()->request->baseUrl,
            ),
    );
?>
<div class="restList">
  <div class="restListHeader">
    <div class="restTitle">
      <?php echo CHtml::link($data['restaurant_name'], $this->createUrl('restaurant/showRestaurant'
              , array('id' => $data['id']))); ?>      
    </div>
    <div class="restIcons">
      <?php

        $img_web = Yii::app()->theme->baseUrl . '/images/restaurant/web_48_F.png';
        $link_map = Yii::app()->request->baseUrl;
        $link_web = Yii::app()->request->baseUrl;
        echo CHtml::image($ra_phone['img'], $ra_phone['alt'], array('class' => 'iconHight'));
        echo $ra_phone['text'];
     
        echo CHtml::link(CHtml::image($img_web, 'Map', array('class'=> 'iconHight')), $link_web);
      ?>
    </div>
  </div>
  <div class="listContent">
    <div class="listAddress">
      <p>
      <?php echo $data['line1']. '<br/>' . $data['line2'] . '<br/>'. $data['location'] . '<br/>' .
                  'Landmark : ' . $data['landmark'].'<br/>' . $data['city'] . '<br/>'. $data['zipcode'] . '<br/>';
      ?>
      </p>
    </div>
    <div class="listIcons">
        <?php
          foreach ($rh_restaurant_properties as $rh_restaurant_property) {
            echo CHtml::image($rh_restaurant_property['img_src'], $rh_restaurant_property['img_alt']
                    , $rh_restaurant_property['img_htmlOptions']);
          }
        ?>
     </div>            
    <div class="listIcons2">
      <?php
        foreach ($rh_restaurant_actionable_properties as $rh_restaurant_property) {    
          echo CHtml::link(CHtml::image($rh_restaurant_property['img_src'], $rh_restaurant_property['img_alt']
                    , $rh_restaurant_property['img_htmlOptions']),$rh_restaurant_property['url']);
        }
      ?>                  
    </div>
  </div>
</div>
     
