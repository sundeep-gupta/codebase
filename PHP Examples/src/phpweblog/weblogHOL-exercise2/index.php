<?php

# Startup tasks
require 'includes/startup.php';

# Load router
$router = new Router();
$router->setPath (SITE_PATH . 'controllers');
$router->delegate();

// Destroy session
//$_SESSION = array();
//session_destroy();
?>
