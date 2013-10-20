<?php
require_once(LIB.'/HTML/HTMLTable.php');

class RightBar extends Div {
    public function __construct($id = 'rightbar') {
	parent::__construct( array('id'=> $id));
	$data = '<h1>News Updates</h1>


                    <!--[if IE]>

<IE:Download ID="marqueedata" STYLE="behavior:url(#default#download)" />
<marquee id="externalmarquee" direction=up scrollAmount=4 style="width:100 px;height:150px;border:0px solid black;padding:3px" onMouseover="this.scrollAmount=2" onMouseout="this.scrollAmount=4" src="update.html">
</marquee>


<script language="JavaScript1.2">

function downloaddata(){
marqueedata.startDownload(externalmarquee.src,displaydata)
}

function displaydata(data){
externalmarquee.innerHTML=data
}

if (document.all)
window.onload=downloaddata


</script>

<![endif]-->

			';
	$this->add_data($data);
    }
}
class LeftBar extends Div {
  private $menu =      array ('E-Books' => 'controller.php?action=EBook',
                   'E-Greetings' => 'controller.php?action=EGreetings',
                   'Celebrate' => 'controller.php?action=Celebrate',
                   'Contact'   => 'controller.php?action=Contact',
                   );
  public function __construct($id = 'leftbar') {
    parent::__construct( array('id' => $id) );


   	foreach ($this->menu as $name=>$url) {
        $item_div = new Div(array('id' => 'lmenu_item'));
        $item_div->add_data('<a href="'.$url.'">'.$name.'</a>');
        $this->add_data($item_div);
    }

    $table = new HTMLTable( array('border' => 0, 'width' => '100%', 'cellspacing' => 0, 'cellpadding' => 0 ) );
    $table->add_row();
    $table->add_column(array('width' =>'100%', 'bgcolor' => '#E7E4E4', 'background' => 'images/leftbk4.jpg'), "&nbsp");
    $table->add_row();

    $table->add_column(array('width' => '100%', 'height' => 1, 'bgcolor' => '#477417'),
                       '<img border="0" src="images/bar.jpg" width="144" height="1"></img>');
    $table->add_row();
    $table->add_column( array('width'=> "144",    'bgcolor'=>"#477417"),
                        '<a href="/ebook.php">E-Books</a>');

    $table->add_row();
    $table->add_column(array('width' => '100%', 'height' => 1, 'bgcolor' => '#477417'),
                       '<img border="0" src="images/bar.jpg" width="144" height="1"></img>');
    $table->add_row();
    $table->add_column( array('width'=> "144",  'height'=>"1",  'bgcolor'=>"#477417"),
                        '<a href="/egreeting.php"><img border="0" src="images/egreetings.jpg" width="144" height="20"></a>');

    $table->add_row();
    $table->add_column(array('width' => '100%', 'height' => 1, 'bgcolor' => '#477417'),
                       '<img border="0" src="images/bar.jpg" width="144" height="2">');
    $table->add_row();
    $table->add_column( array('width'=> "144",  'height'=>"1",  'bgcolor'=>"#477417"),
                        '<a href="/ebook.php"><img border="0" src="images/celebrate.jpg" width="144" height="20"></a>');


    $table->add_row();
    $table->add_column(array('width' => '100%', 'height' => 1, 'bgcolor' => '#477417'),
                       '<img border="0" src="images/bar.jpg" width="144" height="2">');
    $table->add_row();
    $table->add_column( array('width'=> "144",  'height'=>"1",  'bgcolor'=>"#477417"),
                        '<a href="/ebook.php"><img border="0" src="images/contact.jpg" width="144" height="20"></a>');


#    $this->add_data($table);
  }
}
?>