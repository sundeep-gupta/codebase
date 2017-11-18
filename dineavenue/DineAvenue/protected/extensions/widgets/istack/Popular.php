<?php
/**
 * Description of X2MapSearch
 *
 * @author skgupta
 */
class Popular extends CWidget {
  protected $model = null;
  public function init() {
    parent::init();
  }
  //put your code here
  public function run() {

    $this->render('popular');
  }
}

?>
