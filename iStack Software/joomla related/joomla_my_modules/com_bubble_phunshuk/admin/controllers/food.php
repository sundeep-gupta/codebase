<?php

// Check to ensure this file is included in Joomla!
defined('_JEXEC') or die('Restricted Access');
jimport('joomla.application.component.controller');
/**
* MyExtension Controller
*
*/
class PhunshukControllerFood extends JController {
      function __construct() {
        $path = JPATH_COMPONENT_ADMINISTRATOR.DS.'views';
        $this->addViewPath($path);
        $path = JPATH_COMPONENT_ADMINISTRATOR.DS.'models';
        $this->addModelPath($path);
        parent::__construct();
      }
      /**
       * Display
       */
}

?>
