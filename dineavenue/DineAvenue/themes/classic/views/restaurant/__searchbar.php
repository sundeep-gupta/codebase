<?php
  $title = 'Search results for : ';
  if (isset($ra_search_item)) {
    foreach ($ra_search_item as $ar_cusine) {
      $title .= $ar_cusine->name;
    }
  }
  if (isset($ra_search_locations)) {
   foreach ($ra_search_locations as $ar_location) {
     $title .= ", ". $ar_location->name;
    }
  }
?>
<header>
  <div class="tab_containersl">
    <div id="tab1" class="tab_content">
      <div class="main">
        <div class="wrapper">
          <div class="img-indent-r">
            <h6 class="title3">Sponsored listing goes here</h6>
          </div>
          <div class="extra-wrap">
            <div class="indent">
              <strong class="title3"><?php echo $title; ?></strong>
             <h5 class="title3">
               <a id="reset" class="button-2" href="<?php echo $this->createUrl('/');?>">Reset</a>
              </h5>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</header>
