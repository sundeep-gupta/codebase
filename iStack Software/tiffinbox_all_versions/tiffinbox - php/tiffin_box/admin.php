<?php

/**
 * @author Sundeep
 * 
 */
 // Check if the user has logged in.
 
// start the session.
 session_start();
 
if (isset($_SESSION['adminid'])) {
     include("admin2.php");
} else {
    include("logn.php");
}
?>

<html>
<head></head>
<body>
<a href="add_user.php">Add User </a>


</body>

</html>
