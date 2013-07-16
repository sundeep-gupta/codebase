<?php
// ensure a valid entry point
defined('_JEXEC') or die('Restricted Access in view');
// import the JModel class
jimport('joomla.application.component.model');
/**
* Foobar Model
*/
class PhunshukModelSubscription extends JModel {
   /**
    * @var int
    */
    var $_playId;
    var $_movieId;
    var $_day;

   /**
    * @var Object
    */
   var $_play;
   function __construct() {
       parent::__construct();
   }
   /**
    * Gets Movie List
    * @return Object
    */
   function getSubscription() {
       if($this->_loadSubscription()) {
          return $this->_subscription;
       }
       return;
   }

   function _loadSubscription() {
     if(empty($this->_subscription)) {
       $query = $this->_buildQuery();
       $this->_db->setQuery($query);
       $this->_subscription = $this->_db->loadObject();
       return (boolean) $this->_subscription;
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