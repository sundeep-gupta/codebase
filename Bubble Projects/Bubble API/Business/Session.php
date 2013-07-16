<?php

class Session {
    function __construct($session_name, $save_path) {
	/*TODO: Throw exception if session_name is undefined */
#	session_name($session_name);
#	session_save_path($save_path);
#        session_set_cookie_params($cookie_lifetime, 
#				  $cookie_path, $cookie_domain);
#	if ($session_id)
#	    session_id($session_id);
	session_start();
#	echo "Session Started\n";
    }
    
#    function register($var) {
#	session_register($var);
#    }

    function is_set($var) {
	if (isset($_SESSION[$var])) {
	    return 1;
	}

	return 0;
    }

    function get($var) {
	if (isset($_SESSION[$var])) {
	    return $_SESSION[$var];
	}
    }

    function set($var,$val) {
	$_SESSION[$var] = $val;
    }
    function un_set($var) {
	unset($_SESSION[$var]);
    }
}

?>