<?php
// ensure a valid entry point
#defined('_JEXEC') or die('Restricted Access');

// import the JView class
jimport('joomla.application.component.view');
/**
* List View
*/

class MovieListerViewList extends JView {
  function __construct() {
    parent::__construct();
  }
  function display($tmpl  = null) {

    $list =& $this->get('List');
    $this->assignRef('List',$list);
    parent::display($tmpl);

  }

}?>