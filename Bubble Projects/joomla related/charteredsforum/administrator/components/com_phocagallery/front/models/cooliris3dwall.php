<?php
/*
 * @package Joomla 1.5
 * @copyright Copyright (C) 2005 Open Source Matters. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.php
 *
 * @component Phoca Gallery
 * @copyright Copyright (C) Jan Pavelka www.phoca.cz
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL
 */
defined('_JEXEC') or die();
jimport('joomla.application.component.model');

class PhocagalleryModelCooliris3DWall extends JModel
{

	function __construct() {
		parent::__construct();
	}	
	
	function getCategory($id) {
		
		global $mainframe;
		if ($id > 0) {
			
			$query = 'SELECT c.*,' .
				' CASE WHEN CHAR_LENGTH(c.alias) THEN CONCAT_WS(\':\', c.id, c.alias) ELSE c.id END as slug '.
				' FROM #__phocagallery_categories AS c' .
				' WHERE c.id = '. (int) $id;
			$this->_db->setQuery($query, 0, 1);
			$category = $this->_db->loadObject();
			
			$user = &JFactory::getUser();
			// USER RIGHT - ACCESS - - - - - -
			$rightDisplay	= 1;//default is set to 1 (all users can see the category)
			if (!empty($category)) {
				$rightDisplay = PhocaGalleryAccess::getUserRight('accessuserid', $category->accessuserid, $category->access, $user->get('aid', 0), $user->get('id', 0), 0);
			}
			
			if ($rightDisplay == 0) {
				$mainframe->redirect(JRoute::_('index.php?option=com_user&view=login', false), JText::_("ALERTNOTAUTH"));
				exit;
			}
			// - - - - - - - - - - - - - - - -
			return $category;
		}
		return false;
	}
}
?>