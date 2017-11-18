<?php
  $a_logout = CHtml::ajaxLink('Logout', $this->createUrl('user/logout'),
                  array('update'=>'#toppanel'),
                  array('class' => 'open', 'name' => 'submit')
                  );
?>
<div id="toppanel">
<div class="tab">
    <ul class="login">
      <li class="left">&nbsp;</li>
      <li>Hello <?php echo Yii::app()->user->name; ?>!</li>
      <li class="sep">|</li>
      <li id="toggle"><?php echo $a_logout; ?></li>
      <li class="right">&nbsp;</li>
    </ul>
  </div> <!-- / tab -->
  </div>