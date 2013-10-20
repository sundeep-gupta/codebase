<?php

/**************************************
 * File Name: func_common.php         *
 * ---------                          *
 *                                    *
 **************************************/

require_once(path_cnfg('pathToLibDir').'func_tree.php') ;

/*
 * Connects to the database using the
 * dbHost, dbUser, dbPass config variables (in cnfg file)
 * INPUT: None
 * OUTPUT: true if database is selected / logged in properly
 *         false otherwise
 */
function db_connect() {
    $myDB = mysql_connect(cnfg('dbHost'), cnfg('dbUser'), cnfg('dbPass') );

    if ($myDB && mysql_select_db(cnfg('dbName') ) ) {
        return $myDB;
    } else {
        echo mysql_error();
        return false;
    }
}

/*
 * Disconnects the database connection
 * INPUT: the database link which need to be disconnected.
 */
function db_disconnect(&$db_link) {
    if ($db_link) {
        mysql_close($db_link) ;
    }
}

/*
 * content is the tricky function used here
 * to print the content on the page
 * It takes an array containing the list of functions & calls them
 * It's these functions that print the desired content 
 * INPUT: an array containing the list of the functions
 * OUTPUT: none
 */
function content(&$content) {
    GLOBAL $gbl;
    for ($i=0; $i<count($content); $i++) {
        eval($content[$i]);
    }
} 

/*
 * logIn creates the cookie if the valid username & password
 * are specified.
 * INPUT: username & password
 * OUTPUT: true if cookie is successfully created
 *         false otherwise
 * log_in_cookie is set with username & cookie id.
 */
function logIn($user_name, $password) {
    GLOBAL $myDB ;

    srand((double)microtime()*1000000);

    $the_rand  = rand(1, 10000);
    $the_rand2 = rand(1, 10000);
    $the_rand3 = rand(1, 10000);
    $the_rand  = ''.$the_rand.''.$the_rand2.''.$the_rand3;

    $query = "UPDATE std_users SET cookie_id='$the_rand' 
              WHERE user_name='$user_name' AND password='$password' " ; 

    $result = mysql_query($query,$myDB) ;

    if ( mysql_affected_rows($myDB)==1 ) {
        setcookie('log_in_cookie[user]', $user_name); 
        setcookie('log_in_cookie[id]', $the_rand);
        return true;
    } else {
        return false;
    } 
} 


/*
 * This function is used to display the top menu 
 */
function top_nav()  {
    GLOBAL $gbl;
?>
    <TABLE CELLPADDING="0" CELLSPACING="0" BORDER="0" WIDTH="800"  >
    <tr>
    <td width="100%" colspan="2">
        <table border="0" width="100%" id="table2" cellspacing="0" cellpadding="0">
            <tr>
            <td width="70%">
                <div id="ddtabs3" class="solidblockmenu" width="70%">
                    <ul>
                    <li><a href="<?php echo cnfg('deDir') ?>index.php" rel="sc1">Classifieds Home</a></li>
                    <li><a href="<?php echo cnfg('deDir') ?>register.php" rel="sc2">Register</a></li>
                    <li><a href="<?php echo cnfg('deDir') ?>select_to_add.php" rel="sc3">List Item</a></li>
                    <li><a href="<?php echo cnfg('deDir') ?>edit.php">Edit Item</a></li>
                    <li><a href="<?php echo cnfg('deDir') ?>search.php">Search</a></li>
                    </ul>
                </div>
            </td>
<?php
    if ($gbl["loggedIn"] == true) {
?>
            <td>
            <div id="ddtabs3" align="right" class="solidblockmenu" width="30%">
                    <ul>
                    <li><a href="">Welcome <?php echo $gbl["user_name"]; ?></a></li>
                    <li><a href="<?php echo cnfg('deDir'); ?>log_out.php">Log out</a></li>
                    </ul>
                </div>
            </td>
<?php
    }
?>            
            </tr>
        </table>
    </td>
    </tr>
    </TABLE>
    <?php 
} 


/*
 * Displays the main categories pane.
 * This is displayed in the left side of the page.
 * INPUT: none
 * OUTPUT: None
 */
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
    
    if ($centered_or_not) {
        echo '<CENTER>' ; 
    }
?>
    <table width="<?php echo $table_width;?>"
            cellpadding="<?php echo $table_pad;?>" cellspacing="<?php echo $table_spc; ?>">
<?php            
    for ($i=0; $i<mysql_num_rows($result); $i++  ) { 
        if  ($countCols==1 ) {
?>            
        <tr>
<?php
        }
        if ( $countCols % 2 == 0 ) {
?>            
            <td valign=top width="<?php echo cnfg('mainCatsBufferCols'); ?>">
                <img src="<?php echo cnfg('deDir'); ?>images/leftbk4.jpg" 
                     border="0" width="50" height="1">
            </td>
<?php            
            $i-- ; // no data used from $result array, so decrement the iterator.
        } else {
            $num_ads = 0;
            $row     = mysql_fetch_array($result) ;     
            get_num_ads($row["cat_id"], true, $num_ads); 
?>         
            <td valign="top" width="<?php echo $td_width; ?>"
                background ="<?php echo cnfg('deDir'); ?>images/leftbk4.jpg">
                <a href="<?php echo cnfg('deDir'); ?>showCat.php?cat_id=<?php echo $row['cat_id']; ?>"><b><?php echo $row['cat_name']; ?></b></a><!--&nbsp;(<?php #echo $num_ads; ?>) -->
            </td>
<?php
        }
        if ($countCols==$num_cols || $i==mysql_num_rows($result)-1 ) {
            $countCols=1;
?>            
            </tr><tr>
            <td width="100%" height="1" bgcolor="#E7E4E4">
                <img border="0" src="<?php echo cnfg('deDir')?>images/bar.jpg" width="144" height="2"></td>
            </tr>
<?php        
        } else {
            $countCols++ ; 
        }
    } // end while
?>    
    </table>
<?php 
    if ($centered_or_not) {
        echo '</CENTER>' ; 
    }
} 


/*
 * TODO: Need to find whre it is getting called
 * Queries the std-categories table with parent-id 0
 * Then displays the main categories (coz parent is 0)
 * Display format is very very similar to the above method ....
 */
function leftNav() {
    
    GLOBAL $gbl, $myDB ;
    $query = "SELECT cat_name,cat_id
              FROM std_categories
              WHERE parent_id=0
              ORDER BY cat_name ASC" ;

    $result = mysql_query($query, $myDB);
    if (!$result) {
        echo 'query - '.mysql_error().'<BR>' ; 
    }
?>
    <table cellpadding="0" cellspacing="0" border="0" width="100%">
    <tr>
        <td valign="top" bgcolor="#000099" width="100%">
        <CENTER>
        <font class="mainCat" color="#ffffff" face="Arial">
            Categories
        </font>
        </CENTER>
        </td>
    </tr>
    </table>
    <table cellpadding="0" cellspacing="0" border="0" width="100%">
    <tr>
        <td valign="top" width="5">&nbsp;</td>
        <td valign="top">
            <table cellpadding="0" cellspacing="0" border="0" width="100%">
            <tr>
                <td valign="top">
<?php
    while ( $row = mysql_fetch_array($result) ) {
        $num_ads = 0;
        get_num_ads($row["cat_id"], true, $num_ads);
?>
                <tr>
                <td valign="top" width="100%">
                    <a href="<?php echo cnfg('deDir')?>showCat.php?cat_id=<?php echo $row['cat_id']?>">
                        <?php echo $row['cat_name'] ?>
                        <FONT CLASS="user">(<?php echo $num_ads; ?>)</FONT> 
                    </a>
                </td>
                </tr>
<?php
    }
?>
                </td>
            </tr>
            </table>
         </td>
    </tr>
    </table>
<?php
} // end function leftNav()


/*
 * Function to print the css & javascript part of the header to the
 * html output
 */
function main_css() {
    ?>

    <script type="text/javascript" src="/ddtabmenufiles/ddtabmenu.js"> </script>
    <link rel="stylesheet" type="text/css" href="/ddtabmenufiles/solidblocksmenu.css" />
    <script type="text/javascript">
	ddtabmenu.definemenu("ddtabs3", 1) //initialize Tab Menu #3 with 2nd tab selected
    </script>
    <link rel="stylesheet" type="text/css" href="/sdmenu/sdmenu.css" />
	<script type="text/javascript" src="/sdmenu/sdmenu.js"/>
	<script type="text/javascript">
	// <![CDATA[
	var myMenu;
	window.onload = function() {
		myMenu = new SDMenu("my_menu");
		myMenu.init();
	};
	</script>
    <style type="text/css">
        table {font-family: Book Antiqua; font-size: 10pt; color: #CC0000;}
        a:link {color: #394A54; text-decoration: none; }
        a:visited {color: #394A54; text-decoration: none; }
        a:hover {color: black; text-decoration: none; }
        a#side {color: white; text-decoration: underline; font-weight: bold; }
        td#side {padding-left: 20; }
        td#content {padding-left: 5; padding-right: 5; padding-top: 10; padding-bottom: 20; }
    </style>
    <link rel="stylesheet" type="text/css" href="sddm.css" />
  <?php
} 


/*
 * This function checks if the user is logged in or not
 * displays login form on the right pane if not logged in
 * else displays welcome message for the user who logged in.
 */
function log_in_form_and_status() {
    GLOBAL $gbl ;
    if ($gbl["loggedIn"] == true) {
        log_in_status(); 
    } else {
        log_in_form();
    }
}

/*
 * Log in form  displayed in the right side of the form
 * if the user is not logged in.
 */
function log_in_form() {
    
    $captionFntClr = cnfg('logInFormCaptionFontColor') ;
    $caption       = cnfg('logInFormCaption');
    $captionBg     = cnfg('logInFormCaptionBgColor');
    $formWidth     = cnfg('logInFormWidth');
    $formBgClr     = cnfg('logInFormBgColor');

    ?>
    
    <table CELLPADDING="0" CELLSPACING="0" BORDER="0"
            background="<?php echo cnfg('deDir'); ?>images/bkgrnd2.jpg" 
    WIDTH="<?php echo $formWidth; ?>" >
    <tr>
        <td valign="top"  width="100%" background="<?php echo cnfg('deDir'); ?>images/leftbk4.jpg">
            <CENTER>
                <b>
                <?php echo $caption; ?>
                </b>
            </CENTER>
        </td>
    </tr>
    <tr>
        <td valign="top">
            <FORM ACTION="<?php echo cnfg('deDir') ?>log_in.php" METHOD="POST">
            <table CELLPADDING="1" CELLSPACING="1" BORDER="0" WIDTH="<?php echo $formWidth; ?>"
            background="<?php echo cnfg('deDir'); ?>images/bkgrnd2.jpg" >
            <tr>
                <td valign="top" align="right">
                    User:
                </td>
                <td valign="top">
                   <INPUT TYPE="TEXT" SIZE=10 NAME="user_name" style="font-size: 8pt;">
                </td>
            </tr>
            <tr>
                <td valign="top" align="right">
                <FONT CLASS="logInFormFont">
                    Password:
                </FONT>
                </td>
                <td valign="top">
                    <table>
                    <tr><td>
                    <INPUT TYPE="PASSWORD" SIZE=10 NAME="password" style="font-size: 8pt;">
                    </tr></td><tr><td>
                    <INPUT TYPE="SUBMIT"  VALUE="Submit">
                    </tr></td><tr><td>
                    <INPUT TYPE="hidden" NAME="submit" value="validate">
                    </tr></td>
                    </table>
                </td>
            </tr>
            </table>
            </FORM>
        </td>
    </tr>
    </table>
    <?php
} 

// *************** END FUNCTION log_in_form ***************

/*
 * Sends the message to be displayed when the page is accessed
 * without logging
 */
function logged_in_false_msg() {
    ?>
    You are not logged in.
    <?php
}


/*
 * Displays welcome message to the user when he is logged in.
 */
function log_in_status_on_main_nav() {
    GLOBAL $gbl ;

    $statusWidth   = cnfg('logInStatusWidth') ;
    $statusBgColor = cnfg('logInStatusBgColor');
?>
<ul>
<li><a href="">Welcome <?php echo $gbl["user_name"]; ?></a></li>
<li><a href="<?php echo cnfg('deDir'); ?>log_out.php">Log out</a></li>
</ul>
<?php
}
/*
 * Displays welcome message to the user when he is logged in.
 */
function log_in_status() {
    GLOBAL $gbl ;

    $statusWidth = cnfg('logInStatusWidth') ;
    $statusBgColor = cnfg('logInStatusBgColor');

    /*
    = cnfg('logInFormCaptionBgColor');
    = cnfg('logInFormWidth');
    = cnfg('logInFormBgColor');
    */
 
    ?>

    <table CELLSPACING="0" CELLPADDING="0" BORDER="0" WIDTH="<?php echo $statusWidth; ?>" BGCOLOR="<?php echo $statusBgColor; ?>">
    <tr>
        <td VALIGN="TOP" WIDTH="100%">

    <?php

    if (!$gbl['loggedIn']) {
        logged_in_false_msg() ;
    } else { 
?>

        <FONT CLASS="logInStatusMsg" COLOR="#000000">
            You are logged in as <?php echo $gbl["user_name"]; ?>
            <CENTER>
                <a href="<?php echo cnfg('deDir') ?>log_out.php">
                <FONT CLASS="logInStatusLogOut" COLOR="#0000FF">
                Log out
                </FONT>
                </a>
            </CENTER>
        </FONT>
    <?php
    } // end else
    ?>
        </td>
    </tr>
    </table>
    <?php
}

/*
 * main header of the page
 * This is where bubble logo is displayed
 */
function main_header() {
    ?>
    <table border="0" width="800" id="table1" cellspacing="0" cellpadding="0" bgcolor="#FFFFFF" background="/images/bkwhite.jpg">
    <TR>
    <TD VALIGN="TOP">
        <IMG SRC="<?php echo cnfg('deDir') ?>images/title4.jpg" WIDTH="800"
            HEIGHT="120" BORDER="0"></TD>
    </TR>
    </TABLE>
  
    <?php

} // end function main_header() 

/* Footer to be displayed
 * Currently we are nowhere using it
 */
function main_footer() {
    ?>
    <TABLE CELLPADDING="0" CELLSPACING="0" BORDER="0" WIDTH="100%" >
    <TR>
        <TD VALIGN="TOP">
            <CENTER>
            <a href="http://www.dewebware.com" target="_blank">
                <img src="<?php echo cnfg("deDir") ?>images/powered_declass2.gif" border="0"></a>
            </CENTER>
        </TD>
    </TR>
    </TABLE>
    <?php
}
?>