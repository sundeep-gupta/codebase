<?php
$this->breadcrumbs=array(
	'Coupons'=>array('index'),
	'Manage',
);

$this->menu=array(
	array('label'=>'List Coupon', 'url'=>array('index')),
	array('label'=>'Create Coupon', 'url'=>array('create')),
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
	$('.search-form').toggle();
	return false;
});
$('.search-form form').submit(function(){
	$.fn.yiiGridView.update('coupon-grid', {
		data: $(this).serialize()
	});
	return false;
});
");
?>

<h1>Manage Coupons</h1>

<p>
You may optionally enter a comparison operator (<b>&lt;</b>, <b>&lt;=</b>, <b>&gt;</b>, <b>&gt;=</b>, <b>&lt;&gt;</b>
or <b>=</b>) at the beginning of each of your search values to specify how the comparison should be done.
</p>

<?php echo CHtml::link('Advanced Search','#',array('class'=>'search-button')); ?>
<div class="search-form" style="display:none">
<?php $this->renderPartial('_searchCoupons',array(
	'model'=>$model,
)); ?>
</div><!-- search-form -->

<?php $this->widget('zii.widgets.grid.CGridView', array(
	'id'=>'coupon-grid',
	'dataProvider'=>$model->search(),
	'filter'=>$model,
	'columns'=>array(
		'id',
		'description',
		'start_date',
		'end_date',
		'create_time',
		'modified_time',
		/*
		'modified_by',
		'published',
		'discount_type',
		'discount_value',
		*/
		array(
			'class'=>'CButtonColumn',
		),
	),
)); ?>
