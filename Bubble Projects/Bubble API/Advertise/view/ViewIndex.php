<?
require (LIB.'/Bubble/HTML/ThreePaneHTMLOutput.php');
require (LIB.'/Bubble/HTML/HTMLHead.php');
require (LIB.'/Bubble/HTML/PageHeader.php');
require (LIB.'/Bubble/HTML/HTMLTable.php');

class ViewIndex {
    protected $model;
    protected $result;
    public function  __construct($model, $result) {
	$this->model = $model;
	$this->result = $result;
    }
    
    public function display() {
	$myDB = db_connect();
	checkUser('', ''); 
	$page = new ThreePaneHTMLOutput();
	
	$head = new HTMLHead();
	$head->set_title('Bubble Classifieds');
	$head->add_stylesheet("ddtabmenufiles/solidblocksmenu.css");
	$head->add_stylesheet("ddtabmenufiles/sdmenu.css");
	$head->add_javascript("ddtabmenufiles/ddtabmenu.js");
	$head->add_javascript("sdmenu/sdmenu.js");

	$head->add_style( "table {font-family: Book Antiqua; font-size: 10pt; color: #CC0000;}\n
        a:link {color: #394A54; text-decoration: none; }\n
        a:visited {color: #394A54; text-decoration: none; }\n
        a:hover {color: black; text-decoration: none; }\n
        a#side {color: white; text-decoration: underline; font-weight: bold; }\n
        td#side {padding-left: 20; }\n
        td#content {padding-left: 5; padding-right: 5; padding-top: 10; padding-bottom: 20; }\n");

	$head->add_script( "ddtabmenu.definemenu('ddtabs3', 1) //initialize Tab Menu #3 with 2nd tab selected
	var myMenu;\n
	window.onload = function() {\n
		myMenu = new SDMenu('my_menu');\n
		myMenu.init();\n
	};\n");
	

	$top = new HTMlTable( array('border' => '0',
				    'width'  => '800',
				    'id'     => 'table1',
				    'cellspacing' => '0',
				    'cellpadding' => '0',
				    'bgcolor'     => '#FFFFFF',
				    'background' => 'images/bkwhite.jpg'));
	$top->add_row();
	$top->add_column(  array('valign' => 'top'),
			  '<IMG SRC="images/title4.jpg" WIDTH="800"  HEIGHT="120" BORDER="0">');


	$top_menu = new HTMLTable( array('cellpadding' => '0', 'cellspacing' => '0', 'border' => '0', 'width' => '800'));
	$top_menu->add_row();


        $menu_table = new HTMLTable(array('border' => '0', 'width' => '100%', 'id' => 'table2' , 
					  'cellspacing' => '0', 'cellpadding' => '0'));
	$menu_table->add_row();
	$menu_table->add_column( array('width'=>'70%'),
				 '<div id="ddtabs3" class="solidblockmenu" width="70%">
                    <ul>
                    <li><a href="/advertise/index.php" rel="sc1">Classifieds Home</a></li>
                    <li><a href="/advertise/register.php" rel="sc2">Register</a></li>
                    <li><a href="/advertise/select_to_add.php" rel="sc3">List Item</a></li>
                    <li><a href="/advertise/edit.php">Edit Item</a></li>
                    <li><a href="/advertise/search.php">Search</a></li>

                    </ul>
                </div>				 ');

	$top_menu->add_column( array('width' => '100%', 'colspan' => '2'), $menu_table);	


#
# Now Make the Left Menu, Center pane go OO
#

#	$main_body = new HTMLTable( array('cellpadding' => '0', 'cellspacing' => '0', 'border' => '0', 'width' => '800',
#					  'height' => '600', 'background' => cnfg('deDir').'images/leftbk4.jpg'));
#	$main_body->add_row();
#	$main_body->add_column();

#	$main_body = new HTMLTable( array('cellpadding' => '10', 'cellspacing' => '0' , ' border' => '0' , 'width' = '100%'));
#	$main_body->add_row();
#	$main_body->add_column(array('valign' => 'top', 'width' => '100%'),  $this->doMain());

#	$cont = new HTMLTable( array('cellpadding' => '10', 'cellspacing' => '0' , ' border' => '0' , 'width' = '100%'));
#	$cont->add_row();
#	$cont->add_column( array('valign' => 'top', 'width' => '100%'),  $this->doMain());

	$num_cols        = cnfg('mainCatsCols');
	$col_buffer_size = cnfg('mainCatsBufferCols');
	$td_width        = cnfg('mainCatsTdWidth');
	$table_width     = cnfg('mainCatsTableWidth');
	$table_pad       = cnfg('mainCatsTablePad');
	$table_spc       = cnfg('mainCatsTableSpace');
	$centered_or_not = cnfg('mainCatsCenter');
	$query           = 'SELECT cat_name, cat_id
                        FROM std_categories 
                        WHERE parent_id=0 
                        ORDER BY cat_name ASC' ;
	$result          = mysql_query($query, $myDB);
	$countCols       = 1;
	$num_cols        = $num_cols+($num_cols-1);

        #
        # Table for Left Menu
        #
	$left_menu = new HTMLTable( array('width' => $table_width, 'cellpadding' => $table_pad, 'cellspacing' => $table_spc));
	$result    = array();
	array_push($result, array('cat_id'=> 1, 'cat_name' => 'Bubble'));
	foreach ($result as $row) {
	    $left_menu->add_row();
#	    $left_menu->add_column( array('valign' => 'top' , 'width' => cnfg('mainCatsBufferCols'),),
#				    '<img src="'. cnfg('deDir').'images/leftbk4.jpg" 
#                     border="0" width="50" height="1">');
	    $left_menu->add_column(  array('valign' => 'top', 'width' => $td_width, 'background' => cnfg('deDir').'images/leftbk4.jpg'),
				     '<a href="'. cnfg('deDir') .'showCat.php?cat_id='. $row['cat_id'].'">'.
				     '<b>'. $row['cat_name'].'</b></a>');
	    $left_menu->add_row();
	    $left_menu->add_column( array('width' => '100%', 'height' => '1', 'bgcolor' => '#E7E4E4'),
				    '<img border="0" src="'. cnfg('deDir').'images/bar.jpg'.'" width="144" height="2">');
	}
	
	$footer = new HTMLTable( array('width'=>'800', 'cellspacing' => '0', 'border' => '0'));
	$footer->add_row();
	$footer->add_column( array('width' => '100%', 'background' => 'images/bkgrnd2.jpg', 'colspan' => '3', 
				   'bgcolor' => '#000000', 'align' => 'center'),
			     '|<a href="/galleries/Bubble%20Gallery/index.htm">Gallery</a> 
                |<a href="/cgi-bin/bubbleforum/YaBB.pl">Forum </a>|
                <a href="/ebook.php">E-Book</a> |
                <a href="/myspace.php">My Space</a> |
                <a href="/advertise/index.php">Advertise</a> <b>|</b>
                <a href="/contact.php">Contact us </a>');

	$footer->add_row();
	$footer->add_column( array('width' => '100%', 'background' => 'images/bkgrnd2.jpg','align' => 'center'));

	$footer->add_row();
	$footer->add_column(array('width' => '100%', 'background' => 'images/bkgrnd2.jpg','align' => 'center'),
			    '<IMG SRC="http://www.bubble.co.in/cgi-bin/counter.cgi?3&w">
                <IMG SRC="http://www.bubble.co.in/cgi-bin/counter.cgi?2">
                <IMG SRC="http://www.bubble.co.in/cgi-bin/counter.cgi?1">
                <IMG SRC="http://www.bubble.co.in/cgi-bin/counter.cgi?0">');

	$footer->add_row();
	$footer->add_column( array('width' => '100%', 'background' => 'images/bkgrnd2.jpg','align' => 'center'));

	$footer->add_row();
    	$footer->add_column( array('width' => '100%', 'colspan' => '2', 'height' => '10',
				   'bgcolor' => '#003300','align' => 'center'),
			     '<font size="1" color="white"> © 2007, Bubble Inc.,</font>' );

	$footer->get_html_text();


?>
<HTML>
     <?php echo $head->get_html_text(); ?>
<BODY topmargin="0" bgcolor="#666666" LEFTMARGIN="0" >
<div align="center">

     <?php 
        echo $top->get_html_text(); 
	echo $top_menu->get_html_text();
#main_header(); 
#top_nav(); 
	?>
    
    <TABLE CELLPADDING="0" CELLSPACING="0" BORDER="0"
            WIDTH="800" HEIGHT="600"
            background ="<?php echo cnfg('deDir') ?>images/leftbk4.jpg">
    <TR>
        <TD valign="top" width="18%" >
   
	 <?php echo $left_menu->get_html_text(); ?>
        </TD>
        <TD valign="top" width="65%" BGCOLOR="#FFFFFF"
        background="<?php echo cnfg('deDir'); ?>images/bkgrnd2.jpg">

<?php

#	      echo $content->get_html_text();

#	$cont = new HTMLTable( array('cellpadding' => '10', 'cellspacing' => '0' , ' border' => '0' , 'width' = '100%'));
#	$cont->add_row();
#	$cont->add_column( array('valign' => 'top', 'width' => '100%'),  $this->doMain());
	
?>

             <table cellpadding="10" cellspacing="0" border="0" width="100%">
                <tr><td valign="top" width="100%">
		  <?php #content($content); 
	echo $this->doMain();
	    ?>
             </td></tr></table>

        </TD>

       <TD valign="top" width="18%" background="<?echo cnfg('deDir');?>images/bkgrnd2.jpg">
            <?php log_in_form_and_status(); ?>
        </TD>
    </TR>
    <tr>
	      <?php echo 	$footer->get_html_text(); ?>
     </tr>
</TABLE>
</div>
</BODY>
</HTML>

<?php	
	      db_disconnect($myDB);
    }


    function doMain(){
	
        $txt = ' <!-- Put your html content BELOW here -->
      Welcome to the home page.  Welcome to the home page.  
      Welcome to the home page.  Welcome to the home page.  
      Welcome to the home page.  Welcome to the home page.  
      Welcome to the home page.  Welcome to the home page.  
      Welcome to the home page.  Welcome to the home page.  
      Welcome to the home page.  Welcome to the home page.  
      Welcome to the home page.  Welcome to the home page.  
      Welcome to the home page.  Welcome to the home page.  
      <!-- Put your html content ABOVE here -->';
	return $txt;

      
      } // end function doMain()
    

    function display_cats_main() {
	
	GLOBAL $myDB ;
	
	$num_cols        = cnfg('mainCatsCols');
	$col_buffer_size = cnfg('mainCatsBufferCols');
	$td_width        = cnfg('mainCatsTdWidth');
	$table_width     = cnfg('mainCatsTableWidth');
	$table_pad       = cnfg('mainCatsTablePad');
	$table_spc       = cnfg('mainCatsTableSpace');
	$centered_or_not = cnfg('mainCatsCenter');
	$query           = 'SELECT cat_name, cat_id
                        FROM std_categories 
                        WHERE parent_id=0 
                        ORDER BY cat_name ASC' ;
	$result          = mysql_query($query, $myDB);
	$countCols       = 1;
	$num_cols        = $num_cols+($num_cols-1);

        #
        # Table for Left Menu
        #
	$left_menu = new HTMLTable( array('width' => $table_width, 'cellpadding' => $table_pad, 'cellspacing' => $table_spc));
	$result = array();
	foreach ($result as $res) {
	    $left_menu->add_row();
#	    $left_menu->add_column( array('valign' => 'top' , 'width' => cnfg('mainCatsBufferCols'),),
#				    '<img src="'. cnfg('deDir').'images/leftbk4.jpg" 
#                     border="0" width="50" height="1">');
	    $left_menu->add_column(  array('valign' => 'top', 'width' => $td_width, 'background' => cnfg('deDir').'images/leftbk4.jpg'),
				     '<a href="'. cnfg('deDir') .'showCat.php?cat_id='. $row['cat_id'].'">'.
				     '<b>'. $row['cat_name'].'</b></a>');
	    $left_menu->add_column( array('width' => '100%', 'height' => '1', 'bgcolor' => '#E7E4E4'),
				    '<img border="0" src="'. cnfg('deDir').'images/bar.jpg'.'" width="144" height="2">');
	}

        $left_menu->get_html_text();
    }	

}

?>