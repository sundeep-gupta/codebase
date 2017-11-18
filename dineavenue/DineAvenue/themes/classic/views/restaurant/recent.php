<?php
  $this->widget('ext.widgets.istack.NewAdditions'
            , array('model' => $restaurant, 'id' => 'id', 'column' => 'name', 'order' => 'createtime'
                  , 'limit' => 5, 'header' => 'Newly Added', 'action' =>'menu')
          );
?>
