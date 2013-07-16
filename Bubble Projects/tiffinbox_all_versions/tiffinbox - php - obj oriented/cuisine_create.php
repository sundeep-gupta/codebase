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
        $name = $_POST['name'];
        $price = $_POST['price'];
        $desc = $_POST['description'];
        // TODO : Validate the values. For now assume they are correct
        // Now create a Cuisine object and create it.
        $cuisine = new Cuisine();
        $cuisine->set_name($name);
        $cuisine->set_price($price);
        $cuisine->set_desc($desc);
        if($cuisine->exists()) {
            echo "Cuisine already exists";
            exit;
        }
        // add code to create cuisine.
        $cuisine->create();
        echo "Cuisine Added";
        exit;
    } 
}
?>
<html>
    <head><title>Enter Cuisine Menu</title></head>
    <body>
        <form method ="POST" action="cuisine_create.php">
            Cuisine Name : <input name="name" value=""/><br/>
            Price : <input name="price" value=""/><br/>
            Description : <input id="menuitems" type="textbox" name="description" value=""/><br/>
            <input type="submit" name="submit" value="Submit"/>
        </form>
    </body>
</html>
