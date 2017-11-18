<article class="grid_8">
<?php
  foreach ($this->model as $record) {
    
    $url = $this->getController()->createUrl($this->getController()->getActionUrl('viewArticle'), array('id' => $record->id));
    echo '<div class="wrapper prev-indent-bot">';
    echo '<div class="post_header"><h1>'. $record->title . '</h1></div>';
    echo '<div class="post_body"><p class="p0">'. $record->text . '</p></div>';
    echo '<div class="post_readmore"><p class="p2"><a class="button-2" href="javascript:loadPost(\''. $url . '\');">Read More</a></p></div>';
    echo '</div>';
  }
?>
</article>
