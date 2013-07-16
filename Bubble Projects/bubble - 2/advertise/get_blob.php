<?php

/* D.E. Classifieds v1.04 
   Copyright © 2002 Frank E. Fitzgerald 
   Distributed under the GNU GPL .
   See the file named "LICENSE".  */

require_once 'path_cnfg.php';

require_once(path_cnfg('pathToCnfgDir').'cnfg_vars.php');
require_once(path_cnfg('pathToLibDir').'func_common.php');

$myDB = db_connect();

$query  = 'select bin_data,filetype from std_blob_images where blob_id='.$the_id.';';
$result = mysql_query($query);
$data   = mysql_result($result,0,"bin_data");
$type   = mysql_result($result,0,"filetype");
Header( "Content-type: $type");
echo $data;
?> 
 
