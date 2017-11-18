<?php
  $menu_items = array(
                      array('label'=>'Home', 'url'=> $this->createUrl('/')),
                      array('label'=>'Search', 'url'=> $this->createUrl('search')),
                      array('label'=>'Menu', 'url'=> $this->createUrl('menu')),
                      array('label'=>'Contact', 'url'=> $this->createUrl('contact')),
      );
  foreach ($menu_items as $menu_item) {
    if (isset($this->activeMenuItem) && $menu_item['label'] == $this->activeMenuItem) {
      $menu_item['active'] = true;
    }
  }
  $w_menu = $this->widget('zii.widgets.CMenu',array(
          'items'=> $menu_items,
          'htmlOptions' => array('class' => 'menu wrapper'),
  ), true); 
  ?>
<header>
  <div class="menu-row">
    <div class="main">
      <nav><?php 
      /* Commenting this out 
       * echo $w_menu; 
       */
      ?>
      </nav>
      
       <div id="link">
	
		<?php
		
		if(isset(Yii::app()->request->cookies['selected_city']))
		{	
				echo 'Your Current Selected City is : '.Yii::app()->request->cookies['selected_city']->value.'  <br/>   ';	
				$model=new City;
				$this->beginWidget('zii.widgets.jui.CJuiDialog', array(
				'id'=>'mydialog',
				// additional javascript options for the dialog plugin
				'options'=>array(
					'title'=>'Change City',
					'autoOpen'=>false,
				),));
		?>
		<?php
			echo '<h3>'.'Please Select Your City'.'</h3>';
		?>
		<?php 
				$form = $this->beginWidget('CActiveForm', array(
				'id'=>'city-form',
				'action'=>Yii::app()->createUrl('restaurant/ChangeCity'),
				'enableAjaxValidation'=>true,
				'enableClientValidation'=>true,
				'focus'=>array($model,'name'),
			)); 
		?>

		<?php echo $form->errorSummary($model); ?>
			   
			<div class="row">
				 <?php echo $form->dropDownList($model,'id',
				  CHtml::listData(City::model()->findAll(), 'id', 'name'),
				  array('empty'=>'Select Your City'))?>
			</div>

			<div class="row buttons">
			<?php echo CHtml::submitButton($model->isNewRecord ? 'Submit' : 'Save'); ?>
			</div>

			<?php $this->endWidget(); ?>


			<?php
				$this->endWidget('zii.widgets.jui.CJuiDialog');
				echo CHtml::link('Change City', '#', array(
			   'onclick'=>'$("#mydialog").dialog("open"); return false;',
			));

		}
			
		else
		{
					$model=new City;
					$this->beginWidget('zii.widgets.jui.CJuiDialog', array(
					'id'=>'mydialog',
					// additional javascript options for the dialog plugin
					'options'=>array(
						'title'=>'select Your City',
						'autoOpen'=>true,
					),
				));
			echo '<h3>'.'Please Select Your City'.'</h3>';
				?>
			<?php $form = $this->beginWidget('CActiveForm', array(
				'id'=>'city-form',
				'action'=>Yii::app()->createUrl('restaurant/SelectCity'),
				'enableAjaxValidation'=>true,
				'enableClientValidation'=>true,
				'focus'=>array($model,'name'),
			)); ?>

			<?php echo $form->errorSummary($model); ?>
			   
			<div class="row">
			 <?php echo $form->dropDownList($model,'id',
			  CHtml::listData(City::model()->findAll(), 'id', 'name'),
			  array('empty'=>'Select Your City'))?>
			</div>

			<div class="row buttons">
			<?php echo CHtml::submitButton($model->isNewRecord ? 'Submit' : 'Save'); ?>
			</div>

			<?php $this->endWidget(); ?>



			<?php
				$this->endWidget('zii.widgets.jui.CJuiDialog');
		}

		
	   ?>
	</div>
      
    </div> <!-- main -->
   </div><!-- menu-row-->

   <div class="main">
    <div class="wrapper p3">
      <h1><a href="<?php echo Yii::app()->baseUrl;?>"></a></h1> 
    </div> 
  </div>
</header>