<?php
  if (count($markers) > 0) {
    Yii::import('ext.jquery-gmap.*');
    $gmap = new EGmap3Widget();
    $gmap->setSize(600, 400);
      // base options
    $options = array(
        'scaleControl' => true,
        'streetViewControl' => false,
        'zoom' => 10,
        'center' => array(0, 0),
        # Uncomment this if you need Satellite view, instead of map view.
        # 'mapTypeId' => EGmap3MapTypeId::HYBRID,
        'mapTypeControlOptions' => array(
            'style' => EGmap3MapTypeControlStyle::DROPDOWN_MENU,
            'position' => EGmap3ControlPosition::TOP_CENTER,
            ),
        );

    $gmap->setOptions($options);
    foreach ($markers as $marker) {
      $gmap->add($marker);
    }  
    
  } else {
    $message = "No restaurant found.";
  }
  
  //$pageTitle = Yii::app()->name;
  //$this->beginContent('//layouts/header');
  //$this->endContent();
  //echo $this->renderPartial('_searchbar', null, true);
?>
<div class="wrapper img-indent-bot">
  <article class="grid_8">
    <h3>Search Result...</h3>
      <div class="search-result">   
        <?php 
        if (isset($gmap)) {
          $gmap->renderMap(); 
        } else {
          echo $message;
        } ?>
      </div>
  </article>  
</div>