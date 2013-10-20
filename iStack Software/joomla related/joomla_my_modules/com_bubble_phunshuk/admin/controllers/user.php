<?php

// Check to ensure this file is included in Joomla!
defined('_JEXEC') or die('Restricted Access');
jimport('joomla.application.component.controller');
/**
* MyExtension Controller
*
*/
class PhunshukConstrollerUser extends JController {
      function __construct() {
        $path = JPATH_COMPONENT_ADMINISTRATOR.DS.'views';
        $this->addViewPath($path);
        parent::__construct();
      }
      /**
       * Display
       */
      function display() {
      // get the Foobar model and increment the counter
         $modelList =& $this->getModel('User');

         // display foobar
         parent::display();
     }
}

?>
