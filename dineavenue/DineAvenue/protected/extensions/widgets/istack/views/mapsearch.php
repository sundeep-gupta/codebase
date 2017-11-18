<div id="featured-wrapper" class="grid_12 all-rounded">
  <div class="arrowleft">&nbsp;</div>
  <div id="featured-thumb" class="grid_12 alpha omega all-rounded">	
    <ul id="featured-thumb-list">
      <?php
        foreach ($this->model as $ar_record) {
          $url = $this->getController()->createUrl($this->getController()->getActionUrl('mapSearchResult')
                  , array('map' => $ar_record->name));
          echo CHtml::tag('li', array('class' => 'grid_1 alpha'), CHtml::link(
                  CHtml::tag('img', 
                          array('src' => Yii::app()->theme->baseUrl.'/images/map.png', 'alt' => $ar_record->name,
                              'width' => 60, 'height'=>60, 'class' => 'all-rounded')) 
                  .CHtml::tag('p',array(), $ar_record->name),
                  "javascript:loadMapSearchResult('$url')",
                  $htmlOptions = array('class'=> 'all-rounded')));
        }
      ?>
    </ul>
  </div>
  <div class="arrowright">&nbsp;</div>
            <!--<div class="clear">&nbsp;</div> -->
</div>