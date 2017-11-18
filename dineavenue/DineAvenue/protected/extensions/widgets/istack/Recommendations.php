<?php
/**
 * Description of X2MapSearch
 *
 * @author skgupta
 */
class Recommendations extends CWidget {
  protected $model = null;
  public $dataProvider = null;
  public function init() {
    parent::init();
  }
  //put your code here
  public function run() {

    $this->render('recommendations');
  }
}

?>
