<?php
$this->breadcrumbs=array(
	'Coupons'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List Coupon', 'url'=>array('index')),
	array('label'=>'Manage Coupon', 'url'=>array('admin')),
);
?>

<h1>Create Coupon</h1>

<?php echo $this->renderPartial('_formCoupon', array('model'=>$model)); ?>