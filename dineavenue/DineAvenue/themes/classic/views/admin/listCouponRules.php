<?php
$this->breadcrumbs=array(
	'Coupon Rules',
);

$this->menu=array(
	array('label'=>'Create CouponRules', 'url'=>array('create')),
	array('label'=>'Manage CouponRules', 'url'=>array('admin')),
);
?>

<h1>Coupon Rules</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
