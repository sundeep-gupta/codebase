<?php
  $cssFiles = array(Yii::app()->theme->baseUrl.'/css/reset.css' => 'screen, projection',
      Yii::app()->theme->baseUrl . '/css/grid.css' => 'screen',
      Yii::app()->theme->baseUrl . '/css/slide.css' => 'screen',
      Yii::app()->theme->baseUrl .'/css/style.css' => 'screen',
      Yii::app()->theme->baseUrl . '/css/jquery.reject.css'=> '');
  foreach ($cssFiles as $cssFile => $media) {
    Yii::app()->clientScript->registerCssFile($cssFile, $media);
  }
  
  $scriptFiles = array( Yii::app()->theme->baseUrl. '/js/jquery/jquery.js'
      , Yii::app()->theme->baseUrl . '/js/jquery/jquery.reject.js'
      , Yii::app()->theme->baseUrl . '/js/jquery/yiitab/tabs.js'
      , Yii::app()->theme->baseUrl . '/js/jquery/jquery.min.js'
      , Yii::app()->theme->baseUrl . '/js/jquery/yiitab/jquery-ui.min.js'
      , Yii::app()->theme->baseUrl . '/js/jquery/yiitab/prettify.js'
      , Yii::app()->theme->baseUrl . '/js/jquery/yiitab/slide.js'
      , Yii::app()->theme->baseUrl . '/js/slider.js'
      , Yii::app()->theme->baseurl . '/js/dineavenue.js');
  foreach ($scriptFiles as $scriptFile) {
   # Yii::app()->clientScript->registerScriptFile($scriptFile);
  }
?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="language" content="en" />
  <?php 
  foreach($scriptFiles as $scriptFile) {
    echo '<script type="text/javascript" src="' .$scriptFile.'"></script>'."\n";
  }
  ?>
	<title><?php echo CHtml::encode($this->pageTitle); ?></title>
</head>

<body onload="prettyPrint();">
	<?php 
    $this->beginContent('//layouts/_header');
    $this->endContent();
    echo $content; 
    $this->beginContent('//layouts/_footer');
    $this->endContent();
  ?>
</body>
</html>
