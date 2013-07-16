<?php

// expire cookie
setcookie ("loggedin", "", time() - 3600);

echo "You are now logged out.<br>";
echo "<a href=\"logn.php\">Log in</a>.";

?>