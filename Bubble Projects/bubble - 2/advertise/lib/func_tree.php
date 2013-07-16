<?php

/* D.E. Classifieds v1.04 
   Copyright � 2002 Frank E. Fitzgerald 
   Distributed under the GNU GPL .
   See the file named "LICENSE".  */


/**************************************
 * File Name: func_tree.php           *
 * ---------                          *
 *                                    *
 **************************************/


// ************* START FUNCTION get_num_ads() *************

function get_num_ads($cat_id, $first_recur, &$num_ads, $one_cat_only=false ) {
    GLOBAL $myDB;

    #echo 'this is get_num_ads()!!!<BR>';

    if ($one_cat_only) {
	$query = "select COUNT(*) as num from std_items where 
                  cat_id=$cat_id";
        $result = mysql_query($query);
        $row = mysql_fetch_array($result);
        return $row["num"]; 
    }

    $query = "select cat_id from std_categories where 
              parent_id=$cat_id";
    $result = mysql_query($query);
    if (!$result) {
	die("\$query failed!!!<BR>");
    }

    if (mysql_num_rows($result) > 0 ) {
	$is_childs = true;
        #echo '$is_childs is true<BR>';
    } else {
	$is_childs = false;
        #echo '$is_childs is false<BR>';
    }
 
    if ($first_recur) {
	if (!$is_childs) {
	    $query2 = "select COUNT(*) as num from std_items
                       where cat_id=$cat_id";
            $result2 = mysql_query($query2);
	    if (!$result2) {
		die("\$query2 failed!!!<BR>");
	    }
            $row2 = mysql_fetch_array($result2) ;
	    $num_ads += $row2["num"]; 
        }
    }


    while ($row = mysql_fetch_array($result) ) {
	$new_cat_id = $row["cat_id"];
        $query3     = 'select cat_id from std_categories
	               where parent_id='.$row["cat_id"];
        $result3 = mysql_query($query3);
	if (!$result3) {
	    die("\$query3 failed!!!<BR>");
	}
        if (mysql_num_rows($result3) == 0 ) {
	    $query4 = 'SELECT COUNT(*) AS num FROM std_items 
		       WHERE cat_id='.$row["cat_id"] ;
	    $result4 = mysql_query($query4);
	    if (!$result4) {
		echo '$query4 failed!!!<BR>';
		die('mysql_error() = '.mysql_error().'<BR>');
            }
            $row4     = mysql_fetch_array($result4);
            $num_ads += $row4["num"];
        }
        get_num_ads($new_cat_id, false, $num_ads);
    }



} // end function get_num_ads()

// ************* END FUNCTION get_num_ads() *************


// ************* START FUNCTION function get_tree()  *************

function get_tree($which_page) {
    GLOBAL $myDB;

    $query = "Select cat_id, cat_name, parent_id
              FROM std_categories 
              WHERE parent_id=0";

    $result = mysql_query($query) or die(mysql_error());

    echo "
      <TABLE CELLPADDING=\"0\" CELLSPACING=\"0\" BORDER=\"0\">\n
      <TR>
      <TD VALIGN=\"TOP\">
      <BR>
      </TD>
      </TR>";

    $i_td = 1;
    for($i=0; $i<mysql_num_rows($result); $i++) {
        
        if ($i_td==1 || $i_td==3) {
	    $row = mysql_fetch_array($result) ;
            if ($i_td == 1) {
		echo "<TR>\n";
            }
            $result2 = mysql_query("SELECT cat_id FROM std_categories
				    WHERE parent_id=".$row["cat_id"]) ;
            $num_ads = 0;
	    
?>            
            <TD VALIGN="TOP">
		<TABLE CELLPADDING="0" CELLSPACING="0" BORDER="0">
		<TR>
		    <TD VALIGN="TOP">
			<table cellpadding="0" cellspacing="0" border="0">
			<tr>
			    <td valign="top">
<?php			    
            if (mysql_num_rows($result2) > 0) { 
                if ($which_page=='add_cats' || $which_page=='rename_cats') {
		    echo '<a href="'.$which_page.'.php?cat_id='.$row["cat_id"].'" CLASS="catLink">' ; 
                    get_num_ads($row["cat_id"], true, $num_ads, true);
                } elseif($which_page=='move_ads') {
		    echo '<a href="'.$which_page.'.php?cat_id='.$row["cat_id"].'&page=2" CLASS="catLinkBlue">' ; 
		    get_num_ads($row["cat_id"], true, $num_ads, true);
                }
?>

                <NOBR>
                <FONT CLASS="subCat">
                <?php echo $row["cat_name"]; ?>
                </FONT>
                </NOBR>

<?php
                if ($which_page=='add_cats' || $which_page=='rename_cats') {
		    echo '</a>'; 
                } elseif ($which_page=='move_ads') {
		    echo '</a>' ; 
                    echo '<FONT CLASS="subCat">('.$num_ads.')</FONT>';
                }
?>
                <table cellpadding="0" cellspacing="0" border="0">

<?php
                displaytree_add($row["cat_id"], 1, $row["cat_id"], $which_page);
?>
	    </table>
<?php
            } else {
?>		
                <a href='<?php echo $which_page; ?>.php?cat_id=<?php echo $row["cat_id"]; ?>" CLASS="catLink">' ; 
                <FONT CLASS="subCat" >
                <?php echo $row["cat_name"]; ?>
                </FONT>  
                </a>
<?php
	    }
?>	    
		</td>
	    </tr>
	    </table>
        </TD>
        </TR>
        </TABLE>
        <BR/><BR/>
        </TD>
<?php
	}  elseif ($i_td==2) {
?>	    
	    <TD VALIGN="TOP" WIDTH="15">&nbsp;</TD>
<?php	    
            $i--;
        }
        if ($i_td < 3) {
	    $i_td++;
            continue;
        } elseif ($i_td == 3) {
	    $i_td = 1;
            echo '</TR>';
        }
    }
    echo '</TABLE>';
} // end function get_tree() 


// ************* END FUNCTION function get_tree()  *************


// ************* START FUNCTION displaytree_add() *************

function displaytree_add($idParent=0, $nLevel=0, $cat_id=0, $which_page) {
    GLOBAL $myDB;
    // Get childs

    $result = mysql_query ("SELECT * FROM std_categories
			    WHERE parent_id=" . $idParent . 
                            " ORDER BY cat_name");

    if (!$result) {
	echo mysql_error();
    }
?>
    <tr>
    <td>
    <?php
        $num_rows = mysql_num_rows($result); 
        while ($row = mysql_fetch_array($result) ) {
            echo "<NOBR>\n";

        //echo (str_repeat("&nbsp;&nbsp;&nbsp;", $nLevel) );
        if ($nLevel==1) {
	    echo '<img src="images/new_treeLine_2right.gif" border="0" hspace="0" vspace="0" width="25" height="25">';
        } else {
	    for ($n=0; $n<$nLevel; $n++) {
		if ($n==0) {
		    echo '<img src="images/new_treeLine_2right.gif" border="0" hspace="0" vspace="0" width="25" height="25">';
                } elseif ($n > 0 && $n<$nLevel ) {
		    echo '<img src="images/new_treeLine_cross.gif" border="0" hspace="0" vspace="0" width="25" height="25">';
                }
            }
        }
        if ($which_page=='select_to_add' || $which_page=='move_ads' ) {
	    $query2 = 'SELECT * FROM std_categories
			WHERE parent_id='.$row["cat_id"] ;
            $result2 = mysql_query($query2);
        }
        $close_href   = false;
        $num_ads      = 0;
        $show_num_ads = false;

        if ( $which_page=='select_to_add' && mysql_num_rows($result2) == 0 ) {
	    echo '<a href="'.$which_page.'.php?cat_id='.$row["cat_id"].'" CLASS="catLink">' ; 
            $close_href = true;
            #$show_num_ads = true;
        } elseif ($which_page=='move_ads' && mysql_num_rows($result2) == 0) {
	    echo '<a href="'.$which_page.'.php?cat_id='.$row["cat_id"].'&page=2" CLASS="catLinkRed">' ;  
            get_num_ads($row["cat_id"], true, $num_ads, false);

            $close_href = true;
            $show_num_ads = true;
        } elseif ($which_page=='move_ads' && mysql_num_rows($result2) > 0 ) {
	    echo '<a href="'.$which_page.'.php?cat_id='.$row["cat_id"].'&page=2" CLASS="catLinkBlue">' ; 
        
            get_num_ads($row["cat_id"], true, $num_ads, false);

            $close_href   = true;
            $show_num_ads = true;
        } elseif ($which_page=='add_cats') {
	    echo '<a href="'.$which_page.'.php?cat_id='.$row["cat_id"].'" CLASS="catLink">' ;  
            get_num_ads($row["cat_id"], true, $num_ads, false);
	    
            $close_href   = true;
            $show_num_ads = true;
        } elseif ($which_page=='rename_cats') {
	    echo '<a href="'.$which_page.'.php?cat_id='.$row["cat_id"].'" CLASS="catLink">' ;  
            $close_href = true; 
        }
?>    
        <FONT CLASS="subCat" >
	<?php  echo $row["cat_name"];  ?>
	</FONT>
<?php     
        if ($close_href) {
	    echo '</a>' ; 
        }
        if ($show_num_ads) {
	    echo '<FONT CLASS="subCat">('.$num_ads.')</FONT>';
        }
?>
	</NOBR>
        </td>
        </tr>
<?php
        displaytree_add($row["cat_id"], ($nLevel + 1), $cat_id, $which_page);

    }

} // end function displaytree_add()

// ************* END FUNCTION displaytree_add() *************


// ************* START FUNCTION climb_tree() *************

function climb_tree($cat_id, $which, $path='') {
    
    GLOBAL $myDB, $path;

    $query = 'Select cat_id, cat_name, parent_id
	      FROM std_categories
	      WHERE cat_id='.$cat_id;

    $result = mysql_query($query);

    if (!$result)  {
	echo mysql_error();
    }

    while ($row = mysql_fetch_array($result) ) {
	if ( ($which=='showCat' || $which=='details') && 
            ( isset($path) && $path != '')  ) {
	    $path = '<a href="showCat.php?cat_id='.$cat_id.'">
		    <FONT CLASS="mainCat">'.$row["cat_name"].
		    '</FONT></a>!@#_SPLIT_!@#'.$path;
        } else {
	    $path = '<FONT CLASS="mainCat">'.$row["cat_name"].'</FONT>!@#_SPLIT_!@#'.$path; 
        }
        climb_tree($row["parent_id"], $which, $path);
    }
    return $path;
} // end climb_tree()

// ************* END FUNCTION climb_tree() *************
?>