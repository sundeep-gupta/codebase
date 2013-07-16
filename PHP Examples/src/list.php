<?php
require_once 'rss_db.php';

$rows = FeedList::getAll();

$dom = new DomDocument();
$dom->formatOutput = true;

$root = $dom->createElement( 'feeds' );
$dom->appendChild( $root );

foreach( $rows as $row )
{
  $an = $dom->createElement( 'feed' );
  $an->setAttribute( 'id', $row['rss_feed_id'] );
  $an->setAttribute( 'link', $row['url'] );
  $an->setAttribute( 'name', $row['name'] );
  $root->appendChild( $an );
}

header( "Content-type: text/xml" );
echo $dom->saveXML();
?>