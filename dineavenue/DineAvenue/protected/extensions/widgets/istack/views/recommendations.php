<?php
  foreach ($this->dataProvider as $ar_article) {
    echo '<div>';
    echo '<p class="p0">'. $ar_article->title . '</p>';
    echo '<p class="p0">'. $ar_article->text . '</p>';
    
    echo '<p class="p2"><a class="button-2" href="/">URL here</a></p>';
    echo '</div>';
  }
?>
<!--
<article >
  <div>
  <h6 class="p0">Chef Razikh - Tawa Curry</h6>
  <p class="p0">Handling a Tawa isnt easy task. Especially if you are sleepy</p>
  <p class="p2">
    <a class="button-2"  href="./Welcome to Dine Avenue_files/Welcome to Dine Avenue.html">Read More</a>
  </p>
  </div>
  <h6 class="p0">Help Me Lose Weight Fast</h6>
  <p class="p0">Not eating for 15 days in a stretch have many benefits </p>
  <p class="p2">
    <a class="button-2"  href="./Welcome to Dine Avenue_files/Welcome to Dine Avenue.html">Read More</a>
  </p>
  -->
