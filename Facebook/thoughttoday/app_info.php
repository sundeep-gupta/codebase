<?php
    require_once('facebook.php');
 /* 
  * Copyright (C) 2010 - 2011, Bubble Inc., All Rights Reserved.
  */ 
    /**
     * This file contains the utility functions used for thought today facebook 
     * application.
     *
     */
    ################ CONSTANTS #######################################################################
    define('FB_APPID', '165158873520727');
    define('FB_SECRET', 'c338e0324d2dca6032be56c7aa2dc4a9');
    define('FB_APPAPIKEY', '928c09871aead0f9d8defe18e2f66a5a');
    define('FB_APPNAME', 'thoughttoday');
    define('HOSTING_WEBSITE', 'http://www.insha.in/fb');
    define('FB_CANVAS_URL', HOSTING_WEBSITE . '/thoughttoday/');
    define('FB_OAUTH_URL', 'https://graph.facebook.com/oauth/authorize');
    define('FB_APP_URL', 'http://apps.facebook.com/'. FB_APPNAME );
    define('FB_ACCESS_TOKEN_URL', 'https://graph.facebook.com/oauth/access_token');
    define('FB_APP_PERMISSIONS', 'user_photos,user_videos,publish_stream,offline_access,email');
    define('FB_APP_TEXT', 'Today\'s Thought');
    define('FB_APP_LOGO',"http://insha.in/fb/thoughttoday/tt1.jpg"); 
    define('FB_APP_PAGE_URL', FB_APP_URL);


    
    # Single instance of database handle.
    $dbh = NULL;
    $facebook = NULL;
    /**
     * This function returns an instance of 'Facebook' object. 
     */
    function getFacebookObject() {
        global $facebook;
        if($facebook) {
            return $facebook;
        }
        $fb_array = array(
            'appId'  => FB_APPID,
            'secret' => FB_SECRET,
            'cookie' => true);
        $facebook = new Facebook($fb_array);  
        return $facebook;
    }

    /*
     * This function returns the facebook session reference.
     */
    function getSession() {
        $facebook = getFacebookObject();
        return $facebook->getSession();
    }
    /**
     * This function is for restricting access to admins.
     */
    function isAdmin() {
        if($facebook = getFacebookObject()){
             $uid = $facebook->getUser();
             if ($uid == '652390905') {
                 return TRUE;
             }
        }
        return FALSE;
    }
    /*
     * getAuthorizeURL will return the URL to be used for getting permissions
     * from the user accessing the application. 
     * 
     */
    function getAuthorizeURL($redirect_uri) {
        return FB_OAUTH_URL . '?' 
                . 'client_id=' . FB_APPID 
                . '&redirect_uri=' . $redirect_uri
                . '&scope=' . FB_APP_PERMISSIONS ;
    }

    /*
     * This will return the permanent access token provided the validation code.
     * TODO : This function is currently little complecated than required. 
     * 
     */
    function getPermanentAccessToken($redirect_uri, $validation_code) {
       $facebook = getFacebookObject();
       $session = getSession();
       $uid = $facebook->getUser();
       $query = NULL;
       if($access_token = getStoredAccessToken($uid)) {
           if($access_token != $session['access_token']) {
               # Update the access token
               $query = 'UPDATE fb_tt_subscribers SET access_token = ? WHERE fbid = ?';
           }
       } else {
           # Insert the access token;
           $query = 'INSERT INTO fb_tt_subscribers(fbid, access_token) VALUES(?, ?)';
       }
       if (! $query) {
           return $access_token;
       }
       $dbh = getDatabaseHandle();
       $stmt = $dbh->stmt_init();

       if(!$stmt->prepare($query)) {
           throw new DatabaseException('Failed to create prepared statement for ' .$query . ' : ' . $stmt->error);
       }
       if(!$stmt->bind_param('ss', $uid, $session['access_token'])) {
          throw new DatabaseException($stmt->error);
        };
       if(!$stmt->execute()) {
          throw new DatabaseException($stmt->error);
       }
       $rows_changed = $stmt->affected_rows;
       $stmt->close();
       if($rows_changed == 1) {
           return $session['access_token'];
       }
       return FALSE;

    }

    /*
     * This function will return the access token of the user specified. 
     * if access token for given user is not found, returns FALS
     * Throws DatabaseException for any errors.
     */
    function getStoredAccessToken($uid) {
       $dbh = getDatabaseHandle();
       $query = 'SELECT access_token FROM fb_tt_subscribers WHERE fbid = ?';
       $stmt = $dbh->stmt_init();
       if (! $stmt->prepare($query)) {
           throw new DatabaseException('Failed to prepare stmt ' . $query . ' : ' . $stmt->error);
       }
       if(!$stmt->bind_param('s', $uid)) {
           throw new DatabaseException('Failed to bind param for '. $query . ' with value '.$uid  . ' : ' . $stmt->error);
       }
       if (!$stmt->execute()) {
           throw new DatabaseException('Failed to execute prepared statement '. $query . ' : ' . $stmt->error);
       }
       if (! $stmt->store_result()) {
           throw new DatabaseException('Failed to store result. ' . $stmt->error);
       }
       if ($stmt->num_rows == 0) {
           return FALSE;
       } else {
           $stmt->bind_result($access_code);
           $stmt->fetch();
           return $access_code;
       }
    }

    /* 
     * This function returns a associative array of thought, thought_by by fetching data from database table.
     * NOTE: Currently using this functiion internally in 'getThoughtAttachment'
     */
    function getThoughtToday() {
        $thought = array('thought' => 'Seriousness is the only refuge of the shallow.',
                'by' => 'Oscal Wilde');
        # TODO : Create DB table & get data from there.
        $dbh = getDatabaseHandle();
        $query = 'SELECT id, thought, thought_by, date_posted FROM fb_tt_thoughts WHERE date_posted IS NULL ORDER BY RAND() LIMIT 1';
        $result = $dbh->query($query);
        if($dbh->error) {
            error_log('Error running query ' . $dbh->error);
            return FALSE;
        }
        if( !$result) {
            error_log('No more thoughts in my database');
            return FALSE;
        }
        return $result->fetch_assoc();
    }

    /*
     * Gets a new thought randomly from database and constructs the attachment (associative array) as required by 
     * 'facebook' for publishing.
     */
    function getThoughtAttachment() {
        $thought = getThoughtToday();
        if (!$thought['thought']) {
            return FALSE;
        }
        $attachment = array('name' => FB_APP_TEXT,
                            'caption' => 'A thought a day keeps tensions away.',
                            'link' => FB_APP_URL,
                            'picture' => FB_APP_LOGO,
                            'message' => $thought['thought'],
                            'description' => $thought['thought'],
                            'id' => $thought['id'],
       );
        
        if (!$thought['thought_by']) {
            $attachment['description'] = $attachment['description'] . '<br/> - Unknown';
        } else {
            $attachment['description'] = $attachment['description'] . '<br/> - ' . $thought['thought_by'];
        }
        return $attachment;
    }

    /*
     * This is THE function which does publishing on all subscribers. 
     * It gets the thought and list of subscribers and then iterates through them
     * to publish on subscriber's wall.
     */
    function publishAll() {
        $session = getSession();
        $facebook = getFacebookObject();
        $attachment = getThoughtAttachment();
        $id = $attachment['id'];
        unset($attachment['id']);
        $dbh = getDatabaseHandle();
        $query = 'SELECT fbid, access_token FROM fb_tt_subscribers';
        if($result = $dbh->query($query)) {
            while($row = $result->fetch_row()) {
                try {
                    $attachment['access_token'] = $row[1];
                    $facebook->api('/me/feed', 'POST', $attachment);
                    $attachment['access_token'] = NULL;
                } catch(FacebookApiException $e) { 
                    # print("Failed to post on wall of id : ". $row[0] . ": " . $e);
                    error_log("Failed to post on wall of id : ". $row[0] . ": " . $e);
                } 
            } 
            setThoughtPublished($id);
            return TRUE;
        }
        return FALSE;
    }

    /*
     * Marks a thought as posted in the database so as not to pick it up again.
     */
    function setThoughtPublished($id) {
        if(!$id) {
            return FALSE;
        }
        $query = 'UPDATE fb_tt_thoughts SET date_posted = NOW() WHERE id = ?';
        $dbh = getDatabaseHandle();
        $stmt = $dbh->stmt_init();
        if(!$stmt->prepare($query)) {
            throw new DatabaseException('Failed to prepare stmt ' . $query . ' : ' . $stmt->error);
        }
        if(!$stmt->bind_param('i', $id)) {
            throw new DatabaseException('Failed to bind param ' . $query . ' : ' . $stmt->error);
        }
        if (! $stmt->execute() ) {
            throw new DatabaseException('Failed to execute ' . $query . ' : ' . $stmt->error);
        }
        $rows = $stmt->affected_rows;
        $stmt->close();
        if($rows == 1) {
            return TRUE;
        } 
        return FALSE;
    }

    /*
     * Returns a singleton database handle.
     */
    function getDatabaseHandle() {
       global $dbh;
       if ($dbh == NULL) {
           $dbh = new mysqli('localhost', 'insha_in', 'EternalSQL', 'insha_in');
           if($dbh->connect_error) {
               $error = $dbh->connect_error;
               $dbh = NULL;
               throw new DatabaseException($error);
           }
       }
       return $dbh;
    }
/*
      ####################################
################################ For accessing info using FQL ##############################

                $query = 'SELECT name from user where uid = ' . $row[0];
                $info = $facebook->api( array( 'method' => 'fql.query',
                        'access_token' => $session['access_token'],
                        'query' => $query));
                # $table[$row[0]] = array('token' => $row[1], 'info' => $info);
                
#zcurl -F grant_type=authorization_code \
#     -F client_id=165158873520727 \
#     -F client_secret=c338e0324d2dca6032be56c7aa2dc4a9 \
#     -F redirect_uri=http://apps.facebook.com/thoughttoday/app.php \
#     https://graph.facebook.com/oauth/access_token




#######################################
       $access_token = $session['access_token'];
       # Connect to database & check if we already have access code.
       mysql_connect('localhost', 'insha_in','EternalSQL') or die (mysql_error());
       mysql_select_db('insha_in') or die (mysql_error());
       $query = 'SELECT access_token FROM fb_tt_subscribers WHERE fbid = ' . $facebook->getUser();
       $result_set = mysql_query($query);
       if (! $result_set) {
           # failed running query.
       } elseif (mysql_num_rows($result_set) == 0) {
           $query = 'INSERT INTO fb_tt_subscribers(fb_id, access_token) VALUES(' 
           # No match found in DB
       } else {
           # Found a match in database. Getting access token.
           $record = mysql_fetch_assoc($result_set);
           $access_token = $record['access_token'];
       }
       # If access code is not found, then get the access code from URL 
       $session = getSession();
       if (! $session) {
           return NULL;
       }
       $access_token = $session['access_token'];
       if (!$access_token) {
           return NULL;
       }
       # Save the access_token
      
       # Return the access_token finally
       return $access_token;
/*
        $get = array('client_id' => FB_APPID,
                'redirect_uri' => $redirect_uri,
                'scope' => FB_APP_PERMISSIONS,
                'client_secret' => FB_SECRET,
                'code' => $validation_code);

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, FB_ACCESS_TOKEN_URL . '?'. http_build_query($get));
        curl_setopt($ch,  CURLOPT_RETURNTRANSFER, TRUE);
        $content = curl_exec($ch);
        $response = curl_getinfo($ch);
        curl_close($ch);
        return $content;
*/

    class DatabaseException extends Exception  {
        // Redefine the exception so message isn't optional
        public function __construct($message, $code = 0, Exception $previous = null) {
            // make sure everything is assigned properly
            parent::__construct($message, $code, $previous);
        }

        // custom string representation of object
        public function __toString() {
            return __CLASS__ . ": [{$this->code}]: {$this->message}\n";
        }
    }
?>
