<?php
$this->breadcrumbs=array(
	'Food Items'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List FoodItem', 'url'=>array('index')),
	array('label'=>'Manage FoodItem', 'url'=>array('admin')),
);
?>

<h1>Create FoodItem</h1>

<?php echo $this->renderPartial('_formFoodItem', array('model'=>$model)); ?>