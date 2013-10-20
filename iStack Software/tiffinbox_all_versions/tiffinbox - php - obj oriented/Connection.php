<?php

/**
 * Connection is to connect to the database. 
 *
 * @author Razikh, Sundeep
 */
class Connection {
    //put your code here
    private static $db_connection = null;
    private function  __construct() {

    }
    public static function get_connection() {
        if (Connection::$db_connection == null) {
            // Connect to database.
            Connection::$db_connection = new PDO("mysql:host=localhost;dbname=tiffinbox", "root","");
            if (Connection::$db_connection == null)
                throw Exception("Failed to connet to database!");
        }
        return Connection::$db_connection;
    }
}
?>
