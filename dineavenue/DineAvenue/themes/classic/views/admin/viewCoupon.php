<?php
$this->breadcrumbs=array(
	'Coupons'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List Coupon', 'url'=>array('index')),
	array('label'=>'Create Coupon', 'url'=>array('create')),
	array('label'=>'Update Coupon', 'url'=>array('update', 'id'=>$model->id)),
	array('label'=>'Delete Coupon', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage Coupon', 'url'=>array('admin')),
);
?>

<h1>View Coupon #<?php echo $model->id; ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'description',
		'start_date',
		'end_date',
		'create_time',
		'modified_time',
		'modified_by',
		'published',
		'discount_type',
		'discount_value',
	),
)); ?>
