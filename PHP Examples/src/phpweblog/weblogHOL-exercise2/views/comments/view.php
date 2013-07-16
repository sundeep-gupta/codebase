<!--
To change this template, choose Tools | Templates
and open the template in the editor.
-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>
        </title>
    </head>
    <body>
        <h1><?php echo get_status(); ?></h1>
        Comment: <?php echo($this->comments['body']); ?><br/>
        Date: <?php echo($this->comments['date_posted']); ?><br/>
        
        <a href="<?php echo createURL("comments", "edit", $this->comments['id']); ?>">Edit</a>
        <a href="<?php echo createURL("comments", "delete", $this->comments['id']); ?>">Delete</a>
        <a href="<?php echo createURL("comments"); ?>">Posts Index</a>
    </body>
</html>