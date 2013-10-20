<?php
// ensure a valid entry point
defined('_JEXEC') or die('Restricted Access');

// import the JView class
jimport('joomla.application.component.view');
jimport('joomla.html.html');
/**
* List View
*/
class PhunshukViewUser extends JView {
   function __construct() {
    parent::__construct();
  }
  function display($tmpl  = null) {
#    $mgr =& $this->get('Manager');
    $user =& $this->get('user');

    $this->assignRef('user',$user);
    $this->_initToolbar();

    parent::display($tmpl);

  }
  function _initToolbar() {
		JToolBarHelper::trash();
		JToolBarHelper::editListX();
		JToolBarHelper::addNewX('newItem');
//		JToolBarHelper::help( 'screen.menus' );

		$document = & JFactory::getDocument();
		$document->setTitle(JText::_('View Menu Items'));
  }



}?>