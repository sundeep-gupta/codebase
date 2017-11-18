<?php
  $a_links = array();
  foreach ($data as $row) {
    array_push($a_links, CHtml::tag('li', array(), CHtml::link($row->{$this->column},
            $this->getController()->createUrl($this->action, array('id' => $row->{$this->id}))
            )));
            //Yii::app()->request->baseUrl.'/'.$this->id)));
  }
?>
<article class="grid_4">
  <h3><?php echo $this->header; ?></h3>
  <ul class="list-1"><?php 
    foreach ($a_links as $a_link) {
      echo $a_link;
    }
  ?>
  </ul>
</article>
            