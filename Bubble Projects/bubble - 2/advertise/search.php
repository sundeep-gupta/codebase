<?php

/* D.E. Classifieds v1.04 
   Copyright © 2002 Frank E. Fitzgerald 
   Distributed under the GNU GPL .
   See the file named "LICENSE".  */


require_once 'path_cnfg.php';

require_once(path_cnfg('pathToLibDir').'func_common.php');
require_once(path_cnfg('pathToLibDir').'func_checkUser.php');
require_once(path_cnfg('pathToLibDir').'func_getResults.php');
require_once(path_cnfg('pathToCnfgDir').'cnfg_vars.php');
require_once(path_cnfg('pathToLibDir').'vars_gbl.php');

$myDB = db_connect();

$cookie = $HTTP_COOKIE_VARS['log_in_cookie'];
$search = $HTTP_GET_VARS['doSearch'];

$content = array();

checkUser('', ''); 


if ($search) {
    $content[] = 'getResults();';
} else {
    $content[] = 'search_by_keyword_form();';
}

require_once(path_cnfg('pathToTemplatesDir').cnfg('tmplt_search'));

db_disconnect($myDB);


function search_by_keyword_form() {
  
?>
<div align='center'>
    <FORM ACTION="<?=cnfg('deDir')?>search.php?doSearch=1" METHOD="POST">
        <table cellpadding="0" cellspacing="0" border="0">
        <tr>
            <td valign="top">
    
                Enter Keyword:
            </td>
        </tr>
        <tr>
            <td valign="top">
                <INPUT TYPE="TEXT" NAME="search" SIZE="30">
            </td>
        </tr>
        <tr>
            <td valign="top">
                Search In Category:
            </td>
        </tr>
        <tr>
            <td valign="top">
                <SELECT NAME="category">
                <OPTION VALUE="none">All Categories</OPTION> 
                    <?php get_cat_options(); ?>
                </SELECT> <BR/>
                <INPUT TYPE="SUBMIT" NAME="submit" value="Submit">
            </td>
        </tr>
        </table>
        <INPUT TYPE="HIDDEN" NAME="searchType" VALUE="keyword">
    </FORM><BR/>
</div>

<?php
} // end function search_by_keyword_form()


function get_cat_options() {
    $query = 'SELECT cat_name, cat_id 
              FROM std_categories 
              WHERE parent_id=0 ORDER BY cat_name ASC ';

    $result = mysql_query($query);

    while ($row = mysql_fetch_array($result) ) {
        echo '<OPTION VALUE="'.$row['cat_id'].'">';
        echo $row['cat_name'] ;
        echo "</OPTION>" ;
    } 
}


?>
