<div class="form">

<?php $form=$this->beginWidget('CActiveForm', array(
	'id'=>'coupon-form',
	'enableAjaxValidation'=>false,
)); ?>

	<p class="note">Fields with <span class="required">*</span> are required.</p>

	<?php echo $form->errorSummary($model); ?>

	<div class="row">
		<?php echo $form->labelEx($model,'description'); ?>
		<?php echo $form->textField($model,'description',array('size'=>60,'maxlength'=>300)); ?>
		<?php echo $form->error($model,'description'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'start_date'); ?>
<?php
    $this->widget('zii.widgets.jui.CJuiDatePicker', array(
        'model' => $model,
        'attribute' => 'start_date',
        'value' => $model->start_date,
        // additional javascript options for the date picker plugin
        'options'=>array(
            'dateFormat'=>'yy-mm-dd',
            'buttonText'=>'Select',
            'showAnim'=>'fold',
        ),
        'htmlOptions'=>array(
            'style'=>'height:20px;'
        ),
    ));
?>
		<?php echo $form->error($model,'start_date'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'end_date'); ?>
<?php
    $this->widget('zii.widgets.jui.CJuiDatePicker', array(
        'model' => $model,
        'attribute' => 'end_date',
        'value' => $model->end_date,
        // additional javascript options for the date picker plugin
        'options'=>array(
            'dateFormat'=>'yy-mm-dd',
            'buttonText'=>'Select',
            'showAnim'=>'fold',
        ),
        'htmlOptions'=>array(
            'style'=>'height:20px;'
        ),
    ));
?>		
    <?php echo $form->error($model,'end_date'); ?>
	</div>
<!--
	<div class="row">
		<?php echo $form->labelEx($model,'create_time'); ?>
		<?php echo $form->textField($model,'create_time',array('size'=>12,'maxlength'=>12)); ?>
		<?php echo $form->error($model,'create_time'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'modified_time'); ?>
		<?php echo $form->textField($model,'modified_time',array('size'=>12,'maxlength'=>12)); ?>
		<?php echo $form->error($model,'modified_time'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'modified_by'); ?>
		<?php echo $form->textField($model,'modified_by',array('size'=>10,'maxlength'=>10)); ?>
		<?php echo $form->error($model,'modified_by'); ?>
	</div>
-->
	<div class="row">
		<?php echo $form->labelEx($model,'published'); ?>
		<?php echo $form->textField($model,'published'); ?>
		<?php echo $form->error($model,'published'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'discount_type'); ?>
		<?php echo $form->textField($model,'discount_type',array('size'=>10,'maxlength'=>10)); ?>
		<?php echo $form->error($model,'discount_type'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'discount_value'); ?>
		<?php echo $form->textField($model,'discount_value',array('size'=>60,'maxlength'=>255)); ?>
		<?php echo $form->error($model,'discount_value'); ?>
	</div>

	<div class="row buttons">
		<?php echo CHtml::submitButton($model->isNewRecord ? 'Create' : 'Save'); ?>
	</div>

<?php $this->endWidget(); ?>

</div><!-- form -->