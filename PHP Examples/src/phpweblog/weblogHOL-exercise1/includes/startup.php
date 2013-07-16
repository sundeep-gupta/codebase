<?php
session_start();

error_reporting (E_ALL);
if (version_compare(phpversion(), '5.1.0', '<') == true) { die ('PHP5.1 Only'); }

// Constants:
define ('DIRSEP', DIRECTORY_SEPARATOR);

// Get site path
$site_path = realpath(dirname(__FILE__) . DIRSEP . '..' . DIRSEP) . DIRSEP;
define ('SITE_PATH', $site_path);
define ('SITE_ROOT', 'http://' . $_SERVER['SERVER_NAME'] . substr($_SERVER['PHP_SELF'], 0, strrpos($_SERVER['PHP_SELF'], '/')) . DIRSEP);

// For loading classes
function __autoload($class_name) {
    $dir = "classes";
    //$filename = strtolower($class_name) . '.php';
    $filename = $class_name . '.php';
    if( stripos($class_name, "model") ) {
        $dir = "models";
        //$filename = str_ireplace("_Model", "", $class_name);
    }
    $file = SITE_PATH . $dir . DIRSEP . $filename;

    if (file_exists($file) == false) {
        return false;
    }

    include ($file);
}

/**
 * Create a URL given the controller, action, and optional arguments
 * @param string $controller Controller
 * @param string $action Action
 * @param string $arg1 Optional argument
 * @param string $arg2 Optional argument
 * @return string URL string
 */
function createURL($controller, $action = "index", $args = NULL) {
    return(SITE_ROOT . $controller . DIRSEP . $action . DIRSEP . $args);
}

/**
 * Determine current controller/action and generate appropriate view path for inclusion.
 * @param string $cont optional Controller
 * @param string $act optional Action
 * @return string View file to include
 */
function showView($cont = NULL, $act = NULL) {
    if( !isset($cont) ) {
        $controller = $_SESSION['view_controller'];
    }
    if( !isset($act) ) {
        $action = $_SESSION['view_action'];
    }
    return(SITE_PATH . 'views' . DIRSEP . $controller . DIRSEP . $action . '.php');
}

/**
 * Set status message
 * @param string $msg Message to set
 */
function set_status($msg) {
    $_SESSION['status'] = $msg;
}

/**
 * Retrieve status message for display
 * @return string Status message
 */
function get_status() {
    if(isset($_SESSION['status'])) {
        $flash = $_SESSION['status'];
        unset($_SESSION['status']);
        return $flash;
    }
}