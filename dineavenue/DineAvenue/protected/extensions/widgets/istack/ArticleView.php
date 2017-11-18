<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of ArticleView
 *
 * @author skgupta
 */
class ArticleView extends CWidget {
  public $dataProvider = null;
  public $limit = 150;
  public $column = null;
  public $limit = 5;
  public $id = 'id';
  public $cssFile = null;
  public function init() {
    parent::init();
  }
  //put your code here
  public function run() {
    $this->render('showarticle');
  }
  
}

?>
