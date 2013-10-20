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

class PhocaGalleryCpModelPhocaGalleryC extends JModel
{
	var $_XMLFile;
	var $_id;
	var $_data;
	
	function __construct() {
		parent::__construct();
		$cid = JRequest::getVar('cid',  0, '', 'array');
		$this->setId((int)$cid[0]);
	}

	function setId($id) {
		$this->_id		= $id;
		$this->_data	= null;
	}

	function &getData() {
		if ($this->_loadData()) {
		} else {
			$this->_initData();
		}
		return $this->_data;
	}
	
	function isCheckedOut( $uid=0 ) {
		if ($this->_loadData()) {
			if ($uid) {
				return ($this->_data->checked_out && $this->_data->checked_out != $uid);
			} else {
				return $this->_data->checked_out;
			}
		}
	}

	function checkin() {
		if ($this->_id) {
			$table = & $this->getTable();
			if(! $table->checkin($this->_id)) {
				$this->setError($this->_db->getErrorMsg());
				return false;
			}
		}
		return false;
	}

	function checkout($uid = null) {
		if ($this->_id) {
			if (is_null($uid)) {
				$user	=& JFactory::getUser();
				$uid	= $user->get('id');
			}
			$table = & $this->getTable();
			if(!$table->checkout($uid, $this->_id)) {
				$this->setError($this->_db->getErrorMsg());
				return false;
			}
			return true;
		}
		return false;
	}
	
	function store($data) {
		
		if ($data['alias'] == '') {
			$data['alias'] = $data['title'];
		}
		$data['alias'] = PhocaGalleryText::getAliasName($data['alias']);
		
		$row =& $this->getTable();
		
		// Bind the form fields to the table
		if (!$row->bind($data)) {
			$this->setError($this->_db->getErrorMsg());
			return false;
		}

		if (!$row->date) {
			$row->date = gmdate('Y-m-d H:i:s');
		}
		
		// if new item, order last in appropriate group
		if (!$row->id) {
			$where = 'parent_id = ' . (int) $row->parent_id ;
			$row->ordering = $row->getNextOrder( $where );
		}

		// Make sure the table is valid
		if (!$row->check()) {
			$this->setError($this->_db->getErrorMsg());
			return false;
		}

		// Store the table to the database
		if (!$row->store()) {
			$this->setError($this->_db->getErrorMsg());
			return false;
		}
		return $row->id;
	}
	
	/*
	 * AUTHOR
	 * Store information about author (if administrator add a category to some author
	 */
	function storeUserCategory($data) {
		
		// DELETE this category from other users
		// If this category will be added to USER 1, it must be removed from USER 2
		$db =& JFactory::getDBO();
		$query = 'DELETE FROM #__phocagallery_user_category'
			. ' WHERE catid = '.(int)$data['catid']
			. ' AND userid <> '.(int)$data['userid'];
			
		$db->setQuery( $query );
		if (!$db->query()) {
			$this->setError($this->_db->getErrorMsg());
			return false;
		}
		//
		
		$row =& $this->getTable('phocagalleryusercategory');
		
		// Bind the form fields to the Phoca gallery table
		if (!$row->bind($data)) {
			$this->setError($this->_db->getErrorMsg());
			return false;
		}

		// Make sure the Phoca gallery table is valid
		if (!$row->check()) {
			$this->setError($this->_db->getErrorMsg());
			return false;
		}

		// Store the Phoca gallery table to the database
		if (!$row->store()) {
			$this->setError($this->_db->getErrorMsg());
			return false;
		}
		
		return $row->id;
		
	}
	
	/*
	 * AUTHOR
	 * Get information about author's category
	 */
	function getUserCategoryId($userId) {
		
		$db =& JFactory::getDBO();

		$query = 'SELECT uc.id'
			. ' FROM #__phocagallery_user_category AS uc'
			. ' WHERE uc.userid = '.(int)$userId;
		
		$db->setQuery( $query );
		$userCategoryId = $db->loadObject();
		if (!isset($userCategoryId->id)) {
			return false;
		}
		return $userCategoryId->id;
	}
	
	function accessmenu($id, $access) {
		global $mainframe;
		$row =& $this->getTable();
		$row->id = $id;
		$row->access = $access;

		if ( !$row->check() ) {
			$this->setError($this->_db->getErrorMsg());
			return false;
		}
		if ( !$row->store() ) {
			$this->setError($this->_db->getErrorMsg());
			return false;
		}
	}

	function delete($cid = array()) {
		global $mainframe;
		$db =& JFactory::getDBO();
		
		$result = false;
		if (count( $cid )) {
			JArrayHelper::toInteger($cid);
			$cids = implode( ',', $cid );
			
			// FIRST - if there are subcategories - - - - - 	
			$query = 'SELECT c.id, c.name, c.title, COUNT( s.parent_id ) AS numcat'
			. ' FROM #__phocagallery_categories AS c'
			. ' LEFT JOIN #__phocagallery_categories AS s ON s.parent_id = c.id'
			. ' WHERE c.id IN ( '.$cids.' )'
			. ' GROUP BY c.id'
			;
			$db->setQuery( $query );
				
			if (!($rows2 = $db->loadObjectList())) {
				JError::raiseError( 500, $db->stderr('Load Data Problem') );
				return false;
			}

			// Add new CID without categories which have subcategories (we don't delete categories with subcat)
			$err_cat = array();
			$cid 	 = array();
			foreach ($rows2 as $row) {
				if ($row->numcat == 0) {
					$cid[] = (int) $row->id;
				} else {
					$err_cat[] = $row->title;
				}
			}
			// - - - - - - - - - - - - - - -
			
			// Images with new cid - - - - -
			if (count( $cid )) {
				JArrayHelper::toInteger($cid);
				$cids = implode( ',', $cid );
			
				// Select id's from phocagallery tables. If the category has some images, don't delete it
				$query = 'SELECT c.id, c.name, c.title, COUNT( s.catid ) AS numcat'
				. ' FROM #__phocagallery_categories AS c'
				. ' LEFT JOIN #__phocagallery AS s ON s.catid = c.id'
				. ' WHERE c.id IN ( '.$cids.' )'
				. ' GROUP BY c.id';
			
				$db->setQuery( $query );

				if (!($rows = $db->loadObjectList())) {
					JError::raiseError( 500, $db->stderr('Load Data Problem') );
					return false;
				}
				
				$err_img = array();
				$cid 	 = array();
				foreach ($rows as $row) {
					if ($row->numcat == 0) {
						$cid[] = (int) $row->id;
					} else {
						$err_img[] = $row->title;
					}
				}
				
				if (count( $cid )) {
					$cids = implode( ',', $cid );
					$query = 'DELETE FROM #__phocagallery_categories'
					. ' WHERE id IN ( '.$cids.' )';
					$db->setQuery( $query );
					if (!$db->query()) {
						$this->setError($this->_db->getErrorMsg());
						return false;
					}
					
					// Delete items in phocagallery_user_category
					$query = 'DELETE FROM #__phocagallery_user_category'
					. ' WHERE catid IN ( '.$cids.' )';
					$db->setQuery( $query );
					if (!$db->query()) {
						$this->setError($this->_db->getErrorMsg());
						return false;
					}
				}
			}
			
			// There are some images in the category - don't delete it
			$msg = '';
			if (count( $err_cat ) || count( $err_img )) {
				if (count( $err_cat )) {
					$cids_cat = implode( ", ", $err_cat );
					$msg .= JText::sprintf( 'WARNNOTREMOVEDRECORDS PHOCA GALLERY CAT', $cids_cat );
				}
				
				if (count( $err_img )) {
					$cids_img = implode( ", ", $err_img );
					$msg .= JText::sprintf( 'WARNNOTREMOVEDRECORDS PHOCA GALLERY', $cids_img );
				}
				$link = 'index.php?option=com_phocagallery&view=phocagallerycs';
				$mainframe->redirect($link, $msg);
			}
		}
		return true;
	}

	function publish($cid = array(), $publish = 1) {
		
		$user 	=& JFactory::getUser();
		if (count( $cid )) {
			JArrayHelper::toInteger($cid);
			$cids = implode( ',', $cid );

			$query = 'UPDATE #__phocagallery_categories'
				. ' SET published = '.(int) $publish
				. ' WHERE id IN ( '.$cids.' )'
				. ' AND ( checked_out = 0 OR ( checked_out = '.(int) $user->get('id').' ) )';
				
			$this->_db->setQuery( $query );
			if (!$this->_db->query()) {
				$this->setError($this->_db->getErrorMsg());
				return false;
			}
		}
		return true;
	}

	function move($direction) {
		$row =& $this->getTable();
		if (!$row->load($this->_id)) {
			$this->setError($this->_db->getErrorMsg());
			return false;
		}

		if (!$row->move( $direction, ' parent_id = '.(int) $row->parent_id.' AND published >= 0 ' )) {
			$this->setError($this->_db->getErrorMsg());
			return false;
		}
		return true;
	}
	
	function saveorder($cid = array(), $order){
		$row 		=& $this->getTable();
		$groupings 	= array();

		// $catid is null -  update ordering values
		for( $i=0; $i < count($cid); $i++ ) {
			$row->load( (int) $cid[$i] );
			$groupings[] = $row->parent_id; // track categories

			if ($row->ordering != $order[$i]) {
				$row->ordering = $order[$i];
				if (!$row->store()) {
					$this->setError($this->_db->getErrorMsg());
					return false;
				}
			}
		}

		// execute updateOrder for each parent group
		$groupings = array_unique( $groupings );
		foreach ($groupings as $group){
			$row->reorder('parent_id = '.(int) $group);
		}
		return true;
	}
	
	function _loadData() {
		if (empty($this->_data)) {		
			$query = 'SELECT p.*, uc.userid AS userid '	
					.' FROM #__phocagallery_categories AS p'
					.' LEFT JOIN #__phocagallery_user_category AS uc ON uc.catid = p.id'
					.' WHERE p.id = '.(int) $this->_id;
			$this->_db->setQuery($query);
			$this->_data = $this->_db->loadObject();
			return (boolean) $this->_data;
		}
		return true;
	}
	
	function _initData() {
		if (empty($this->_data)) {
			$table = new stdClass();
			$table->id				= 0;
			$table->parent_id		= 0;
			$table->title			= null;
			$table->name			= null;
			$table->alias			= null;
			$table->image			= null;
			$table->section        	= null;
			$table->image_position	= null;
			$table->description		= null;
			$table->date			= null;
			$table->published		= 0;
			$table->checked_out		= 0;
			$table->checked_out_time= 0;
			$table->editor			= null;
			$table->ordering		= 0;
			$table->access			= 0;
			$table->hits			= 0;
			$table->count			= 0;
			$table->params			= null;
			$table->userid			= 0;
			$table->accessuserid	= null;
			$table->uploaduserid	= null;
			$table->deleteuserid	= null;
			$table->userfolder		= null;
			$table->latitude		= null;
			$table->longitude		= null;
			$table->zoom			= null;
			$table->geotitle		= null;
			$this->_data			= $table;
			return (boolean) $this->_data;
		}
		return true;
	}

	
	function piclens($cids) {
		$db 		=& JFactory::getDBO();
		$path 		= PhocaGalleryPath::getPath();
		$piclensImg = $path->image_rel_front.'phoca-piclens.png';
		$paramsC= JComponentHelper::getParams('com_phocagallery') ;
		
		// PARAMS
		$piclens_image 	= $paramsC->get( 'piclens_image', 1);
		
		if (JFolder::exists($path->image_abs)) {  
			
			foreach ($cids as $kcid =>$vcid) {
				$this->setXMLFile();
				
				if (!$this->_XMLFile) {
					$this->setError( 'Could not create XML builder' );
					return false;
				}
						
				if (!$node = $this->_XMLFile->createElement( 'rss' )) {
					$this->setError( 'Could not create node!' );
					return false;
				}
				
				$node->setAttribute( 'xmlns:media', 'http://search.yahoo.com/mrss' );
				$node->setAttribute( 'xmlns:atom', 'http://www.w3.org/2005/Atom' );
				$node->setAttribute( 'version', '2.0' );
				
				$this->_XMLFile->setDocumentElement( $node );
				
				if (!$root =& $this->_XMLFile->documentElement) {
					$this->setError( 'Could not obtain root element!' );
					return false;
				}
			
				$channel =& $this->_XMLFile->createElement( 'channel' );
				$atomIcon=& $this->_XMLFile->createElement( 'atom:icon' );
				$atomIcon->setText( JURI::root() . $piclensImg );
				$channel->appendChild( $atomIcon );	
				
				$query = 'SELECT a.id, a.title, a.filename, a.description'
				. ' FROM #__phocagallery AS a'
				. ' WHERE a.catid = '.(int)$vcid
				. ' AND a.published = 1'
				. ' ORDER BY a.catid, a.ordering';
				
				$db->setQuery($query);
				$rows = $db->loadObjectList();
				
				foreach ($rows as $krow => $vrow) {
					$file 		= PhocaGalleryFileThumbnail::getOrCreateThumbnail($vrow->filename, '');	
					$thumbFile	= str_replace( "administrator", "",  $file['thumb_name_l_no_rel']);
					$origFile	= str_replace( "administrator", "",  $file['name_original_rel']);					

					
					$item=& $this->_XMLFile->createElement( 'item' );
					$item->appendChild( $this->_buildXMLElement( 'title', $vrow->title ) );

					
					$item->appendChild( $this->_buildXMLElement( 'link', JURI::root().$thumbFile ) );
					
					$item->appendChild( $this->_buildXMLElement( 'media:description', $vrow->description  ) );
					$thumbnail=& $this->_XMLFile->createElement( 'media:thumbnail' );
					$thumbnail->setAttribute( 'url', JURI::root().$thumbFile );
					
					$content=& $this->_XMLFile->createElement( 'media:content' );
					if ($piclens_image == 1) {
						$content->setAttribute( 'url', JURI::root().$thumbFile );
					} else {
						$content->setAttribute( 'url', JURI::root().$origFile );
					}
					
					
					
					$item->appendChild( $thumbnail );
					$item->appendChild( $content );
					
					$guid=& $this->_XMLFile->createElement( 'guid' );
					$guid->setText( $vcid .'-phocagallerypiclenscode-'.$vrow->filename );
					$guid->setAttribute( 'isPermaLink', "false" );
					$item->appendChild( $guid );
					
					$channel->appendChild( $this->_buildXMLElement(  'title', 'Phoca Gallery' ));
					$channel->appendChild( $this->_buildXMLElement( 'link', 'http://www.phoca.cz/' ));
					$channel->appendChild( $this->_buildXMLElement( 'description', 'Phoca Gallery' ));
					
					$channel->appendChild( $item );
				}

				$root->appendChild( $channel );	 
			
				$this->_XMLFile->setXMLDeclaration( '<?xml version="1.0" encoding="utf-8" standalone="yes"?>' );
				
				//echo $this->_XMLFile->toNormalizedString( true );exit;
				// saveXML_utf8 doesn't save setXMLDeclaration
				/*if (!$this->_XMLFile->saveXML( $path->image_abs . DS . $vcid.'.rss', true )) {
					$this->setError( 'Could not save XML file!' );
					return false;
				}*/
				ob_start();
				echo $this->_XMLFile->toNormalizedString(false, true);
				$xmlToWrite = ob_get_contents();
				ob_end_clean();
				if(!JFile::write( $path->image_abs . DS . $vcid.'.rss', $xmlToWrite)) {
					$this->setError( 'Could not save XML file!' );
					return false;
				}
			}
			return true;
		} else {
			$this->setError( 'Phoca Gallery image folder not exists' );
		}
	}
	
	function setXMLFile() {
		$this->_XMLFile =& JFactory::getXMLParser();
	}
	
	function &_buildXMLElement( $elementName, $text ) {
		$node = $this->_XMLFile->createElement( $elementName );
		$node->setText( $text );
		return $node;
	}
}
?>