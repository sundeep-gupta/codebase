<?php
  $lbl_attributes = $this->search_form->attributeLabels();
  $lbl_locations = $lbl_attributes['locations'];
  $lbl_items = $lbl_attributes['items'];

  /* widget for multi select */
  $w_locations = $this->widget('ext.widgets.EchMultiselect', array(
    'model' => $location_model,
    'dropDownAttribute' => 'name',
    'data' => CHtml::listData($location_model->findAll(), 'id', 'name'),
    'dropDownHtmlOptions'=> array(
        'style'=>'width:178px;',
    ),
    'options' => array('header' => 'Select Location',
        'noneSelectedText' => $lbl_locations,
        'minWidth'=>150,
        'label' => 'Select Location',
        'position'=>array('my'=>'left bottom', 'at'=>'left top'),)
  ), $captureOutput = true);

  $w_items = $this->widget('ext.widgets.EchMultiselect', array(
    'model' => $m_cusine,
    'dropDownAttribute' => 'name',
    'data' => $data= CHtml::listData($m_cusine->findAll(), 'id', 'name'),
    'dropDownHtmlOptions'=> array(
        'style'=>'width:178px;',
    ),
    'options' => array('header' => 'Select Location',
        'noneSelectedText' => $lbl_items,
        'minWidth'=>150,
        'label' => 'Select Location',
        'position'=>array('my'=>'left bottom', 'at'=>'left top'),)
  ), $captureOutput);

  $w_search_by_type = $this->widget('zii.widgets.jui.CJuiAutoComplete', array(
    'name'=>'zipsearch',
    'source'=> $dp_searchByType,
    // additional javascript options for the autocomplete plugin
    'options'=>array(
        'minLength'=>'2',
    ),
    'htmlOptions'=>array(
        'style'=>'height:20px;'
    ),
  ), $captureOutput);

  $w_mapsearch = $this->widget('ext.widgets.istack.X2MapSearch', array('model' => $location_model->findAll()
      ,'title' => 'name'), $captureOutput);

  $btn_submit = CHtml::link('Submit', 'javascript:document.forms[\'search-form\'].submit()',
        array(
            'id' => 'search::submit'
        )
  );
  $this->beginContent('//layouts/header');
  $this->endContent();
?>

<div class="bg">
<header>
  <div class="tab_container">
    <div id="tab1" class="tab_content" style="display: block; ">
      <div class="main">
        <div class="wrapper">
          <figure class="img-indent-r">
          <div id="advertise">Loading ... </div>
        </figure>
          <div class="extra-wrap">
            <div class="indent">
<?php
$this->beginWidget('CActiveForm', array (
	'id' => 'search-form',
    'method' => 'post',
    'action' => $this->createUrl('search'),
	'enableClientValidation' => true,
	'clientOptions'=>array(
        'validateOnSubmit'=>true,
	),
));
?>
              <div class="indent-left2">
                <div class="searchMulti">
                  <div class="searchLocation"><?php echo $w_locations; ?></div>
                  <div class="searchType"><?php echo $w_items; ?></div>
                  <div class="searchButton"><?php echo $btn_submit; ?></div>
                </div>
                <div class="searchZip">
                  <h6><label>Search</label><?php echo $w_search_by_type; ?></h6>
                </div>
<?php $this->endWidget(); ?>

                <div class="container_19"><?php echo $w_mapsearch; ?></div>
              </div> <!-- end of indent-left -->
            </div> <!-- end of extra-wrap -->
          </div>
        </div>
      </div>
    </div>
  </div>
</header>
<section id="content">
  <div class="main">
    <div id="content-main" class="container_12">
      <!-- Commenting this as it is not effecting UI
      <div class="wrapper img-indent-bot">
        -->
      <div>
        <div id="recent-restaurants">Loading...</div>
        <div id="recent-posts">Loading...</div>
      </div>
      <div class="wrapper">
        <div id="recent-comments">Loading...</div>
        <div id="recommendation">Loading...</div>
        <div id="popular-posts">Loading...</div>
        <!--
        <article class="grid_4">
        </article>
        -->
      </div>
    </div>
  </div>
</section>
</div> <!-- bg -->
