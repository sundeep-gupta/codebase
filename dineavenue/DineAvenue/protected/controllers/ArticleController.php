<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of ArticleController
 *
 * @author skgupta
 */
class ArticleController extends DAController {
  public function actionRecent() {
    $this->renderPartial('recentposts');
  }
  
  public function actionRecentComments() {
    $this->renderPartial('recentComments');
  }
  
  public function actionPopular() {
    $this->renderPartial('popular');
  }
  
  public function actionRecommended() {
    $ra_articles = Article::model()->findAll('published = true');
    $this->renderPartial('recommendations', array('ra_articles' => $ra_articles));
  /* TODO : Call using DataProvider instead of array 
  $dp_articles = new CArrayDataProvider($ra_articles, array('id' => 'id'
      , 'sort' => array(
          'attributes' => array('createtime', 'visits')
          )));
   * 
   */
  }
  
  public function actionView($id) {
    $this->renderPartial('_view',array(
			'data'=>$this->loadArticleModel($id),
		));
  }
}

?>
