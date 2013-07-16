<?php

# Startup tasks
require 'includes/startup.php';

# Load router
$router = new Router();
$router->setPath (SITE_PATH . 'controllers');
$router->delegate();

?>