<?php
// ensure a valid entry point
defined('_JEXEC') or die('Restricted Access in view');
// import the JModel class
jimport('joomla.application.component.model');
/**
* Foobar Model
*/
class MovieListerModelList extends JModel {
   /**
    * @var int
    */
    var $_cinemaId;
    var $_movieId;
    var $_day;

   /**
    * @var Object
    */
   var $_list;
   function __construct() {
       parent::__construct();
   }

   function setCinemaId($id = 0) {
      $this->_cinemaId = $id;
   }
   function setMovieId($id = 0) {
       $this->_movieId = $id;
   }
   function setDay($day = 0) {
     $this->_day = $day;
   }

   /**
    * Gets Movie List
    * @return Object
    */
   function getList() {
       if($this->_loadList()) {
          return $this->_list;
       }
       return;
   }

   function _loadList() {
     if(empty($this->_list)) {
       $query = $this->_buildQuery();
       $this->_db->setQuery($query);
       $this->_list = $this->_db->loadObject();
       return (boolean) $this->_list;
     }
     return true;
   }
   function _buildQuery() {
     $this->_db =& $this->getDBO();
     $query = "SELECT * FROM #__CONTENT";
     return $query;
   }

}
?>