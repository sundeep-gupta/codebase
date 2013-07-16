<?php

	// mySQL connection information
	$MYSQL_HOST = 'localhost';
	$MYSQL_USER = 'root';
	$MYSQL_PASSWORD = 'password';
	$MYSQL_DATABASE = 'test';
	$MYSQL_PREFIX = 'bb_blog_';

	// main nucleus directory
	$DIR_NUCLEUS = 'D:/web/nucleus333/nucleus/';

	// path to media dir
	$DIR_MEDIA = 'D:\web\nucleus333/media/';

	// extra skin files for imported skins
	$DIR_SKINS = 'D:/web/nucleus333/skins/';

	// these dirs are normally sub dirs of the nucleus dir, but 
	// you can redefine them if you wish
	$DIR_PLUGINS = $DIR_NUCLEUS . 'plugins/';
	$DIR_LANG = $DIR_NUCLEUS . 'language/';
	$DIR_LIBS = $DIR_NUCLEUS . 'libs/';

	// include libs
	include($DIR_LIBS.'globalfunctions.php');
?>