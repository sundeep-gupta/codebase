<?php
/**
 * Description of X2MapSearch
 *
 * @author skgupta
 */
class X2MapSearch extends CWidget {
  public $model = null;
  public $title = null;
  public function init() {
    parent::init();
  }
  //put your code here
  public function run() {
    
    //print_r($this->model->findAll()); 
  
    
    $this->render('mapsearch');
  }
}

?>
