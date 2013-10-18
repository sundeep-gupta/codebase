<?php

######################################################################################
#
# Copyright:     Key Labs, 2005
# Created By:    Author: Jason Smallcanyon
# Revision:      $Revision: 1.1.1.1 $
# Last Modified: $Date: 2005/09/28 23:31:11 $
# Modified By:   $Author: jason $
# Source:        $Source: /cvsroot/orbitaldata/control/php-lib/modules/sort.php,v $
#
######################################################################################



class sortOrder {


    // Define the following variables
    var $SORT_IMAGE;
    var $SORT_OPT;


    function sortOrder($BASEURL) {
    	// Object constructor
        $this->BASEURL = $BASEURL;
    }

    //
    // defineSortLink() - Returns the sorting link (url) based upon the given sort type and direction (ascending or descending)
    // Input:  $URL - String containing the front portion of the url of our link
    // Output: String containing the entire sorting link (url)
    function defineSortLink($URL, $SortBy='') {
        // Define which sort option to use
        if (isset($SortBy) && $SortBy != "") {
            $this->SORT_OPT = $SortBy;
        }
        else {
            $this->SORT_OPT = "undefined";
        }
        
        // Check if our url contains a query string already
        if (preg_match("/\?/", $URL)) {
            $sortLink = $URL . "&sort=" . $this->SORT_OPT;
        }
        else {
            $sortLink = $URL . "?sort=" . $this->SORT_OPT;
        }

        // Next, we define whether we ascend or descend
        if (isset($_GET['direction']) && $_GET['direction'] == "desc") {
            $sortLink .= "&direction=asc";
            $this->SORT_IMAGE = $this->defineSortImage("desc");
        }
        else if (isset($_GET['direction']) && $_GET['direction'] == "asc") {
            $sortLink .= "&direction=desc";
            $this->SORT_IMAGE = $this->defineSortImage("asc");
        }
        else {
            $sortLink .= "&direction=desc";
            $this->SORT_IMAGE = $this->defineSortImage("asc");
        }

        return ($sortLink);
    }
    
    //
    // defineSortImage() - Returns the current sorting image (GIF arrow pointing up or down)
    // Input:  $direction - Direction of our sort (ascending or descending)
    // Output: String containing the url of the image
    function defineSortImage($direction) {
        // Define the ascending and descending images.
        $link  = $this->BASEURL."includes/images/".$direction."_order.gif";
        
        if (isset($_GET['sort']) && $_GET['sort'] == $this->SORT_OPT && (isset($_GET['direction']))) {
            $image = "<img src=\"$link\" class=\"sortImg\" alt=\"Sort ".$this->SORT_OPT."\" />";
        }
        else {
            $image = "";
        }
        
        return $image;
    }

}

    $mySortOrder = &new sortOrder($myConfig->BASEURL);

?>
