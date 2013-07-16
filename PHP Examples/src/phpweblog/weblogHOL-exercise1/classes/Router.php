<?php

Class Router {
	private $path;
	private $args = array();

	function __construct(/*$registry*/) {
		//$this->registry = $registry;

	}

	function setPath($path) {
		$path .= DIRSEP;

		if (is_dir($path) == false) {
			throw new Exception ('Invalid controller path: `' . $path . '`');
		}

		$this->path = $path;
	}

	function getArg($key) {
		if (!isset($this->args[$key])) { return null; }
		return $this->args[$key];
	}

	function delegate() {
		// Analyze route
		$this->getController($file, $controller, $action, $args);

		// File available?
		if (is_readable($file) == false) {
			$this->notFound('no-file');
		}

		// Include the file
		include ($file);

        $_SESSION['view_controller'] = $controller;
        $_SESSION['view_action'] = $action;

		// Initiate the class
		$class = 'Controller_' . $controller;
		$controller = new $class($args);

		// Action available?
		if (is_callable(array($controller, $action)) == false) {
			$this->notFound('no-action');
		}

		// Run action
		$controller->$action();

        // Destroy session
        //$_SESSION = array();
        //session_destroy();
	}

	private function extractArgs($args) {
		if (count($args) == 0) { return false; }
		$this->args = $args;
	}
	
	private function getController(&$file, &$controller, &$action, &$args) {
		$route = (empty($_GET['route'])) ? '' : $_GET['route'];

		if (empty($route)) { $route = 'index'; }  // Default route

		// Get separate parts
		$route = trim($route, '/\\');
		$parts = explode('/', $route);

		// Find right controller
		$cmd_path = $this->path;
		foreach ($parts as $part) {
			$fullpath = $cmd_path . $part;
			
			// Is there a dir with this path?
			if (is_dir($fullpath)) {
				$cmd_path .= $part . DIRSEP;
				array_shift($parts);
				continue;
			}

			// Find the file
			if (is_file($fullpath . '.php')) {
				$controller = $part;
				array_shift($parts);
				break;
			}
		}

		if (empty($controller)) { $controller = 'index'; };

		// Get action
		$action = array_shift($parts);
		if (empty($action)) { $action = 'index'; }

		$file = $cmd_path . $controller . '.php';
		$args = $parts;
	}


	private function notFound() {
		die("404 Not Found");
	}

}

?>