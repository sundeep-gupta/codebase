<?php
// ensure a valid entry point
defined('_JEXEC') or die('Restricted Access in view');
// import the JModel class
jimport('joomla.application.component.model');
/**
* Foobar Model
*/
class MovieListerModelMovie extends JModel {
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
   function getMovies() {
       if($this->_loadMovies()) {
          return $this->_movie;
       }
       return;
   }

   function _loadMovies() {
     if(empty($this->_movie)) {
       $query = $this->_buildQuery();
       $this->_db->setQuery($query);
       $this->_movie = $this->_db->loadObject();
       return (boolean) $this->_movie;
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