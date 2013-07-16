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
    <?php foreach ($this->posts as $post) { ?>
    <h1><a href="<?php echo createURL("posts", "view", $post['id']); ?>"><?php echo($post['title']); ?></a></h1>
    <h2><?php echo($post['body']); ?></h2>
    <hr>

    <?php } ?>
    <a href="<?php echo createURL("posts", "create"); ?>">Create New Post</a>
    </body>
</html>
