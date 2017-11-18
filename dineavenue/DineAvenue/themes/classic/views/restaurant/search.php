<?php
  $this->pageTitle = Yii::app()->name;
  $this->beginContent('//layouts/header');
  $this->endContent();
  $params = array();
  if (isset($ra_search_item )) {
    $params['ra_search_item'] = $ra_search_item;
  }
  if (isset($ra_search_locations)) {
    $params['ra_search_locations'] = $ra_search_locations;
  }
  $result = "No Search Result";
  echo $this->renderPartial('__searchbar', $params, true);
  if (isset($dataProvider) && count($dataProvider) > 0) {
    $result =   $this->widget('zii.widgets.CListView', array(
      'dataProvider'=> $dataProvider,
      'itemView'=>'__showsearch',
    ), true);
  }
  
?>
<div class="bg">
<section id="content">
  <div class="main">
    <div class="container_12">
      <div class="wrapper img-indent-bot">
        <article class="grid_8">
          <h3>Search Result...</h3>
            <div class="search-result">              
              <?php echo $result; ?>
            </div>
        </article>
        <article class="grid_2">
          <h2>Offers/Coupons get displayed here...</h2>
          <div class="wrapper prev-indent-bot">
            <figure class="img-indent2">
              <img src="<?php echo Yii::app()->request->baseUrl;?>/images/page1-img4.jpg" alt=""/>
            </figure>
            <div class="extra-wrap">
              <h6 class="p1">blah blah blah</h6>
            </div>
          </div>
          <p class="prev-indent-bot">And blah</p>
          <a class="button-2" href="#">Read More</a>
        </article>
      </div>
      <div class="wrapper"></div>  
    </div>
  </div>
</section>
</div> <!-- bg -->
