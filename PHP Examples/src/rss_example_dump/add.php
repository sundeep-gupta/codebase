<?php
require_once 'rss_db.php';
header( 'Content-type: text/xml' );
FeedList::add( "http://www.bubble.co.in/rss_ex1.php" );
?>
<done />