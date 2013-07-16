<?php
require_once 'rss_db.php';

FeedList::update();

$rows = Feed::get( $_GET['id'] );

$dom = new DomDocument();
$dom->formatOutput = true;

$root = $dom->createElement( 'articles' );
$dom->appendChild( $root );

foreach( $rows as $row )
{
  $an = $dom->createElement( 'article' );
  $an->setAttribute( 'title', $row['title'] );
  $an->setAttribute( 'link', $row['link'] );
  $an->appendChild( $dom->createTextNode( $row['description'] ) );
  $root->appendChild( $an );
}

header( "Content-type: text/xml" );
echo $dom->saveXML();
?>