<div class="form">

<?php $form=$this->beginWidget('CActiveForm', array(
	'id'=>'coupon-rules-form',
	'enableAjaxValidation'=>false,
)); ?>

	<p class="note">Fields with <span class="required">*</span> are required.</p>

	<?php echo $form->errorSummary($model); ?>

	<div class="row">
		<?php echo $form->labelEx($model,'coupon_id'); ?>
		<?php echo $form->textField($model,'coupon_id',array('size'=>10,'maxlength'=>10)); ?>
		<?php echo $form->error($model,'coupon_id'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'restriction_type'); ?>
		<?php echo $form->textField($model,'restriction_type',array('size'=>10,'maxlength'=>10)); ?>
		<?php echo $form->error($model,'restriction_type'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'value'); ?>
		<?php echo $form->textField($model,'value',array('size'=>60,'maxlength'=>300)); ?>
		<?php echo $form->error($model,'value'); ?>
	</div>

	<div class="row buttons">
		<?php echo CHtml::submitButton($model->isNewRecord ? 'Create' : 'Save'); ?>
	</div>

<?php $this->endWidget(); ?>

</div><!-- form -->