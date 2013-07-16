<?php
require_once(LIB.'/Bubble/DB/MySQLi.php');
abstract class Database {
    protected $step;
    protected $dbconn;
    protected $queries;
    public function __construct() {
		$this->dbconn    = new MySQLi(DB_HOST, DB_USER, DB_PASS, DB_NAME);
		$this->dbconn->connect();
		$this->queries = array( 
	    	'Q_AB_PUBLISHERS'       => 'SELECT pub_id, name FROM ab_publisher',
			'Q_AB_LIBRARIES'        => 'SELECT lib_id, name, address FROM ab_library',
			'Q_AB_LIBRARY_DETAIL'   => 'SELECT b.name, b.author, p.ame, lang.name '.
			                           'FROM ab_book b, ab_library l, ab_publisher p , ab_language lang '.
									   'WHERE l.lib_id = ? AND l.book = b.book_id AND b.publisher = p.pub_id'.
									   'AND lang.lang_id = b.language',
			'Q_AB_BOOKS_PUBLISHER'  => 'SELECT b.book_id, b.name, b.author, b.publisher, b.language '.
			                           'FROM ab_book b, ab_publisher p '.
									   'WHERE b.publisher = p.pub_id',
			'I_AB_BOOK'             => 'INSERT INTO ab_book(name, author, publisher, language) '.
				                       'VALUES(?, ?, ?, ?)',
			'Q_AB_LANGUAGES'        => 'SELECT lang_id, name FROM language',
		    );	
    }

	public function add_book($name, $author, $language, $publisher) {
		$bind_params = array();
		$this->dbconn->prepared_query('I_AB_BOOK', $bind_params);
	}

	public function get_libraries() {
		return $this->dbconn->query('Q_AB_LIBRARIES');
	}

}

?>
