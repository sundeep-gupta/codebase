<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
    </head>
    <body>
        <h1><?php echo get_status(); ?></h1>
        <h1>Create New Post</h1>
        <form name="create_post" action="<?php echo createURL("posts", "edit"); ?>" method="POST">
            Title: <input type="text" name="title" value="<?php echo($this->posts['title']); ?>" /><br/>
            Body: <input type="text" name="body" value="<?php echo($this->posts['body']); ?>" />
            <input type="hidden" name="date_posted" value="<?php echo($this->posts['date_posted']); ?>" />
            <input type="hidden" name="id" value="<?php echo($this->posts['id']); ?>" />
            <input type="submit" name="submit" value="Submit" />
        </form>
    </body>
</html>
