<?php
$this->widget('ext.slider.slider', array(
            'sliderBase' => '/themes/'.Yii::app()->theme->name.'/images/slider/',
            'container'=>'slideshow',
            'width'=>200, 
            'height'=>120, 
            'timeout'=>6000,
            'infos'=>true,
            'constrainImage'=>true,
            'images'=>array('01.jpg','02.jpg','03.jpg','04.jpg'),
            'alts'=>array('Get 50% off. Valid till 20 May 2012. Between 8:00 am to 12:00 pm'
                ,'Second description','Third description','Four description'),
            'defaultUrl'=>Yii::app()->request->hostInfo
            )
        );
  ?>
