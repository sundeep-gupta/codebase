<?php
$this->breadcrumbs=array(
	'Coupon Rules'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List CouponRules', 'url'=>array('index')),
	array('label'=>'Create CouponRules', 'url'=>array('create')),
	array('label'=>'View CouponRules', 'url'=>array('view', 'id'=>$model->id)),
	array('label'=>'Manage CouponRules', 'url'=>array('admin')),
);
?>

<h1>Update CouponRules <?php echo $model->id; ?></h1>

<?php echo $this->renderPartial('_formCoupon', array('model'=>$model)); ?>