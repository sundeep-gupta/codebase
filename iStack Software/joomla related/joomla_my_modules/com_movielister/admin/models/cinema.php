<?php
// ensure a valid entry point
defined('_JEXEC') or die('Restricted Access in view');
// import the JModel class
jimport('joomla.application.component.model');
/**
* Foobar Model
*/
class MovieListerModelCinema extends JModel {
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
   function getCinema() {
       if($this->_loadCinema()) {
          return $this->_cinema;
       }
       return;
   }

   function _loadCinema() {
     if(empty($this->_cinema)) {
       $query = $this->_buildQuery();
       $this->_db->setQuery($query);
       $this->_cinema = $this->_db->loadObject();
       return (boolean) $this->_cinema;
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