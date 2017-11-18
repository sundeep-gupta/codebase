<?php
$this->breadcrumbs=array(
	'Food Items',
);

$this->menu=array(
	array('label'=>'Create FoodItem', 'url'=>array('create')),
	array('label'=>'Manage FoodItem', 'url'=>array('admin')),
);
?>

<h1>Food Items</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
