<?php
  if (isset(Yii::app()->user->name) && Yii::app()->user->name != 'Guest') {
    $this->renderPartial('_login1');
  } else {
    $this->renderPartial('_login2');
  }
?>