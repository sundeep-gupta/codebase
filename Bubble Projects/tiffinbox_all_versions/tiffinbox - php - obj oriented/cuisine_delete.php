<html><body>
<?php
require_once 'Cuisine.php';
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
session_start();
if(!isset($_SESSION['admin'])) {
    $html = "You are not logged in as admin user! Click <a href=\"login.php\">Here</a> to login";
    echo $html;
    exit;
} else {
    if(isset($_POST['name'])) {
        // business logic here.
        $cuisine = new Cuisine();
        $cuisine->set_name($_POST['name']);
        // TODO : Validate the values. For now assume they are correct
        // Now create a Cuisine object and create it.
        if(! $cuisine->exists()) {
            echo "Cuisine does not exists";
        } else {

        // add code to create cuisine.
            $cuisine->delete();
            echo "Cuisine Deleted";
        }
    } else {
        // display the cuisine_Create page
       ?>
<form name="cuisine_delete" method="POST" action="cuisine_delete.php">
    Name : <input type="textox" name="name" value=""/><br/>
    <input name="delete" type="submit" value="Delete"/>
</form>
        <?php
    }
}
?>
</body>
</html>
