<?php
// ensure a valid entry point
defined('_JEXEC') or die('Restricted Access in view');
// import the JModel class
jimport('joomla.application.component.model');
/**
* Foobar Model
*/
class MovieListerModelPlay extends JModel {
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
   function getPlay() {
       if($this->_loadPlay()) {
          return $this->_play;
       }
       return;
   }

   function _loadPlay() {
     if(empty($this->_play)) {
       $query = $this->_buildQuery();
       $this->_db->setQuery($query);
       $this->_play = $this->_db->loadObject();
       return (boolean) $this->_play;
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