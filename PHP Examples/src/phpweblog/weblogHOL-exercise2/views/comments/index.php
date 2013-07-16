<!--
To change this template, choose Tools | Templates
and open the template in the editor.
-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
    </head>
    <body>
    <h1><?php echo get_status(); ?></h1>
    <?php foreach ($this->comments as $comment) { ?>
    <h1><a href="<?php echo createURL("comments", "view", $comment['id']); ?>"><?php echo($comment['body']); ?></a></h1>
    <h2><?php echo($comment['body']); ?></h2>
    <hr>

    <?php } ?>
    <a href="<?php echo createURL("comments", "create"); ?>">Create New Comment</a>
    </body>
</html>
