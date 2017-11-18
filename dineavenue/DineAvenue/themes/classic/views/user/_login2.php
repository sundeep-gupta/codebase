<div id="toppanel">
<div id="panel">
  	<div class="content clearfix">
      <div class="left">
                  <!-- Login Form -->
       <p class="f1">Member Login</p>
<?php
    echo CHtml::beginForm();
          if (!isset($user_model)) {
            $user_model = new LoginForm();
          }
          echo CHtml::activeLabelEx($user_model, 'username', array('class'=>'grey'));
          echo CHtml::activeTextField($user_model,'username', array(
              'class' => 'field', 'id' => 'username', 'size' => '23'));
          //echo $form->error($user_model, 'username', array('class'=>'grey'));
          echo CHtml::activeLabelEx($user_model, 'password', array('class'=>'grey'));
          echo CHtml::activePasswordField($user_model, 'password', array(
              'class' => 'field', 'id' => 'password', 'size' => '23'
          ));
          //echo $form->error($this->user_model, 'password', array('class'=>'grey'));
          echo CHtml::activeLabelEx($user_model,'rememberMe');
          echo CHtml::activeCheckBox($user_model,'rememberMe');
          //echo $form->error($user_model,'rememberMe');
          echo CHtml::ajaxSubmitButton('Log In', $this->createUrl('login'),
                  array('update'=>'#toppanel'),
                  array('class' => 'bt_login', 'name' => 'submit')
                  );
          ?>
<?php echo CHtml::endForm(); ?>
      </div>
      <div class="left right">
        <!-- Register Form -->
         <p class="f1">Not a member yet? Sign Up!</p>
<?php
/*
if (!isset($this->register_model)) {
  $this->register_model = new RegisterForm();
}

$r_form = $this->beginWidget('CActiveForm', array (
	'id' => 'register-form',
    'method' => 'post',
	'enableClientValidation' => true,
	'clientOptions'=>array(
        'validateOnSubmit'=>true,
	),
    'htmlOptions' => array(
        'name' => 'register-form'
    ),
));
echo $r_form->labelEx($this->user_model, 'username', array('class'=>'grey'));
          echo $r_form->textField($this->user_model,'username', array(
              'class' => 'field', 'id' => 'username', 'size' => '23'));
          //echo $form->error($this->user_model, 'username', array('class'=>'grey'));
          echo $form->labelEx($this->user_model, 'password', array('class'=>'grey'));
          echo $form->passwordField($this->user_model, 'password', array(
              'class' => 'field', 'id' => 'password', 'size' => '23'
          ));
echo $r_form->labelEx($this->user_model, 'email', array('class'=>'grey'));
          echo $r_form->textField($this->user_model,'email', array(
              'class' => 'field', 'id' => 'email', 'size' => '23'));
          ?>
          <label>A password will be e-mailed to you.</label>
          <input type="submit" name="submit" value="Register" class="bt_register"></input>
       <?php $this->endWidget(); */?>

      </div>  <!-- left right -->
    </div>  <!-- content clearfix -->
  </div> <!-- panel -->
  <div class="tab">  <!-- The tab on top -->
    <ul class="login">
      <li class="left">&nbsp;</li>
      <li>Hello <?php echo Yii::app()->user->name; ?>!</li>
      <li class="sep">|</li>
      <li id="toggle">
      	<a id="open" class="open" href="#">Log In | Register</a>
        <a id="close" style="display: none;" class="close" href="#">Close Panel</a>
      </li>
      <li class="right">&nbsp;</li>
    </ul>
  </div> <!-- / tab -->
  </div>