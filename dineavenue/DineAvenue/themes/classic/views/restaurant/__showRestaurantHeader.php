<header>
  <div class="tab_containermenu">
    <div id="tab1" class="tab_content">
      <div class="main">
        <div class="wrapper">
          <div id="restaurant-coupon" class="img-indent-r">Loading... </div>
          <div class="extra-wrap">
            <div class="indent">
              <div class="indent_RestSlider">
                <div id="restaurant-album">Loading...</div>
              </div>
              <div class="indent_RestContent">
                <div class="indent_RestTitle"><?php echo $restaurant->name; ?></div>
                <div class="indent_RestIcons">
                  <?php
                    echo CHtml::image(Yii::app()->theme->baseUrl.'/images/restaurant/DELIVERY.png');
                    echo CHtml::image(Yii::app()->theme->baseUrl.'/images/restaurant/DINING.png');
                    echo CHtml::image(Yii::app()->theme->baseUrl.'/images/restaurant/VEGETARIAN.png');
                  ?>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</header>