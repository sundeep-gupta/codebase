<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
    </head>
    <body>
        <h1><?php echo get_status(); ?></h1>
        <h1>Create New Comment for Post #<?php echo $this->comment->get_post_id(); ?></h1>
        <form name="create_comment" action="<?php echo createURL("comments", "create", $this->comment->get_post_id()); ?>" method="POST">
            Comment: <input type="text" name="body" value="" />
            <input type="hidden" name="post_id" value="<?php echo $this->comment->get_post_id(); ?>" />
            <input type="submit" name="submit" value="Submit" />
        </form>
    </body>
</html>
