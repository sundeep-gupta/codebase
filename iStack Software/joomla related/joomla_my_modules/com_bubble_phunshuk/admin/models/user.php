<?php
// ensure a valid entry point
defined('_JEXEC') or die('Restricted Access in view');
// import the JModel class
jimport('joomla.application.component.model');
/**
* Foobar Model
*/
class PhunshukModelUser extends JModel {
   /**
    * @var int
    */
    var $_movieId;
    var $_day;

   /**
    * @var Object
    */
   var $_movie;
   function __construct() {
       parent::__construct();
   }

   function setUserId($id = 0) {
      $this->_userId = $id;
   }
   function setDay($day = 0) {
     $this->_day = $day;
   }

   /**
    * Gets Movie List
    * @return Object
    */
   function getUsers() {
       if($this->_loadUsers()) {
          return $this->_user;
       }
       return;
   }

   function _loadUsers() {
     if(empty($this->_user)) {
       $query = $this->_buildQuery();
       $this->_db->setQuery($query);
       $this->_user = $this->_db->loadObject();
       return (boolean) $this->_user;
     }
     return true;
   }
   function _buildQuery() {
     $this->_db =& $this->getDBO();
     $query = "SELECT * FROM DUAL";
     return $query;
   }

}
?>