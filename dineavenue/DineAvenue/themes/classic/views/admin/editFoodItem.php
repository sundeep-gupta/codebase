<?php
$this->breadcrumbs=array(
	'Food Items'=>array('index'),
	$model->name=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List FoodItem', 'url'=>array('index')),
	array('label'=>'Create FoodItem', 'url'=>array('create')),
	array('label'=>'View FoodItem', 'url'=>array('view', 'id'=>$model->id)),
	array('label'=>'Manage FoodItem', 'url'=>array('admin')),
);
?>

<h1>Update FoodItem <?php echo $model->id; ?></h1>

<?php echo $this->renderPartial('_formFoodItem', array('model'=>$model)); ?>