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

// Check to ensure this file is included in Joomla!
defined('_JEXEC') or die();

jimport('joomla.application.component.model');

class PhocaGalleryModelInfo extends JModel
{

	function __construct() {
		parent::__construct();
		$id 	= JRequest::getVar('id', 0, '', 'int');
		$this->setId((int)$id);
		$post	= JRequest::get('get');
	}
	
	function setId($id){
		$this->_id			= $id;
		$this->_data		= null;
	}
	
	function &getData() {
		// Load the Phoca gallery data
		if (!$this->_loadData()) {
			$this->_initData();
		}
		return $this->_data;
	}
	
	function _loadData() {
		global $mainframe;
		$user 		=& JFactory::getUser();
		// Lets load the content if it doesn't already exist
		if (empty($this->_data)) {
			// First try to get image data
			$query = 'SELECT a.title, a.filename, a.description,'
				.' CASE WHEN CHAR_LENGTH(c.alias) THEN CONCAT_WS(\':\', c.id, c.alias) ELSE c.id END as catslug,'
				.' CASE WHEN CHAR_LENGTH(a.alias) THEN CONCAT_WS(\':\', a.id, a.alias) ELSE a.id END as slug'
				.' FROM #__phocagallery AS a'
				.' LEFT JOIN #__phocagallery_categories AS c ON c.id = a.catid'
				.' WHERE a.id = '. (int) $this->_id;
			$this->_db->setQuery($query, 0, 1);
			$this->_data 	= $this->_db->loadObject();
			
			/*
			if (isset($image->description) && $image->description != '') {
				$this->_data['description'] = $image->description;
			} else {
				$this->_data['description'] = '';
			}*/
			
			return (boolean) $this->_data;	
		}
		return true;
	}
	
	
	function _initData() {
		if (empty($this->_data)) {
			$this->_data	= '';
			return (boolean) $this->_data;
		}
		return true;
	}
}
?>