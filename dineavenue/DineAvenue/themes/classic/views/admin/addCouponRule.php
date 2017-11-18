<?php
$this->breadcrumbs=array(
	'Coupon Rules'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List CouponRules', 'url'=>array('index')),
	array('label'=>'Manage CouponRules', 'url'=>array('admin')),
);
?>

<h1>Create CouponRules</h1>

<?php echo $this->renderPartial('_formCouponRule', array('model'=>$model)); ?>