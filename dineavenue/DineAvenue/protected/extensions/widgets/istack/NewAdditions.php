<?php
/**
 * Description of NewAdditions
 *
 * @author skgupta
 */
class NewAdditions extends CWidget{  
  public $model = null;
  public $header = '+ Recently Added';
  public $column = null;
  public $limit = 5;
  public $id = 'ID';
  public $order = null;
  public $action = null;
  public function init() {
    parent::init();
  }
  //put your code here
  public function run() {
    $dbCriteria = new CDbCriteria(array('order' => $this->order, 'limit' => $this->limit));
    $this->model->setDbCriteria( $dbCriteria);            
    $data = $this->model->findAll();
    $this->render('newadditions', array('data' => $data));
  }
}

?>
