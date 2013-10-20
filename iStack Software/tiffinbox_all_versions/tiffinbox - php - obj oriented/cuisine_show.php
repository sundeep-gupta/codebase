<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
require_once 'Connection.php';

session_start();
if (!isset($_SESSION['userid'])) {
    include("index.php");
    exit;
}
$conn = Connection::get_connection();
if ($conn == null) {
    exit;
}
$query = "SELECT ID, NAME, PRICE, DESCRIPTION FROM CUISINE";
$statement = $conn->prepare($query);
$statement->execute();
while($result = $statement->fetch()) {
    echo $result['ID'].",".$result['NAME'].",".$result['PRICE'].",".$result['DESCRIPTION'];
}
?>
