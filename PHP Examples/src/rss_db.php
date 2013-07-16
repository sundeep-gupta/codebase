<?php
require_once 'DB.php';
require_once 'XML/RSS.php';

class DatabaseConnection
{
  public static function get()
  {
    static $db = null;
    if ( $db == null )
      $db = new DatabaseConnection();
    return $db;
  }

  private $_handle = null;

  private function __construct()
  {
    $dsn = 'mysql://root@localhost/rss_reader';
    $this->_handle =& DB::Connect( $dsn, array() );
  }
  
  public function handle()
  {
    return $this->_handle;
  }
}                

class FeedList {
  public static function add( $url ) {

    if ( FeedList::getFeedByUrl( $url ) != null ) return;

    $db = DatabaseConnection::get()->handle();

    $rss =& new XML_RSS( $url );
    $rss->parse();
    $info = $rss->getChannelInfo();

    $isth = $db->prepare( "INSERT INTO rss_feeds VALUES( null, ?, ?, null )" );
    $db->execute( $isth, array( $url, $info['title'] ) );

    $info = FeedList::getFeedByUrl( $url );
    Feed::update( $info['rss_feed_id'] );
  }

  public static function getAll( ) {
    $db = DatabaseConnection::get()->handle();
    $res = $db->query( "SELECT * FROM rss_feeds" );
    $rows = array();
    while( $res->fetchInto( $row, DB_FETCHMODE_ASSOC ) ) { $rows []= $row; }
    return $rows;
  }

  public static function getFeedInfo( $id ) {
    $db = DatabaseConnection::get()->handle();
    $res = $db->query( "SELECT * FROM rss_feeds WHERE rss_feed_id=?",
      array( $id ) );
    while( $res->fetchInto( $row, DB_FETCHMODE_ASSOC ) ) { return $row; }
    return $null;
  }

  public static function getFeedByUrl( $url ) {
    $db = DatabaseConnection::get()->handle();
    $res = $db->query( "SELECT * FROM rss_feeds WHERE url=?", array($url ));
   
    while( $res->fetchInto( $row, DB_FETCHMODE_ASSOC ) ) {
	if ( isset($row[rss_feed_id]))
	    return $row ;
    }
    return null;
  }

  public static function update() {
    $db = DatabaseConnection::get()->handle();

    $usth1 = $db->prepare( "UPDATE rss_feeds SET name='' WHERE rss_feed_id=?" );
    $usth2 = $db->prepare( "UPDATE rss_feeds SET name=? WHERE rss_feed_id=?" );

    $res = $db->query(
   "SELECT rss_feed_id,name FROM rss_feeds WHERE last_update<now()-600" );
    while( $res->fetchInto( $row, DB_FETCHMODE_ASSOC ) ) {
      Feed::update( $row['rss_feed_id'] );
      $db->execute( $usth1, array( $row['rss_feed_id'] ) );
      $db->execute( $usth2, array( $row['name'], $row['rss_feed_id'] ) );
    }
  }
}

               
class Feed
{
  public static function update( $id )
  {
    $db = DatabaseConnection::get()->handle();

    $info = FeedList::getFeedInfo( $id );
    $rss =& new XML_RSS( $info['url'] );
    $rss->parse();

    $dsth = $db->prepare( "DELETE FROM rss_articles WHERE rss_feed_id=?" );
    $db->execute( $dsth, array( $id ) );

    $isth = $db->prepare( "INSERT INTO rss_articles VALUES( ?, ?, ?, ? )" );

    foreach ($rss->getItems() as $item) {
      $db->execute( $isth, array( $id,
        $item['link'], $item['title'],
        $item['description'] ) );
    }
  }

  public static function get( $id )
  {
    $db = DatabaseConnection::get()->handle();
    $res = $db->query( "SELECT * FROM rss_articles WHERE rss_feed_id=?",
      array( $id ) );
    $rows = array();
    while( $res->fetchInto( $row, DB_FETCHMODE_ASSOC ) )
    {
      $rows []= $row;
    }
    return $rows;
  }
}
?>