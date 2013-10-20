<?php

// ensure a valid entry point
defined('_JEXEC') or die('Restricted Access in view');
// import the JModel class
jimport('joomla.application.component.model');
/**
* Foobar Model
*/
class PhunshukModelList extends JModel {
   /**
    * @var int
    */
    var $_account;

   /**
    * @var Object
    */
   var $_list;
   function __construct() {
       parent::__construct();
   }
/*
    * Gets Movie List
    * @return Object
    */
   function getAccount() {
     if( $this->_loadAccount()) {
     	return $this->_account;
     }
   	 return;
   }

   function _loadAccount() {
     if(empty($this->_account)) {
       $query = $this->_buildQuery();
       $this->_db->setQuery($query);
       $this->_account = $this->_db->loadObject();
       return (boolean) $this->_account;
     }
     return true;
   }
   function _buildQuery() {
   	 $user =& JFactory::getUser();
     $this->_db =& $this->getDBO();
     $query = "SELECT a.balance as balance, m.name as food ". 
      "FROM #__phunshuk_account a, #__phunshuk_subscription s, #__phunshuk_menu m ".
      "WHERE a.id = ". $user->id. " and s.id = a.current_sub_id and s.menu_id = m.id";
     return $query;
   }

}
?>