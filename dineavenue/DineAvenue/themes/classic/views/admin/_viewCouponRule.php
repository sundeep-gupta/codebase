<div class="view">

	<b><?php echo CHtml::encode($data->getAttributeLabel('id')); ?>:</b>
	<?php echo CHtml::link(CHtml::encode($data->id), array('view', 'id'=>$data->id)); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('coupon_id')); ?>:</b>
	<?php echo CHtml::encode($data->coupon_id); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('restriction_type')); ?>:</b>
	<?php echo CHtml::encode($data->restriction_type); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('value')); ?>:</b>
	<?php echo CHtml::encode($data->value); ?>
	<br />


</div>