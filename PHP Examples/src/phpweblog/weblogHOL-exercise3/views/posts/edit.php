<?php
include dirname(__FILE__) . '/../common/header.php';
?>
            <h1>Edit Post</h1>
            <form name="create_post" action="<?php echo createURL("posts", "edit"); ?>" method="POST">
                Title: <input type="text" name="title" value="<?php echo($this->posts['title']); ?>" /><br/>
                Body: <textarea cols="50" rows="4" name="body"><?php echo($this->posts['body']); ?></textarea>
                <input type="hidden" name="date_posted" value="<?php echo($this->posts['date_posted']); ?>" />
                <input type="hidden" name="id" value="<?php echo($this->posts['id']); ?>" />
                <input type="submit" name="submit" value="Submit" />
            </form>
<?php
include dirname(__FILE__) . '/../common/footer.php';
?>