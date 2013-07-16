<?php
class Session {
    /* Unsets the Contact Info */
    public static function unset_contact() {
/*
	unset($_SESSION['firstname'],
	      $_SESSION['lastname'],
	      $_SESSION['address'],
	      $_SESSION['phone'],
	      $_SESSION['email']);
*/
    }
    
    /* Set Contact into Session */
    public static function set_contact() {

	$_SESSION['firstname'] = $_POST['firstname'];
	$_SESSION['lastname']  = $_POST['lastname'];
	$_SESSION['address']   = $_POST['address'];
	$_SESSION['phone']     = $_POST['phonem'];
	$_SESSION['email']     = $_POST['email'];
    }
}
?>
