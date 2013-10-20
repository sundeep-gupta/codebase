<?php
/**
 * Core Design Web Gallery plugin for Joomla! 1.5
 */

$path = '';
if (isset($_GET['path'])) $path = (string )$_GET['path'];

if (extension_loaded('zlib') && !ini_get('zlib.output_compression')) @ob_start('ob_gzhandler');

header("Content-type: application/x-javascript");
header('Cache-Control: must-revalidate');
header('Expires: ' . gmdate('D, d M Y H:i:s', time() + 86400) . ' GMT');

echo "var GB_ROOT_DIR = '$path'";

?>