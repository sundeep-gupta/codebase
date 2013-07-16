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
        Title: <?php echo($this->posts['title']); ?><br>
        Desc: <?php echo($this->posts['body']); ?><br/>
        Date: <?php echo($this->posts['date_posted']); ?><br/>
        <?php
            if( isset($this->posts['comments']) ) {
                echo '<ul>';
                foreach ($this->posts['comments'] as $comment) {
                    echo('<li>' . $comment['body'] . ' <a href="' . createURL("comments", "delete", $this->posts['id'], $comment['id']) . '">delete</a></li>');
                }
                echo '</ul>';
            }
        ?>
        <a href="<?php echo createURL("posts", "edit", $this->posts['id']); ?>">Edit</a>
        <a href="<?php echo createURL("posts", "delete", $this->posts['id']); ?>">Delete</a>
        <a href="<?php echo createURL("comments", "create", $this->posts['id']); ?>">Add Comment</a>
        <a href="<?php echo createURL("posts"); ?>">Posts Index</a>
    </body>
</html>