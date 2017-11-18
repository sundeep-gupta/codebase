<?php
$this->breadcrumbs=array(
	'Coupon Rules'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List CouponRules', 'url'=>array('index')),
	array('label'=>'Create CouponRules', 'url'=>array('create')),
	array('label'=>'Update CouponRules', 'url'=>array('update', 'id'=>$model->id)),
	array('label'=>'Delete CouponRules', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage CouponRules', 'url'=>array('admin')),
);
?>

<h1>View CouponRules #<?php echo $model->id; ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'coupon_id',
		'restriction_type',
		'value',
	),
)); ?>
