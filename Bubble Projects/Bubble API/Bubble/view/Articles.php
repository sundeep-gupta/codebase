<?php
require_once(LIB.'/HTML/HTMLPage.php');
require_once(LIB.'/HTML/Body.php');
require_once(LIB.'/HTML/Templates/ThreePaneTemplateView.php');

#require_once(VIEW.'/HTML/BubbleHead.php');

class ArticlesView extends HTMLPage{
    protected $template_body;
    protected $html_head ;
    protected $body ;
    protected $model;
    public function __construct($model) {
	$this->model = $model;
	$articles_page  = new ArticlesBody();
	$this->body  = new Body( array('topmargin'=>"0", 'bgcolor'=> "#666666"), $articles_page);
    $this->head  = new BubbleHead();
    echo $this->head->get_html_text();
	$this->head->set_title("Articles - Bubble Inc [Realizing Dreams ... ]");
	parent::__construct();
    }

}

class ArticlesBody extends ThreePaneTemplateView {
    public function __construct() {

	$this->main_body = new Articles();
	parent::__construct( array('header' => array('active_menu' => 'Home')),
			     array('id' =>'wrap'));
    }
}

class Articles extends Div{
    function __construct($id = 'main') {
	  parent::__construct( array('id' => $id));
	  $data = $this->get_articles();
      $this->add_data($data);
    }


    function construct_articles_div($articles = array()) {
      $articles_div = new Div(array('width' => '70%', 'style' => 'float: left;'));

      foreach ($articles as $article) {
         $div = new Div();
         # TODO: handle negetive conditions ... if regex does not match.
         $article_text = ereg_replace( $article['link_text'], '<b><a href="'.$article['link'].'">'.$article['link_text'].'</a></b>', $article['title']);
         $div->add_data($article_text);
         $articles_div->add_data($div);
      }
      return $articles_div;
    }

    function get_articles() {
      $articles = array (
                        array ( 'title' => 'Learn how to Automate FTP using Bash Shell...',
                                'link'  => '/display_article.php?articleid=automateftp.xml',
                                'link_text' => 'Automate FTP'),
                        array( 'title' => 'Learn how to bypass SSH password by configuring Public & Private keys...',
                               'link_text'  => 'bypass SSH password',
                               'link' => '/display_article.php?articleid=ssh.xml'),
                        );

      return $this->construct_articles_div ($articles);


    }

}
?>
