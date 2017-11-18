<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of NewAdditions
 *
 * @author skgupta
 */
class RecentPosts extends CWidget{  
  public $model = null;
  public function init() {
    parent::init();
  }
  //put your code here
  public function run() {
    $this->render('recentposts');
  }
}

?>
