<?php
/**
 * Copyright (C) 2010 Bubble Inc., All Rights Reserved.
 * @author Sundeep
 */

include("includes.php");

/*
 * Business logic.
 * 1. Check if the user is 
 */
if ( $POST['userid'] ) {
    $user = new User($POST['userid']);
    if (!$user->exists()) {
      /* Display the login page here */
      echo "Login as admin user";
    } else {
	    /* Delete the user */
        $user->delete();
		if ( $user->get_status()) {
            echo "User deleted successfully";
		} else {
            echo "Unable to delete user";
		}
	}
}	
?>
<html>
<body>
  <form method="POST" action="DeleteUser.php">
    Enter user name : <input type="text" name="userid" value=""/>
    <button type="submit" value="Ok">Ok</button>
  </form>
</body>
</html>
