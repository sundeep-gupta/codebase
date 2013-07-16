<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of Base_Model
 *
 * @author justinbolter
 */
class Base_Model {
    /**
     *
     * @var DataAccess
     */
    protected $dao;

    function __construct() {
        $this->dao = DataAccess::getInstance();
    }
}
?>
