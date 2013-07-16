<html>
<body>
<?php
require_once("DB.php");
$connect_str = "mysqli://root@localhost/test";
$conn = &DB::connect($connect_str);
if (DB::isError ($conn))
echo ("Cannot Connect:".$conn->getMessage()."\n");
else
echo "Happyyyyzzzzz Endingzzzzz$connect_str";
$result =& $conn->query ("CREATE TABLE animal
                             (name CHAR(40), category CHAR(40))");
   if (DB::isError ($result))
     die ("CREATE TABLE failed: " . $result->getMessage () . "\n");
?>
</body>
</html>