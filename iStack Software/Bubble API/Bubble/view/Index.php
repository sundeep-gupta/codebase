<?php
require_once(LIB.'/HTML/HTMLPage.php');
require_once(LIB.'/HTML/Body.php');
require_once(LIB.'/HTML/Templates/ThreePaneTemplateView.php');


class IndexView extends HTMLPage{
    protected $template_body;
    protected $html_head ;
    protected $body ;
    protected $model;
    public function __construct($model) {
	$this->model = $model;
	$index_page  = new IndexBody();
	$this->body  = new Body( array('topmargin'=>"0", 'bgcolor'=> "#666666"), $index_page);
	$this->head  = new HTMLHead();
	$this->head->add_stylesheet("ddtabmenufiles/solidblocksmenu.css");
    $this->head->add_stylesheet("css/bubble.css");
	$this->head->add_stylesheet("sdmenu/sdmenu.css");
    $this->head->add_javascript("sdmenu/sdmenu.js");
    $this->head->add_javascript("ddtabmenufiles/ddtabmenu.js");
    $this->head->add_script("var myMenu;
                          	window.onload = function() {
		myMenu = new SDMenu('my_menu');
		myMenu.init();
	};");
	$this->head->add_style("
    table {font-family: Book Antiqua; font-size: 10pt; color: #CC0000;}
    a:link {color: #394A54; text-decoration: none; }
    a:visited {color: #394A54; text-decoration: none; }
    a:hover {color: black; text-decoration: none; }
    a#side {color: white; text-decoration: underline; font-weight: bold; }
    td#side {padding-left: 20; }
    td#content {padding-left: 5; padding-right: 5; padding-top: 10; padding-bottom: 20; }"
    );

	$this->head->set_title("Bubble Inc [Realizing Dreams ... ]");
	parent::__construct();
    }

}

class IndexBody extends ThreePaneTemplateView {
    public function __construct() {

	$this->main_body = new Index();
	parent::__construct( array('header' => array('active_menu' => 'Home')),
			     array('id' =>'wrap'));
    }
}

class Index extends Div{
    function __construct($id = 'main') {
	  parent::__construct( array('id' => $id));
	  $data = $this->get_data();
      $this->add_data($data);
    }

    function get_data2() {
      $table = new HTMLTable( array('border' => 0, 'width' => '100%', 'id' => 'table5', 'cellspacing' => 1, 'background' => 'images/bkwhite.jpg' ));

      $article_table = new HTMLTable( array ('border' => 0, 'width' => '100%', 'cellspacing' => 0, 'cellpadding' => 0));
      $article_table->add_row();
      $article_table->add_column( array('height' => 16), 'Learn how to <b><a href="/display_article.php?articleid=automateftp.xml">Automate FTP using Bash Shell.....</a></b>');
      $article_table->add_row();
      $article_table->add_column(null, 'Learn how to <b><a href="/display_article.php?articleid=ssh.xml">bypass SSH password </a></b>by configuring Public &amp; Private Keys...');
      $article_table->add_row();
      $article_table->add_column(null, '<b><a href="/display_article.php?articleid=a2dp.xml">Enabling A2DP</a></b> -Working around with Bluetooth Headset on Windows Mobile...');
      $article_table->add_row();
      $article_table->add_column(null, 'Check out <b><a href="/display_article.php?articleid=xmlrpc.xml">Using XMLRPC for testing</a></b>');
      $article_table->add_row();
      $article_table->add_column(null,'<b>&nbsp; <a href="/display_article.php?articleid=ccna.xml">How CCNA Will help me??</a></b> - Read on to know about CCNA benefits...');


      $table->add_row();
      $table->add_column( array('width' => '76%', 'rowspan' => 2),$article_table );
      $table->add_column( array('width' => '22%'), '<p align="center"><img border="0" src="images/tech_f.jpg" width="130" height="99">');



      $table->add_row();
      $table->add_column(array('width' => '22%'),'<p align="center"><b><font face="Monotype Corsiva" color="#800000">TechSpace</font></b>');

      $article_table2 = new HTMLTable( array('border' => 0, 'width' => '100%', 'id' => 'table8', 'cellspacing' => 1, 'background' => 'images/bkwhite.jpg'));
      $article_table2->add_row();
      $article_table2->add_column(null, '<b><a href="/under_construction.php">Designing an automation framework </a></b> - what all to consider...');
      $article_table2->add_row();
      $article_table2->add_column(null, '<b><a href="/display_article.php?articleid=iptables.xml">IPTABLES </a></b>- How to handle them... ');
      $article_table2->add_row();
      $article_table2->add_column(null, 'Setting up Proxy <b><a href="/display_article.php?articleid=proxy.xml">to share internet across 2 or more machines...</a></b>');
      $article_table2->add_row();
      $article_table2->add_column(null, 'Setting up<b><a href="/under_construction.php">Linux box to act as L4 switch or as Load Balancer...</a></b>');
      $article_table2->add_row();
      $article_table2->add_column(null, 'How to install & configure a<b><a href="/under_construction.php"> new kernel...</a></b>');

      $article_table = new HTMLTable( array ('border' => 0, 'width' => '100%', 'cellspacing' => 0, 'cellpadding' => 0));
      $article_table->add_row();
      $article_table->add_column(array('width' => 121),'<p align="center"><font face="Monotype Corsiva" color="#800000"><b>Work Around..</b></font>');
      $article_table->add_column( array('rowspan' => 2), $article_table2);

      $article_table->add_row();
      $article_table->add_column(array('width' => 121), '<img border="0" src="images/world3.jpg" width="122" height="111">');


      $table->add_row();
      $table->add_column(array('colspan' => 2), $article_table);




      $article_table2 = new HTMLTable( array('border' => 0, 'width' => '100%', 'id' => 'table9', 'cellspacing' => 1) );
      $article_table2->add_row();
      $article_table2->add_column(null,'Around Pune: <b><a href="/display_article.php?articleid=sinhagad.xml">Sinhagad</a></b> is the right place for an Average Trek..');
      $article_table2->add_row();
      $article_table2->add_column(null,'<b><a href="/under_construction.php">Mysore: Beautiful city with lot many tourist attractions... </a></b>- Explore here..');
      $article_table2->add_row();
      $article_table2->add_column(null,'<b><a href="/display_article.php?articleid=walking.xml">Walking is a good exercise to tone your body</a></b> - Get to know its benefits...');
      $article_table2->add_row();
      $article_table2->add_column(null,'<b><a href="/display_article.php?articleid=path2success.xml">Path 2 Success!! </a></b> - Find out key to succeed in any activity...');

      $article_table = new HTMLTable( array ('border' => 0, 'width' => '100%', 'cellspacing' => 0, 'cellpadding' => 0));
      $article_table->add_row();
      $article_table->add_column(array('rowspan' => 2), $article_table2);
      $article_table->add_column(array('width' => 133), '<p align="center"><b><font face="Monotype Corsiva" color="#800000">MySpace</font></b>');
      $article_table->add_row();
      $article_table->add_column( array('width' => 133),'<p align="center"><img border="0" src="images/mysp.jpg" width="130" height="94">');

      $table->add_row();
      $table->add_column(array('colspan' => 2), $article_table);

      ##########################################



      $article_table = new HTMLTable( array('border' => 0, 'width' => '100%', 'id' => 'table11', 'cellspacing' => 1));
      $article_table->add_row();
      $article_table->add_column( array('width' => 115), '<p align="center"><font face="Monotype Corsiva" color="#800000"><b>Classifieds</b></font>');
      $article_table->add_column( array('rowspan' => 2), '');
      $article_table->add_row();
      $article_table->add_column( array('width' => 115), '<p align="center"><img border="0" src="images/classifieds2.jpg" width="130" height="94">');


      $table->add_row();
      $table->add_column( array('colspan' => 2), $article_table);




      ###############

      $article_table2 = new HTMLTable( array('border' => 0, 'width' => '100%', 'id' => 'table9', 'cellspacing' => 1) );
      $article_table2->add_row();
      $article_table2->add_column(null,'<b>&nbsp; <a href="/under_construction.php">Digital Photography</a></b>- Let your imagination come alive!!!');
      $article_table2->add_row();
      $article_table2->add_column(null,'&nbsp;<b><a href="galleries/Bubble%20Gallery/index.htm">Wallpapers</a></b>- Check out our gallery for wallpaper section...');
      $article_table2->add_row();
      $article_table2->add_column(null,'<b> <a href="/under_construction.php">Bird Watching</a></b> - Have you ever thought of these real angels on earth?');
      $article_table2->add_row();
      $article_table2->add_column(null,'<b><a href="/under_construction.php">Hit nature once in a while</a></b> to experience peace within yourself...');


      $article_table = new HTMLTable( array('border' => 0, 'width' => '100%', 'id' => 'table13', 'cellspacing' => 1));
      $article_table->add_row();
      $article_table->add_column( array('rowspan' => 2), $article_table2);
      $article_table->add_column( array('width' => 115), '<p align="center"><i><font face="Monotype Corsiva"><b>&nbsp;<font color="#800000">Gallery</font></b></font></i>');
      $article_table->add_row();
      $article_table->add_column( array('width' => 115), '<p align="center"><img border="0" src="images/butterfly.jpg" width="140" height="112">');


      $table->add_row();
      $table->add_column( array('colspan' => 2), $article_table);

      return($table);

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

        function get_data() {
          $articles = array (
                            array ( 'title' => 'Learn how to Automate FTP using Bash Shell...',
                                    'link'  => '/display_article.php?articleid=automateftp.xml',
                                    'link_text' => 'Automate FTP'),
                            array( 'title' => 'Learn how to bypass SSH password by configuring Public & Private keys...',
                                   'link_text'  => 'bypass SSH password',
                                   'link' => '/display_article.php?articleid=ssh.xml'),
                            );

          $this->add_data($this->construct_articles_div ($articles));

          $image_div = new Div(array('width' => '25%', 'style' => 'float: right;'));

          $div = new Div();
          $div->add_data('<img border="0" src="images/tech_f.jpg" width="130" height="99">');
          $image_div->add_data($div);

          $this->add_data($image_div);
          return '';

          $table = new Div( array('border' => 0, 'width' => '100%', 'id' => 'table5',  'background' => 'images/bkwhite.jpg' ));

      $article_table = new HTMLTable( array ('border' => 0, 'width' => '100%', 'cellspacing' => 0, 'cellpadding' => 0));
      $article_table->add_row();
      $article_table->add_column( array('height' => 16), 'Learn how to <b><a href="/display_article.php?articleid=automateftp.xml">Automate FTP using Bash Shell.....</a></b>');
      $article_table->add_row();
      $article_table->add_column(null, 'Learn how to <b><a href="/display_article.php?articleid=ssh.xml">bypass SSH password </a></b>by configuring Public &amp; Private Keys...');
      $article_table->add_row();
      $article_table->add_column(null, '<b><a href="/display_article.php?articleid=a2dp.xml">Enabling A2DP</a></b> -Working around with Bluetooth Headset on Windows Mobile...');
      $article_table->add_row();
      $article_table->add_column(null, 'Check out <b><a href="/display_article.php?articleid=xmlrpc.xml">Using XMLRPC for testing</a></b>');
      $article_table->add_row();
      $article_table->add_column(null,'<b>&nbsp; <a href="/display_article.php?articleid=ccna.xml">How CCNA Will help me??</a></b> - Read on to know about CCNA benefits...');




      $div1 = new Div( array('width' => '20%', 'style' => 'float: left;') );
      $div2 = new Div(); $div2->add_data('<p "><img border="0" src="images/tech_f.jpg" width="130" height="99">');
      $div1->add_data($div2);

      $div2 = new Div(); $div2->add_data('<p ><b><font face="Monotype Corsiva" color="#800000">TechSpace</font></b>');
      $div1->add_data($div2);

      $this->add_data($div1);
      $div1 = new Div( array('width' => '70%', 'style' =>'float: right;') );  $div1->add_data($article_table);
      $this->add_data( $div1 );

      return '';
      $table->add_column( array('width' => '22%','style' => 'float: right;'), '<p align="center"><img border="0" src="images/tech_f.jpg" width="130" height="99">');



      $table->add_row();
      $table->add_column(array('width' => '22%'),'<p align="center"><b><font face="Monotype Corsiva" color="#800000">TechSpace</font></b>');

      $article_table2 = new HTMLTable( array('border' => 0, 'width' => '100%', 'id' => 'table8', 'cellspacing' => 1, 'background' => 'images/bkwhite.jpg'));
      $article_table2->add_row();
      $article_table2->add_column(null, '<b><a href="/under_construction.php">Designing an automation framework </a></b> - what all to consider...');
      $article_table2->add_row();
      $article_table2->add_column(null, '<b><a href="/display_article.php?articleid=iptables.xml">IPTABLES </a></b>- How to handle them... ');
      $article_table2->add_row();
      $article_table2->add_column(null, 'Setting up Proxy <b><a href="/display_article.php?articleid=proxy.xml">to share internet across 2 or more machines...</a></b>');
      $article_table2->add_row();
      $article_table2->add_column(null, 'Setting up<b><a href="/under_construction.php">Linux box to act as L4 switch or as Load Balancer...</a></b>');
      $article_table2->add_row();
      $article_table2->add_column(null, 'How to install & configure a<b><a href="/under_construction.php"> new kernel...</a></b>');

      $article_table = new HTMLTable( array ('border' => 0, 'width' => '100%', 'cellspacing' => 0, 'cellpadding' => 0));
      $article_table->add_row();
      $article_table->add_column(array('width' => 121),'<p align="center"><font face="Monotype Corsiva" color="#800000"><b>Work Around..</b></font>');
      $article_table->add_column( array('rowspan' => 2), $article_table2);

      $article_table->add_row();
      $article_table->add_column(array('width' => 121), '<img border="0" src="images/world3.jpg" width="122" height="111">');


      $table->add_row();
      $table->add_column(array('colspan' => 2), $article_table);




      $article_table2 = new HTMLTable( array('border' => 0, 'width' => '100%', 'id' => 'table9', 'cellspacing' => 1) );
      $article_table2->add_row();
      $article_table2->add_column(null,'Around Pune: <b><a href="/display_article.php?articleid=sinhagad.xml">Sinhagad</a></b> is the right place for an Average Trek..');
      $article_table2->add_row();
      $article_table2->add_column(null,'<b><a href="/under_construction.php">Mysore: Beautiful city with lot many tourist attractions... </a></b>- Explore here..');
      $article_table2->add_row();
      $article_table2->add_column(null,'<b><a href="/display_article.php?articleid=walking.xml">Walking is a good exercise to tone your body</a></b> - Get to know its benefits...');
      $article_table2->add_row();
      $article_table2->add_column(null,'<b><a href="/display_article.php?articleid=path2success.xml">Path 2 Success!! </a></b> - Find out key to succeed in any activity...');

      $article_table = new HTMLTable( array ('border' => 0, 'width' => '100%', 'cellspacing' => 0, 'cellpadding' => 0));
      $article_table->add_row();
      $article_table->add_column(array('rowspan' => 2), $article_table2);
      $article_table->add_column(array('width' => 133), '<p align="center"><b><font face="Monotype Corsiva" color="#800000">MySpace</font></b>');
      $article_table->add_row();
      $article_table->add_column( array('width' => 133),'<p align="center"><img border="0" src="images/mysp.jpg" width="130" height="94">');

      $table->add_row();
      $table->add_column(array('colspan' => 2), $article_table);

      ##########################################



      $article_table = new HTMLTable( array('border' => 0, 'width' => '100%', 'id' => 'table11', 'cellspacing' => 1));
      $article_table->add_row();
      $article_table->add_column( array('width' => 115), '<p align="center"><font face="Monotype Corsiva" color="#800000"><b>Classifieds</b></font>');
      $article_table->add_column( array('rowspan' => 2), '');
      $article_table->add_row();
      $article_table->add_column( array('width' => 115), '<p align="center"><img border="0" src="images/classifieds2.jpg" width="130" height="94">');


      $table->add_row();
      $table->add_column( array('colspan' => 2), $article_table);




      ###############

      $article_table2 = new HTMLTable( array('border' => 0, 'width' => '100%', 'id' => 'table9', 'cellspacing' => 1) );
      $article_table2->add_row();
      $article_table2->add_column(null,'<b>&nbsp; <a href="/under_construction.php">Digital Photography</a></b>- Let your imagination come alive!!!');
      $article_table2->add_row();
      $article_table2->add_column(null,'&nbsp;<b><a href="galleries/Bubble%20Gallery/index.htm">Wallpapers</a></b>- Check out our gallery for wallpaper section...');
      $article_table2->add_row();
      $article_table2->add_column(null,'<b> <a href="/under_construction.php">Bird Watching</a></b> - Have you ever thought of these real angels on earth?');
      $article_table2->add_row();
      $article_table2->add_column(null,'<b><a href="/under_construction.php">Hit nature once in a while</a></b> to experience peace within yourself...');


      $article_table = new HTMLTable( array('border' => 0, 'width' => '100%', 'id' => 'table13', 'cellspacing' => 1));
      $article_table->add_row();
      $article_table->add_column( array('rowspan' => 2), $article_table2);
      $article_table->add_column( array('width' => 115), '<p align="center"><i><font face="Monotype Corsiva"><b>&nbsp;<font color="#800000">Gallery</font></b></font></i>');
      $article_table->add_row();
      $article_table->add_column( array('width' => 115), '<p align="center"><img border="0" src="images/butterfly.jpg" width="140" height="112">');


      $table->add_row();
      $table->add_column( array('colspan' => 2), $article_table);

      return($table);

    }

}
?>
