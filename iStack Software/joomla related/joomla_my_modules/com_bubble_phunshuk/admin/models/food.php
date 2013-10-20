<?php
// ensure a valid entry point
defined('_JEXEC') or die('Restricted Access in view');
// import the JModel class
jimport('joomla.application.component.model');
/**
* Foobar Model
*/
class PhunshukModelFood extends JModel {
   /**
    * @var int
    */
    var $_cinemaId;
    var $_movieId;
    var $_day;

   /**
    * @var Object
    */
   var $_cinema;
   function __construct() {
       parent::__construct();
   }

   /**
    * Gets Movie List
    * @return Object
    */
   function getFood() {
       if($this->_loadFood()) {
          return $this->_food;
       }
       return;
   }

   function _loadFood() {
     if(empty($this->_food)) {
       $query = $this->_buildQuery();
       $this->_db->setQuery($query);
       $this->_food = $this->_db->loadObject();
       return (boolean) $this->_food;
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
