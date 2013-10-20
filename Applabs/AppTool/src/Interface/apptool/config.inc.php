<?php

######################################################################################
#
# Copyright:     AppLabs Technologies, 2006
# Created By:    Author: Jason Smallcanyon
# Revision:      $Revision: $
# Last Modified: $Date: $
# Modified By:   $Author: $
# Source:        $Source: $
#
######################################################################################


// Define which operating system we are using, Windows or Linux
$os = "";
if (isset($_ENV['OS']) && ($_ENV['OS'] == "Windows_NT")) {
    $os = "Windows";
}
else if (isset($_SERVER['OS']) && ($_SERVER['OS'] == "Windows_NT")) {
    $os = "Windows";
}
else if (isset($_SERVER['SERVER_SOFTWARE']) && preg_match("/Microsoft/i", $_SERVER['SERVER_SOFTWARE'])) {
	$os = "Windows";
}
else {
    $os = "Linux";
}
define('OS', $os);

$inc_path = (OS == "Windows") ? "C:\\AppLabs\\AppTool\\Library\\Php-Lib" : "/opt/AppLabs/AppTool/Library/Php-Lib";
set_include_path($inc_path);


?>
