<?php
$this->widget('ext.slider.slider', array(
      'container'=>'slideshow',
      
      'sliderBase' => '/themes/'.Yii::app()->theme->name.'/images/slider/',
      'imagesPath' => 'all',
      'width'=>200, 
      'height'=>190, 
      'timeout'=>6000,
      'infos'=>true,
      'constrainImage'=>true,
      'images'=>array('01.jpg','02.jpg','03.jpg','04.jpg'),
      'alts'=>array('First description','Second description','Third description','Four description'),
      'defaultUrl'=>Yii::app()->request->hostInfo
      ));
?>
