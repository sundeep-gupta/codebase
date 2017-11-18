<?php
$this->widget('ext.widgets.istack.RecentPosts'
          , array('model' => Article::model()->findAllRecentPosts()));
?>
