<?php
$this->breadcrumbs=array(
	'Articles'=>array('index'),
	'Manage',
);

$this->menu=array(
	array('label'=>'List Article', 'url'=>array('index')),
	array('label'=>'Create Article', 'url'=>array('create')),
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
	$('.search-form').toggle();
	return false;
});
$('.search-form form').submit(function(){
	$.fn.yiiGridView.update('article-grid', {
		data: $(this).serialize()
	});
	return false;
});
");
?>

<h1>Manage Articles</h1>

<p>
You may optionally enter a comparison operator (<b>&lt;</b>, <b>&lt;=</b>, <b>&gt;</b>, <b>&gt;=</b>, <b>&lt;&gt;</b>
or <b>=</b>) at the beginning of each of your search values to specify how the comparison should be done.
</p>

<?php echo CHtml::link('Advanced Search','#',array('class'=>'search-button')); ?>
<div class="search-form" style="display:none">
<?php $this->renderPartial('_searchArticle',array(
	'model'=>$model,
)); ?>
</div><!-- search-form -->

<?php $this->widget('zii.widgets.grid.CGridView', array(
	'id'=>'article-grid',
	'dataProvider'=>$model->search(),
	'filter'=>$model,
	'columns'=>array(
		'id',
		'user_id',
		'title',
		'text',
		'createtime',
		'modifiedtime',
		/*
		'visits',
		'published',
		*/
		array(
			'class'=>'CButtonColumn',
      'buttons' => array(
          'delete' => array(
              'url' => 'CController::createUrl("/admin/deleteArticle", array("id" => $data->primaryKey))'
          ),
          'update' => array(
              'url' => 'CController::createUrl("/admin/editArticle", array("id" => $data->primaryKey))'
          ),
          'view' => array(
              'url' => 'CController::createUrl("/admin/viewArticle", array("id" => $data->primaryKey))'
          ),
      ),
		),
	),
)); 
?>
